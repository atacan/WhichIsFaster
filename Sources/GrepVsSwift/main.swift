import Benchmark
import Foundation

// find the file in Resources/ folder of this library and read its content
@discardableResult
func readSync() -> String {
    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
    let content = try! String(contentsOf: url!)
    return content
}

// find the file in Resources/ folder of this library and read its content line by line
@discardableResult
func readAsync() async throws -> String {
    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
    var content = ""
    for try await line in url!.lines {
        content += line
    }
    return content
}

// find the file in Resources/ folder of this library and read its content line by line
// @discardableResult
// func readAsyncWithTask() throws -> String {
//    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
//    let task = Task {
//        var content = ""
//        for try await line in url!.lines {
//            content += line
//        }
//        return content
//    }
//    return task.value
// }

// find the file in Resources/ folder of this library and read its content
@discardableResult
func readSyncContains() -> Bool {
    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
    let content = try! String(contentsOf: url!)
    return content.contains("jury")
}

// find the file in Resources/ folder of this library and read its content line by line
@discardableResult
func readAsyncContains() async throws -> Bool {
    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
    var content = ""
    for try await line in url!.lines {
        if line.contains("jury") {
            return true
        }
        content += line
    }
    return content.contains("jury")
}

func searchLineNumbers(forTerm term: String, inFile fileURL: URL) async throws -> [Int] {
    let lines = fileURL.lines
    var lineNumbers: [Int] = []
    var lineNumber = 1

    for try await line in lines {
        if line.contains(term) {
            lineNumbers.append(lineNumber)
        }
        lineNumber += 1
    }

    return lineNumbers
}

@discardableResult
func readAsyncLinesFind() async throws -> Bool {
    let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")
    let numbers = try await searchLineNumbers(
        forTerm: "jury",
        inFile: Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")!
    )
    return numbers.isEmpty
}

func runCLI(command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.standardInput = nil

    try task.run()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    return output
}

// run grep on command line and search for "jury"
@discardableResult
func grep() throws -> Bool {
    //    let command = "grep --recursive jury " +

    // let command = "grep --recursive jury " + Bundle.module.path(forResource: "some_file", ofType: "txt", inDirectory:
    // "Resources")!
    let command =
        "grep -q jury " + Bundle.module.path(forResource: "some_file", ofType: "txt", inDirectory: "Resources")!
        + #" && echo "true" || echo "false""#
    let output = try runCLI(command: command)
    return output.isEmpty
}

benchmark("Read sync") {
    readSync()
}

benchmark("Read async") {
    Task { @MainActor in
        try await readAsync()
    }
}

benchmark("Read sync Contains") {
    readSyncContains()
}

benchmark("Read sync Line Numbers") {
    Task { @MainActor in
        try await readAsyncLinesFind()
    }
}

benchmark("Read async Contains") {
    Task { @MainActor in
        try await readAsyncContains()
    }
}

benchmark("grep") {
    try grep()
}

// print(readSync() == Task{readAsync()})

// print(
//    Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")!,
//    "\n",
//    Bundle.module.path(forResource: "some_file", ofType: "txt", inDirectory: "Resources")!
// )

Benchmark.main()

// try grep()

func getModificationTime(for url: URL) throws -> Date {
    let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
    return attributes[.modificationDate] as! Date
}

let url = Bundle.module.url(forResource: "some_file", withExtension: "txt", subdirectory: "Resources")!
let modificationTime = try getModificationTime(for: url)
print("The file was last modified on \(modificationTime)")

func getLastCommitAuthor(for fileURL: URL) throws -> String? {
    let command = "cd \(fileURL.deletingLastPathComponent().path) && git log -1 --pretty=format:%an -- \(fileURL.lastPathComponent)"
    let output = try runCLI(command: command)
    return output.trimmingCharacters(in: .whitespacesAndNewlines)
}


if let author = try getLastCommitAuthor(for: URL(string: "/Users/atacan/Documents/.../WhichIsFaster/Sources/GrepVsSwift/Resources")!) {
    print("The last commit on this file was made by \(author)")
} else {
    print("This file has not been committed yet")
}
