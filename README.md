# Markdown to Nexus Mods BBCode (Pandoc)

This tool converts Markdown to the BBCode dialect used by [Nexus Mods](https://www.nexusmods.com).
The conversion is built on Pandoc's native `bbcode` writer, with a custom writer written in Lua.

## Example

Example conversion of the `example.md` file (from `MarkdownToNexusModsBBCode.zip`):
https://www.nexusmods.com/site/articles/261

_Note: Emojis have been replaced because certain emojis currently trigger a 500 error when saving
articles._

## Clone the repository

```shell
git clone --recurse-submodules https://github.com/orax-modding/MarkdownToNexusModsBBCode.git
```

The `--recurse-submodules` option also clones the `types` submodule. If you already cloned the
repository without this option, fetch the submodule from the repository root with:

```shell
git submodule update --init --recursive
```

## Requirements

- [Pandoc](https://pandoc.org/) 3.8.3 or later. The custom writer uses Pandoc's built-in `bbcode`
  output writer, which was added in 3.8.3.
- PowerShell 7 (`pwsh`) to use the wrappers.

## Usage

### Direct Pandoc command

Pandoc manual: https://pandoc.org/MANUAL.html

```shell
# The examples/example.txt file will be created or updated.
pandoc -f gfm -t writers/bbcode-nexusmods.lua --eol=lf examples/example.md -o examples/example.txt

# You can specify a configuration file.
pandoc -f gfm -t writers/bbcode-nexusmods.lua --eol=lf examples/example.md -o examples/example.txt -V config=config/default.lua

# Convert this README file.
pandoc -f gfm -t writers/bbcode-nexusmods.lua --eol=lf README.md -o README.txt
```

### Wrapper scripts

The following examples create or update `examples/example.txt`:

```powershell
# Convert using the default output path.
./MarkdownToNexusModsBBCode.ps1 examples/example.md

# Convert using a custom output path.
./MarkdownToNexusModsBBCode.ps1 examples/example.md examples/example.txt

# Convert using a custom output path and theme.
./MarkdownToNexusModsBBCode.ps1 examples/example.md examples/example.txt config/default.lua
```

The batch file acts as a wrapper for the PowerShell script.

```batchfile
MarkdownToNexusModsBBCode.bat examples\example.md

MarkdownToNexusModsBBCode.bat examples\example.md examples\example.txt

MarkdownToNexusModsBBCode.bat examples\example.md examples\example.txt config\default.lua
```

## Configuration

Heading colors and the inline code font are defined in Lua configuration files under `config/`. The
default configuration is `config/default.lua`.

### Create your own theme

1. Copy `config/default.lua` to `config/my_theme.lua`.
2. Customize parameters such as `headingColors` and `inlineCodeFont`.
3. Pass your theme to Pandoc with the `-V config=...` option:

```shell
pandoc -f gfm -t writers/bbcode-nexusmods.lua --eol=lf examples/example.md -o examples/example.txt -V config=config/my_theme.lua
```

## Conversions

### YouTube

The `[ youtube ]` BBCode tag displays a video preview. If you prefer a regular text link, you can
avoid embedding the preview.

For example, both Markdown links (`https://www.youtube.com/watch?v=ID` and
`[https://www.youtube.com/watch?v=ID](https://www.youtube.com/watch?v=ID)`) are converted to
`[ youtube ]ID[ /youtube ]`, which displays a video preview.

If you want a text link instead, make the link text different from the URL. For example,
`[youtube.com/watch?v=ID](https://www.youtube.com/watch?v=ID)` is converted to
`[url=https://www.youtube.com/watch?v=ID]youtube.com/watch?v=ID[/url]`.

## Other tools

Converter.MarkdownToBBCode - https://github.com/BUTR/Converter.MarkdownToBBCode
