import Benchmark
import Foundation

enum ColorLabel: String, CaseIterable {
    case rosewater
    case flamingo
    case pink
    case mauve
    case red
    case maroon
    case peach
    case yellow
    case green
    case teal
    case sky
    case sapphire
    case blue
    case lavender
    case text
    case subtext1
    case subtext0
    case overlay2
    case overlay1
    case overlay0
    case surface2
    case surface1
    case surface0
    case crust
    case mantle
    case base
}

struct ColorLabelSet: OptionSet {
    let rawValue: Int

    static let rosewater = ColorLabelSet(rawValue: 1 << 0)
    static let flamingo = ColorLabelSet(rawValue: 1 << 1)
    static let pink = ColorLabelSet(rawValue: 1 << 2)
    static let mauve = ColorLabelSet(rawValue: 1 << 3)
    static let red = ColorLabelSet(rawValue: 1 << 4)
    static let maroon = ColorLabelSet(rawValue: 1 << 5)
    static let peach = ColorLabelSet(rawValue: 1 << 6)
    static let yellow = ColorLabelSet(rawValue: 1 << 7)
    static let green = ColorLabelSet(rawValue: 1 << 8)
    static let teal = ColorLabelSet(rawValue: 1 << 9)
    static let sky = ColorLabelSet(rawValue: 1 << 10)
    static let sapphire = ColorLabelSet(rawValue: 1 << 11)
    static let blue = ColorLabelSet(rawValue: 1 << 12)
    static let lavender = ColorLabelSet(rawValue: 1 << 13)
    static let text = ColorLabelSet(rawValue: 1 << 14)
    static let subtext1 = ColorLabelSet(rawValue: 1 << 15)
    static let subtext0 = ColorLabelSet(rawValue: 1 << 16)
    static let overlay2 = ColorLabelSet(rawValue: 1 << 17)
    static let overlay1 = ColorLabelSet(rawValue: 1 << 18)
    static let overlay0 = ColorLabelSet(rawValue: 1 << 19)
    static let surface2 = ColorLabelSet(rawValue: 1 << 20)
    static let surface1 = ColorLabelSet(rawValue: 1 << 21)
    static let surface0 = ColorLabelSet(rawValue: 1 << 22)
    static let crust = ColorLabelSet(rawValue: 1 << 23)
    static let mantle = ColorLabelSet(rawValue: 1 << 24)
    static let base = ColorLabelSet(rawValue: 1 << 25)

    static func randomElement() -> ColorLabelSet {
        ColorLabelSet(rawValue: Int.random(in: 0 ..< ColorLabel.allCases.count))
    }
}

var a = 0
var b = 0

benchmark("Switch over enum") {
    switch ColorLabel.allCases.randomElement() {
    case .rosewater:
        a += 1
    case .flamingo:
        a += 1
    case .pink:
        a += 1
    case .mauve:
        a += 1
    case .red:
        a += 1
    case .maroon:
        a += 1
    case .peach:
        a += 1
    case .yellow:
        a += 1
    case .green:
        a += 1
    case .teal:
        a += 1
    case .sky:
        a += 1
    case .sapphire:
        a += 1
    case .blue:
        a += 1
    case .lavender:
        a += 1
    case .text:
        a += 1
    case .subtext1:
        a += 1
    case .subtext0:
        a += 1
    case .overlay2:
        a += 1
    case .overlay1:
        a += 1
    case .overlay0:
        a += 1
    case .surface2:
        a += 1
    case .surface1:
        a += 1
    case .surface0:
        a += 1
    case .crust:
        a += 1
    case .mantle:
        a += 1
    case .base:
        a += 1

    case .none:
        break
    }
}

benchmark("OptionSet") {
    let colorLabelSet = ColorLabelSet.randomElement()
    if colorLabelSet.contains(.rosewater) {
        a += 1
    }
    if colorLabelSet.contains(.flamingo) {
        a += 1
    }
    if colorLabelSet.contains(.pink) {
        a += 1
    }
    if colorLabelSet.contains(.mauve) {
        a += 1
    }
    if colorLabelSet.contains(.red) {
        a += 1
    }
    if colorLabelSet.contains(.maroon) {
        a += 1
    }
    if colorLabelSet.contains(.peach) {
        a += 1
    }
    if colorLabelSet.contains(.yellow) {
        a += 1
    }
    if colorLabelSet.contains(.green) {
        a += 1
    }
    if colorLabelSet.contains(.teal) {
        a += 1
    }
    if colorLabelSet.contains(.sky) {
        a += 1
    }
    if colorLabelSet.contains(.sapphire) {
        a += 1
    }
    if colorLabelSet.contains(.blue) {
        a += 1
    }
    if colorLabelSet.contains(.lavender) {
        a += 1
    }
    if colorLabelSet.contains(.text) {
        a += 1
    }
    if colorLabelSet.contains(.subtext1) {
        a += 1
    }
    if colorLabelSet.contains(.subtext0) {
        a += 1
    }
    if colorLabelSet.contains(.overlay2) {
        a += 1
    }
    if colorLabelSet.contains(.overlay1) {
        a += 1
    }
    if colorLabelSet.contains(.overlay0) {
        a += 1
    }
    if colorLabelSet.contains(.surface2) {
        a += 1
    }
    if colorLabelSet.contains(.surface1) {
        a += 1
    }
    if colorLabelSet.contains(.surface0) {
        a += 1
    }
    if colorLabelSet.contains(.crust) {
        a += 1
    }
    if colorLabelSet.contains(.mantle) {
        a += 1
    }
    if colorLabelSet.contains(.base) {
        a += 1
    }
}

Benchmark.main()
