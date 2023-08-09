import Foundation
import Ink
import MarkdownKit
import Parsley

// import Benchmark
// import Maaku
// import cmark_gfm

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

func benchmark(_ title: String, _ run: @escaping () throws -> Void) throws {
    let iterations = 2000
    var totalTime: TimeInterval = 0

    for _ in 0 ..< iterations {
        let startTime = Date()
        try run()
        let endTime = Date()

        let elapsedTime = endTime.timeIntervalSince(startTime)
        totalTime += elapsedTime
    }

    let averageTime = totalTime / Double(iterations)
    let averageTimeInNanoseconds = averageTime * 1_000_000_000
    let formattedTime = String(format: "%.0f", averageTimeInNanoseconds)
    print("\(title) average time: \(formattedTime) nanoseconds")
}

try benchmark("Parsley") {
    let document = try Parsley.parse(markdownContent)
    let html = document.body
}

try benchmark("Ink") {
    let html = inkParser.html(from: markdownContent)
}

try benchmark("MarkdownKit") {
    let markdown = MarkdownParser.standard.parse(markdownContent)
}

// benchmark("Maaku") {
//    let document = try! Maaku.Document(text: markdownContent)
// }

// benchmark("cmark-gfm") {
//    let renderer = cmark_html_renderer()
//    renderer.html(markdownContent)
// }

print("Ink\n---\n", inkParser.html(from: markdownContent))
try print("Parsley\n---\n", Parsley.parse(markdownContent).body)
// print(MarkdownParser.standard.parse(markdownContent))

// Benchmark.main()
