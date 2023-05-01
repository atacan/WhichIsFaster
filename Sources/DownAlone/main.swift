//
// https://github.com/atacan
// 01.05.23
	

import Benchmark
import Ink
import Down

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

var inkParser = Ink.MarkdownParser()

benchmark("Ink") {
    let html = inkParser.html(from: markdownContent)
}

benchmark("Down") {
    let down = Down(markdownString: markdownContent)
    let html = try down.toHTML()
}

print("Down\n---", try! Down(markdownString: markdownContent).toHTML(DownOptions.unsafe), "\n")
print("Ink\n---", inkParser.html(from: markdownContent), "\n")

Benchmark.main()
