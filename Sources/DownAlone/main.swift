import Benchmark
import Down
import Ink

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

// print("Down\n---", try! Down(markdownString: markdownContent).toHTML(DownOptions.unsafe), "\n")
// print("Ink\n---", inkParser.html(from: markdownContent), "\n")

let blogSwiftTooltip = """
    ## Chapter 2
    Bla bla
    ```swift
    let maximumNumberOfLoginAttempts = 10 {!<h1>immutable</h1> <br>
        amazing new things will happen
        or constant variable!}
    var currentLoginAttempt = 0 {!<h1>mutable</h1> <br>
        can be changed!}
    ```
    """

print("Down---\n", try! Down(markdownString: blogSwiftTooltip).toHTML(DownOptions.unsafe), "\n")

Benchmark.main()
