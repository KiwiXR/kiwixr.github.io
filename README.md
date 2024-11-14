# Ella-homepage

A Jekyll + Vue3.js solution.

## How it Works

1. write in Markdown
2. Kramdown engine converts contents to HTML
3. Jekyll hook plugin parses HTML tags to customized ones
4. Vue3 implements the customized tags

## Components/Tags Implemented in Vue3

> https://kramdown.gettalong.org/quickref.html

Note that tags not implemented might be influenced by the styles from cdn

nerfies
+ [x] Paragraphs: `CustomP` `<p></p>`
+ [x] Headers
  + [x] `CustomH2` `<h2></h2>`
  + [x] `CustomH3` `<h3></h3>`
+ [ ] Blockquotes
+ [x] Code Blocks: `CustomPreCode` `<pre><code></code></pre>`
+ [ ] Horizontal Rules
+ [ ] Lists
+ [ ] Definition Lists
+ [x] Tables: `CustomTable` `<table>`
+ [ ] Links: **Not Planned** (already wrapped by `<p></p>`)
+ [ ] Images: **Not Planned** (already wrapped by `<p></p>`)
+ [ ] Extras
  + [x] AuthorList
  + [x] LinkList
  + [x] MyTitle
  + [x] NavBar

## Many Thanks to:
+ https://github.com/yaoyao-liu/minimal-light
+ https://github.com/nerfies/nerfies.github.io
+ https://chatgpt.com