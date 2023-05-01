//
// https://github.com/atacan
// 01.05.23
	

import Foundation
import Ccmark
import Benchmark

public func unsafeMark(from markdown: String, options: Int32 = 0) -> String {
  guard
    let cString = cmark_markdown_to_html(
      markdown, markdown.utf8.count, CMARK_OPT_SMART | options
    )
  else { return markdown }
  defer { free(cString) }
  return String(cString: cString)
}

func markdownToHTML(_ markdown: String) -> String {
    guard let markdownCString = markdown.cString(using: .utf8) else {
        fatalError("Failed to convert Markdown string to CString")
    }

    let options = CMARK_OPT_DEFAULT | CMARK_OPT_GITHUB_PRE_LANG | CMARK_OPT_UNSAFE | CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE
    guard let htmlCString = cmark_markdown_to_html(markdownCString, markdown.utf8.count, options) else {
        fatalError("Failed to convert Markdown to HTML")
    }

    defer {
        free(htmlCString)
    }

    let html = String(cString: htmlCString)

    return html
}


let markdownContent = """
---
tags: review, swift, saga
---

# This is the title
This **is** a www.example.com *naked* link, and an email: <info@example.com>
Hard break! ~~strike~~
- List directly attached
- Another list item

> # Title within blockquote!

```swift
print("Hello world")
```
"""

//print(unsafeMark(from: markdownContent))
print(markdownToHTML(markdownContent))

func markdownToHTMLV2(_ markdown: String) -> String {
    guard let markdownCString = markdown.cString(using: .utf8) else {
        fatalError("Failed to convert Markdown string to CString")
    }

    // Initialize cmark-gfm extensions
    let options = CMARK_OPT_DEFAULT | CMARK_OPT_GITHUB_PRE_LANG | CMARK_OPT_UNSAFE | CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE
    let parser = cmark_parser_new(options)

    // Enable strikethrough extension
    if let ext = cmark_find_syntax_extension("strikethrough") {
        cmark_parser_attach_syntax_extension(parser, ext)
    }

    // Parse the Markdown string
    cmark_parser_feed(parser, markdownCString, markdown.utf8.count)
    let document = cmark_parser_finish(parser)

    // Convert the parsed document to an HTML CString
    guard let htmlCString = cmark_render_html(document, options, cmark_parser_get_syntax_extensions(parser)) else {
        fatalError("Failed to convert Markdown to HTML")
    }

    defer {
        free(htmlCString)
        cmark_node_free(document)
        cmark_parser_free(parser)
    }

    guard let html = String(cString: htmlCString) else {
        fatalError("Failed to convert HTML CString to Swift String")
    }

    return html
}

benchmark("cmark gfm") {
    markdownToHTML(markdownContent)
}

Benchmark.main()
