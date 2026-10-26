local format = string.format

local BBCODE_FORMAT = "bbcode"
local MIN_HEADER_LEVEL = 1
local MAX_HEADER_LEVEL = 6
local HEADING_SIZES = { 6, 5, 4, 3, 2, 1 }
local writerDirectory = pandoc.path.directory(PANDOC_SCRIPT_FILE)

if writerDirectory == "" then
	writerDirectory = "."
end

-- Compile a pattern to match YouTube URLs and capture the exact 11-character video ID.
-- Documentation:
-- https://www.inf.puc-rio.br/~roberto/lpeg/re.html
-- https://pandoc.org/lua-filters.html#global-variables
local youtubePattern = re.compile([[
	(
		("https://" / "http://")?
		"www."?
		(
			("youtube.com" / "youtube-nocookie.com") ("/watch?v=" / "/embed/" / "/live/")
			/ "youtu.be/"
			)
		{ [0-9a-zA-Z_-]^11 }
	)
]])

---Load configuration.
---@param opts table
---@return table
local function loadConfig(opts)
	local config = opts.variables.config
	local path = (config and tostring(config)) or "../config/default.lua"

	-- Keep user-supplied relative paths relative to the caller's working directory.
	if config and pandoc.path.is_relative(path) then
		path = pandoc.path.join({ pandoc.system.get_working_directory(), path })
	end

	return pandoc.system.with_working_directory(writerDirectory, function()
		local file = io.open(path)
		if file then
			file:close()
		else
			error("The option file does not exist: " .. path)
		end

		return dofile(path)
	end)
end

---Try to extract the YouTube video ID from a URL.
---@param url string
---@return string?
local function getYoutubeId(url)
	return youtubePattern:match(url)
end

---Documentation:
---https://pandoc.org/custom-writers.html
---https://pandoc.org/lua-filters.html#type-writeroptions
function Writer(doc, opts)
	local cfg = loadConfig(opts)
	local inlineCodeFont = cfg.inlineCodeFont
	local headingColors = cfg.headingColors

	local filter = {
		-- Inline elements https://pandoc.org/lua-filters.html#type-inline

		---@param code Code
		Code = function(code)
			return pandoc.RawInline(
				BBCODE_FORMAT,
				format("[font=%s]%s[/font]", inlineCodeFont, code.text)
			)
		end,

		---@param image Image
		Image = function(image)
			return pandoc.RawInline(BBCODE_FORMAT, format("[img]%s[/img]", image.src))
		end,

		---@param link Link
		Link = function(link)
			-- Ensure the [youtube] tag is only applied when the link text matches the target URL.
			-- The [youtube] BBCode displays a video preview, but sometimes authors might want
			-- to avoid an embed and prefer a regular text link instead.
			-- Examples:
			-- * `https://www.youtube.com/watch?v=ID`
			--   `[youtube]ID[/youtube]`
			-- * `[My video](https://www.youtube.com/watch?v=ID)`
			--   `[url=https://www.youtube.com/watch?v=ID]My video[/url]`
			if pandoc.utils.stringify(link.content) == link.target then
				local youtubeId = getYoutubeId(link.target)
				if youtubeId then
					return pandoc.RawInline(
						BBCODE_FORMAT,
						format("[youtube]%s[/youtube]", youtubeId)
					)
				end
			end

			local txt = pandoc.write(pandoc.Pandoc(pandoc.Plain(link.content)), BBCODE_FORMAT, opts)

			return pandoc.RawInline(BBCODE_FORMAT, format("[url=%s]%s[/url]", link.target, txt))
		end,

		-- Block elements  https://pandoc.org/lua-filters.html#type-block

		---@param codeBlock CodeBlock
		CodeBlock = function(codeBlock)
			return pandoc.RawBlock(BBCODE_FORMAT, format("[code]%s[/code]", codeBlock.text))
		end,

		---@param div Div
		Div = function(div)
			local align = div.attr.attributes["align"]
			if align == "left" or align == "center" or align == "right" then
				local txt = pandoc.write(pandoc.Pandoc(div.content), BBCODE_FORMAT, opts)
				txt = txt:gsub("%s+$", "")

				return pandoc.RawBlock(BBCODE_FORMAT, format("[%s]%s[/%s]", align, txt, align))
			end
		end,

		---@param header Header
		Header = function(header)
			local level = math.min(MAX_HEADER_LEVEL, math.max(MIN_HEADER_LEVEL, header.level))
			local size = ({ 6, 5, 4, 3, 2, 1 })[level]
			local txt =
				pandoc.write(pandoc.Pandoc(pandoc.Plain(header.content)), BBCODE_FORMAT, opts)

			return pandoc.RawBlock(
				BBCODE_FORMAT,
				format(
					"[size=%d][b][color=%s]%s[/b][/color][/size]",
					size,
					headingColors[size],
					txt
				)
			)
		end,

		---@param horizontalRule HorizontalRule
		HorizontalRule = function(horizontalRule)
			return pandoc.RawBlock(BBCODE_FORMAT, "[line]")
		end,
	}

	return pandoc.write(doc:walk(filter), BBCODE_FORMAT, opts)
end

Template = pandoc.template.default(BBCODE_FORMAT)
