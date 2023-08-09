import Benchmark
import Ccmark
import Foundation

public func unsafeMark(from markdown: String, options: Int32 = 0) -> String {
    guard
        let cString = cmark_markdown_to_html(
            markdown,
            markdown.utf8.count,
            CMARK_OPT_SMART | options
        )
    else {
        return markdown
    }
    defer { free(cString) }
    return String(cString: cString)
}

func markdownToHTML(_ markdown: String) -> String {
    guard let markdownCString = markdown.cString(using: .utf8) else {
        fatalError("Failed to convert Markdown string to CString")
    }

    let options =
        CMARK_OPT_DEFAULT | CMARK_OPT_GITHUB_PRE_LANG | CMARK_OPT_UNSAFE | CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE
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

let blogSwiftTooltip = """
    ## Chapter 2
    Bla bla
    <div><h1>mutable</h1> <br>
        can be changed
    </div>

    ```swift
    let hello = "Hello World"

    ```
    ```swift
    let maximumNumberOfLoginAttempts = 10 {!<h1>immutable</h1> <br>
        amazing new things will happen
        or constant variable!}
    var currentLoginAttempt = 0 {!
    <div><h1>mutable</h1> <br>
        can be changed
    </div>
    !}
    {!
    ## This is a title
    this is a parag
    !}
    ```
    """

let simpleTest = "This is a test. <b>Can you see me?</b>"

// print(unsafeMark(from: markdownContent))
print(markdownToHTML(blogSwiftTooltip))
print(markdownToHTML(simpleTest))

benchmark("cmark gfm") {
    markdownToHTML(markdownContent)
}

// Benchmark.main()
