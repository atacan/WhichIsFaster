//
// https://github.com/atacan
// 10.12.23
	

import Foundation
import Cocoa

/// Outputs first and last difference. so, the whole sentence.
enum Diff {
    case a
    public func diff(_ before: String, _ after: String) -> (CountableRange<Int>, String)? {
        #if swift(>=4.0)
            let result = diff(Array(before), Array(after))
        #else
            let result = diff(Array(before.characters), Array(after.characters))
        #endif

        return result.flatMap { ($0.0, String($0.1)) }
    }

    public func diff<T: Equatable>(_ before: [T], _ after: [T]) -> (CountableRange<Int>, [T])? {
        return diff(before, after, compare: ==)
    }

    public func diff<T>(_ before: [T], _ after: [T], compare: (T, T) -> Bool) -> (CountableRange<Int>, [T])? {
        let beforeCount = before.count
        let afterCount = after.count

        // Find start
        var commonStart = 0
        while commonStart < beforeCount && commonStart < afterCount && compare(before[commonStart], after[commonStart]) {
            commonStart += 1
        }

        // Find end
        var commonEnd = 0
        while commonEnd + commonStart < beforeCount && commonEnd + commonStart < afterCount && compare(before[beforeCount - 1 - commonEnd], after[afterCount - 1 - commonEnd]) {
            commonEnd += 1
        }

        // Remove
        if beforeCount != commonStart + commonEnd {
            let range = commonStart..<(beforeCount - commonEnd)
            let intersection = commonStart..<(afterCount - commonEnd)
            return (range, Array(after[intersection]))
        }

        // Insert
        if afterCount != commonStart + commonEnd {
            let range = commonStart..<(afterCount - commonEnd)
            return (commonStart..<commonStart, Array(after[range]))
        }

        // Already equal
        return nil
    }
}

func getDiff(_ input1: String, _ input2: String) -> NSMutableArray {
//    if getDiffMode() == .characters {
      let diff = dmp.diff_main(ofOldString: input1, andNewString: input2)
      dmp.diff_cleanupSemantic(diff)
      return diff!
//    }
    
//    if getDiffMode() == .words {
//      let d3 = dmp.diff_wordsToChars(forFirstString: input1, andSecondString: input2)
//      let diff = dmp.diff_main(ofOldString: (d3![0] as! String), andNewString: (d3![1] as! String))
//      dmp.diff_chars((diff as! [Any]), toLines: (d3![2] as! [Any]))
//      return diff!
//    }
    
//    if getDiffMode() == .lines {
//      let d3 = dmp.diff_linesToChars(forFirstString: input1, andSecondString: input2)
//      let diff = dmp.diff_main(ofOldString: (d3![0] as! String), andNewString: (d3![1] as! String))
//      dmp.diff_chars((diff as! [Any]), toLines: (d3![2] as! [Any]))
//      return diff!
//    }
    
//    log.error("invalid diff mode state")
//    return []
  }

//let output = Diff.a.diff("a", "b")
//let output = Diff.a.diff("Hello world!", "Hello here world.")
//Range(0..<45)
let output = Diff.a.diff("this is a sentence without to any punctuation", "This is a sentence without any punctuation.")
print(output)
