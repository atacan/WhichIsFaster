//
// https://github.com/atacan
// 11.11.23
	

import Foundation
extension String {
    func removePunctuationAndSpecialCharacters() -> String {
        let allowedCharacters = CharacterSet.alphanumerics.union(.whitespaces)
        let filteredCharacters = self.unicodeScalars.filter { allowedCharacters.contains($0) }
        let cleanString = String(String.UnicodeScalarView(filteredCharacters))
        return cleanString.lowercased()
    }

    func transformString() -> String {
        let characterSet = CharacterSet.punctuationCharacters.union(.symbols)
        let filteredString =
            self
            .components(separatedBy: characterSet)
            .joined()
        return filteredString.lowercased()
    }
}

import Benchmark
benchmark("removePunctuationAndSpecialCharacters") {
    #""Hello World" is a good first statement to talk about."#
        .removePunctuationAndSpecialCharacters()
}

benchmark("transformString") {
    #""Hello World" is a good first statement to talk about."#
        .transformString()
}

Benchmark.main()

print(#""Hello World" is a good first statement to talk about."#
    .transformString() == "hello world is a good first statement to talk about")
