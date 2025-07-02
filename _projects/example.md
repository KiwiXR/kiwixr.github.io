---
layout: nerfies
authors: Example@
title: "This is an Example for All Kramdown Supported Syntax"
tab_title: Example
aff_mode: "simple"
links:
    example@accept:
    paper@paper:
    code@github:
    video@video: 
    slides@slides:
    poster@poster:
# NavBar
navbar: true
home_link: https://kiwixr.github.io
more_work:
  DUSA: https://kiwixr.github.io/projects/dusa
  VBLC: https://kiwixr.github.io/projects/vblc
  SePiCo: https://binhuixie.github.io/sepico-web/
---

# Quick Reference

## Block-level Elements - Main Structural Elements
{: loc='l'}

### Paragraphs
{: loc='l'}

The first paragraph.

Another paragraph

<hr>

This is a paragraph  
which contains a hard line break.

### Headers
{: loc='l'}

First level header
==================

Second level header
-------------------

<hr>

# H1 header

## H2 header

### H3 header

#### H4 header

##### H5 header

###### H6 header

<hr>

> **KiwiXR:** Uncomment the line in markdown below to see effect

[//]: # ({::options auto_ids="false" /})

# A header without an ID

### Blockquotes
{: loc='l'}

> A sample blockquote.
>
> >Nested blockquotes are
> >also possible.
>
> ## Headers work too
> This is the outer quote again.

<hr>

> This is a blockquote
continued on this
and this line.

But this is a separate paragraph.

### Code Blocks
{: loc='l'}

This is a sample code block.

    Continued here.

<hr>


~~~~~~
This is also a code block.
~~~
Ending lines must have at least as
many tildes as the starting line.
~~~~~~~~~~~~

<hr>

~~~ ruby
def what?
  42
end
~~~

### Horizontal Rules
{: loc='l'}


* * *

---

  _  _  _  _

---------------

### Lists
{: loc='l'}


1. This is a list item
2. And another item
3. And the third one
   with additional text

<hr>

* A list item
  with additional text

<hr>

1.  This is a list item

    > with a blockquote

    # And a header

2.  Followed by another item

<hr>

1. Item one
    1. sub item one
    2. sub item two
    3. sub item three
2. Item two

<hr>

> **KiwiXR:** Note that GFM is enabled, so both of them are in a single list below, but the spacing is in a mess

This is a paragraph.
1. This is NOT a list.

1. This is a list!

<hr>

* Item one
+ Item two
- Item three

### Definition Lists
{: loc='l'}

term
: definition
: another definition

another term
and another term
: and a definition for the term

<hr>

term

: definition
: definition

<hr>

This *is* a term

: This will be a para

> a blockquote

# A header

### Tables
{: loc='l'}

| A simple | table |
| with multiple | lines|

<hr>


| Header1 | Header2 | Header3 |
|:--------|:-------:|--------:|
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|----
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|=====
| Foot1   | Foot2   | Foot3
{: rules="groups"}

### HTML elements
{: loc='l'}

<div style="float: right">
Something that stays right and is not wrapped in a para.
</div>

{::options parse_block_html="true" /}

<div>
This is wrapped in a para.
</div>
<p>
This can contain only *span* level elements.
</p>

### Block Attributes
{: loc='l'}

> A nice blockquote
{: title="Blockquote title"}

<hr>

> A nice blockquote
{: .class1 .class2}

<hr>

> A nice blockquote
{: #with-an-id}

<hr>

{:refdef: .c1 #id .c2 title="title"}
paragraph
{: refdef}

<hr>

{:refdef: .c1 #id .c2 title="title"}
paragraph
{: refdef .c3 title="t" #para}

### Extensions
{: loc='l'}


This is a paragraph
{::comment}
This is a comment which is
completely ignored.
{:/comment}
... paragraph continues here.

Extensions can also be used
inline {::nomarkdown}**see**{:/}!

<hr>

> **KiwiXR:** Uncomment the line in markdown below to see effect

[//]: # ({::options auto_ids="false" /})

# Header without id

### Emphasis
{: loc='l'}

This is *emphasized*,
_this_ too!

<hr>

This is **strong**,
__this__ too!

<hr>

This w**ork**s as expected!

### Links and Images
{: loc='l'}

A [link](http://kramdown.gettalong.org)
to the kramdown homepage.

<hr>

A [link](http://kramdown.gettalong.org "hp")
to the homepage.

<hr>

A [link][kramdown hp]
to the homepage.

[kramdown hp]: http://kramdown.gettalong.org "hp"

<hr>

A link to the [kramdown hp].

[kramdown hp]: http://kramdown.gettalong.org "hp"

<hr>

An image: ![favicon](/favicon.ico)

### Inline Code
{: loc='l'}

Use `Kramdown::Document.new(text).to_html`
to convert the `text` in kramdown
syntax to HTML.

<hr>

Use backticks to markup code,
e.g. `` `code` ``.

<hr>

### Footnotes
{: loc='l'}

This is a text with a
footnote[^1].

[^1]: And here is the definition.

<hr>

This is a text with a
footnote[^2].

[^2]:
    And here is the definition.

    > With a quote!

### Abbreviations
{: loc='l'}


This is an HTML
example.

*[HTML]: Hyper Text Markup Language

### HTML Elements
{: loc='l'}

This is <span style="color: red">written in
red</span>.

### Inline Attributes
{: loc='l'}

This is *red*{: style="color: red"}.

