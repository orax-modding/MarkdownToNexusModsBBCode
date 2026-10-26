# Markdown to Nexus Mods BBCode - Example document

This document tests the conversion from **GitHub Flavored Markdown (GFM)** to **Nexus Mods** BBCode.

- Bold, italic, strikethrough, links, images, lists, tables and code blocks should be converted
  correctly.
- YouTube links should become Nexus Mods `[ youtube ]` tags.
- Unsupported elements should be identified and handled consistently.

---

## 🏷️ Headings

# Heading level 1

## Heading level 2

### Heading level 3

#### Heading level 4

##### Heading level 5

###### Heading level 6

# Heading level 1

## Heading level 2

## 🏷️ Paragraphs and line breaks

This is a simple paragraph.

This is another paragraph separated by a blank line.

This line ends with two spaces  
so the next line should be a hard line break.

This line ends with a backslash so the next line should also be a hard line break.

This paragraph contains multiple source lines that should normally be rendered as soft line breaks.

## 🏷️ Inline formatting

Normal text, **bold text**, _italic text_, **_bold and italic text_**.

This is ~~strikethrough text~~.

This is `inline code`.

This combines **bold with _nested italic_** formatting.

This is a [link to Nexus Mods](https://www.nexusmods.com/).

This is an automatic link: https://www.nexusmods.com/

This is an email autolink: <test@example.com>

This is a link with a title: [Nexus Mods](https://www.nexusmods.com/ "Nexus Mods website").

This is a link containing **bold text**: [**Nexus Mods**](https://www.nexusmods.com/).

## 🏷️ Escaping special characters

These characters should remain literal when escaped:

\*asterisks\*

\_underscores\_

\`backticks\`

\[brackets\]

\# hash

\\ backslash

## 🏷️ Unordered lists

- First item
- Second item
- Third item

Alternative bullet markers:

- Item using an asterisk
- Another item

* Item using a plus sign
* Another item

## 🏷️ Ordered lists

1. First item
2. Second item
3. Third item

Lists starting with another number:

3. Third
4. Fourth
5. Fifth

Lists using parentheses:

1. First item
2. Second item
3. Third item

## 🏷️ Nested lists

- Main item 1
  - Nested item 1.1
  - Nested item 1.2
    - Nested item 1.2.1
- Main item 2
  - Nested item 2.1

1. First main item
   1. First nested item
   2. Second nested item
2. Second main item

## 🏷️ Task lists

- [ ] Unchecked task
- [x] Completed task
- [x] Completed task using uppercase X
- [ ] Task containing **bold text**
- [x] Task containing a [link](https://www.nexusmods.com/)

## 🏷️ Block quotes

> This is a simple block quote.

> This quote contains **bold text** and _italic text_.
>
> It also contains a second paragraph.

> Nested quote:
>
> > This is a nested block quote.
> >
> > It contains multiple paragraphs.

## 🏷️ Horizontal rules

First section.

---

Second section.

---

Third section.

---

Fourth section.

## 🏷️ Code blocks

Inline code: `print("Hello, world!")`

### Fenced code block

```lua
local message = "Hello, world!"
print(message)
```

### Code block with another language

```powershell
$version = "1.0.0"
Write-Output $version
```

### Code block containing backticks

````markdown
```lua
print("This contains backticks")
```
````

### Empty code block

```

```

## 🏷️ Links

### Standard links

[Nexus Mods](https://www.nexusmods.com/)

[GitHub](https://github.com/)

[GitHub Flavored Markdown specification](https://github.github.com/gfm/)

### Reference links

[First reference][nexus]

[Second reference][github]

[nexus]: https://www.nexusmods.com/ "Nexus Mods"
[github]: https://github.com/ "GitHub"

### Autolinks

<https://www.nexusmods.com/>

<https://github.com/>

<mailto:test@example.com>

### URL with query parameters

[Search example](https://example.com/search?q=valheim&sort=date)

## 🏷️ YouTube links

### Standard YouTube URL

https://www.youtube.com/watch?v=NpEaa2P7qZI

### YouTube URL with additional parameters

https://www.youtube.com/watch?v=NpEaa2P7qZI&t=30s

### Short YouTube URL

https://youtu.be/NpEaa2P7qZI

### YouTube embed URL

https://www.youtube.com/embed/NpEaa2P7qZI

### YouTube live URL

https://www.youtube.com/live/NpEaa2P7qZI

### YouTube no-cookie URL

https://www.youtube-nocookie.com/embed/NpEaa2P7qZI

### Text links to YouTube (without preview)

[Watch the video](https://youtu.be/NpEaa2P7qZI)

[Watch the video on YouTube](https://www.youtube.com/watch?v=NpEaa2P7qZI)

### YouTube link with surrounding text

Watch this tutorial: https://youtu.be/NpEaa2P7qZI and follow the instructions.

### YouTube URL inside a paragraph

The video https://youtu.be/NpEaa2P7qZI explains the feature.

## 🏷️ Images

### Standard image

![Example image](https://placehold.co/100 "Example image")

### Image with alt text

![A test image for the Markdown converter](https://placehold.co/100)

### Linked image

[![Example image](https://placehold.co/100)](https://www.nexusmods.com/)

### Image reference

![Reference image][test-image]

[test-image]: https://placehold.co/100 "Reference image"

## 🏷️ Tables

### Simple table

| Feature | Supported | Description     |
| ------- | --------- | --------------- |
| Bold    | Yes       | Strong emphasis |
| Italic  | Yes       | Emphasis        |
| Links   | Yes       | Clickable URLs  |
| Images  | Yes       | Embedded images |

### Table containing formatting

| Element   | Example                                  |
| --------- | ---------------------------------------- |
| Bold      | **Bold text**                            |
| Italic    | _Italic text_                            |
| Strikeout | ~~Removed text~~                         |
| Code      | `print("test")`                          |
| Link      | [Nexus Mods](https://www.nexusmods.com/) |

### Table containing pipes

| Expression | Meaning              |
| ---------- | -------------------- |
| `a \| b`   | A literal pipe       |
| `x \| y`   | Another literal pipe |

## 🏷️ Special characters and entities

Ampersand: &amp;

Less than: &lt;

Greater than: &gt;

Copyright: &copy;

Registered trademark: &reg;

Euro: &euro;

Unicode: é, è, à, ç, œ, Ж, 漢字, 日本語.

Emoji: 😀 🎮 ⚔️ 🛡️ 🔥

## 🏷️ Complex combinations

**Bold text containing a [link](https://www.nexusmods.com/).**

_Italic text containing `inline code`._

~~Strikethrough containing a [link](https://www.nexusmods.com/).~~

> A quote containing **bold**, _italic_, and a [link](https://www.nexusmods.com/).

- List item with **bold text**
- List item with _italic text_
- List item with `inline code`
- List item with a [link](https://www.nexusmods.com/)

1. First item with a nested list:
   - Nested **bold** item
   - Nested _italic_ item
2. Second item containing a [link](https://www.nexusmods.com/)

## 🏷️ Empty and edge cases

An empty link label: [](https://www.nexusmods.com/)

An empty image alt text: ![](https://placehold.co/100)

An empty inline code span: ``

A paragraph containing only a URL:

https://youtu.be/NpEaa2P7qZI

A paragraph containing punctuation after a URL:

https://youtu.be/NpEaa2P7qZI.

A paragraph containing parentheses after a URL:

(https://youtu.be/NpEaa2P7qZI)

A URL with a fragment:

https://example.com/page#section

---

## End of test document
