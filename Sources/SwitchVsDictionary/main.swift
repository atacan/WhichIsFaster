//
// https://github.com/atacan
// 29.04.23

import Benchmark
import SwiftUI

enum Flavour: CaseIterable {
    case latte
    case frappe
    case macchiato
    case mocha
}

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

benchmark("Switch on label") {
    func latte(_ label: ColorLabel) -> Color {
        switch label {
        case .rosewater:
            return Color(Color.RGBColorSpace.sRGB, red: 220 / 255, green: 138 / 255, blue: 120 / 255, opacity: 1)
        case .flamingo:
            return Color(Color.RGBColorSpace.sRGB, red: 221 / 255, green: 120 / 255, blue: 120 / 255, opacity: 1)
        case .pink:
            return Color(Color.RGBColorSpace.sRGB, red: 234 / 255, green: 118 / 255, blue: 203 / 255, opacity: 1)
        case .mauve:
            return Color(Color.RGBColorSpace.sRGB, red: 136 / 255, green: 57 / 255, blue: 239 / 255, opacity: 1)
        case .red:
            return Color(Color.RGBColorSpace.sRGB, red: 210 / 255, green: 15 / 255, blue: 57 / 255, opacity: 1)
        case .maroon:
            return Color(Color.RGBColorSpace.sRGB, red: 230 / 255, green: 69 / 255, blue: 83 / 255, opacity: 1)
        case .peach:
            return Color(Color.RGBColorSpace.sRGB, red: 254 / 255, green: 100 / 255, blue: 11 / 255, opacity: 1)
        case .yellow:
            return Color(Color.RGBColorSpace.sRGB, red: 223 / 255, green: 142 / 255, blue: 29 / 255, opacity: 1)
        case .green:
            return Color(Color.RGBColorSpace.sRGB, red: 64 / 255, green: 160 / 255, blue: 43 / 255, opacity: 1)
        case .teal:
            return Color(Color.RGBColorSpace.sRGB, red: 23 / 255, green: 146 / 255, blue: 153 / 255, opacity: 1)
        case .sky:
            return Color(Color.RGBColorSpace.sRGB, red: 4 / 255, green: 165 / 255, blue: 229 / 255, opacity: 1)
        case .sapphire:
            return Color(Color.RGBColorSpace.sRGB, red: 32 / 255, green: 159 / 255, blue: 181 / 255, opacity: 1)
        case .blue:
            return Color(Color.RGBColorSpace.sRGB, red: 30 / 255, green: 102 / 255, blue: 245 / 255, opacity: 1)
        case .lavender:
            return Color(Color.RGBColorSpace.sRGB, red: 114 / 255, green: 135 / 255, blue: 253 / 255, opacity: 1)
        case .text:
            return Color(Color.RGBColorSpace.sRGB, red: 76 / 255, green: 79 / 255, blue: 105 / 255, opacity: 1)
        case .subtext1:
            return Color(Color.RGBColorSpace.sRGB, red: 92 / 255, green: 95 / 255, blue: 119 / 255, opacity: 1)
        case .subtext0:
            return Color(Color.RGBColorSpace.sRGB, red: 108 / 255, green: 111 / 255, blue: 133 / 255, opacity: 1)
        case .overlay2:
            return Color(Color.RGBColorSpace.sRGB, red: 124 / 255, green: 127 / 255, blue: 147 / 255, opacity: 1)
        case .overlay1:
            return Color(Color.RGBColorSpace.sRGB, red: 140 / 255, green: 143 / 255, blue: 161 / 255, opacity: 1)
        case .overlay0:
            return Color(Color.RGBColorSpace.sRGB, red: 156 / 255, green: 160 / 255, blue: 176 / 255, opacity: 1)
        case .surface2:
            return Color(Color.RGBColorSpace.sRGB, red: 172 / 255, green: 176 / 255, blue: 190 / 255, opacity: 1)
        case .surface1:
            return Color(Color.RGBColorSpace.sRGB, red: 188 / 255, green: 192 / 255, blue: 204 / 255, opacity: 1)
        case .surface0:
            return Color(Color.RGBColorSpace.sRGB, red: 204 / 255, green: 208 / 255, blue: 218 / 255, opacity: 1)
        case .crust:
            return Color(Color.RGBColorSpace.sRGB, red: 220 / 255, green: 224 / 255, blue: 232 / 255, opacity: 1)
        case .mantle:
            return Color(Color.RGBColorSpace.sRGB, red: 230 / 255, green: 233 / 255, blue: 239 / 255, opacity: 1)
        case .base:
            return Color(Color.RGBColorSpace.sRGB, red: 239 / 255, green: 241 / 255, blue: 245 / 255, opacity: 1)
        }
    }

    //    for label in ColorLabel.allCases {
    //        _ = latte(label)
    //    }

    _ = latte(ColorLabel.allCases.randomElement()!)
}

benchmark("Dictionary access") {
    let latteColor: [ColorLabel: Color] = [
        .rosewater: Color(Color.RGBColorSpace.sRGB, red: 220 / 255, green: 138 / 255, blue: 120 / 255, opacity: 1),
        .flamingo: Color(Color.RGBColorSpace.sRGB, red: 221 / 255, green: 120 / 255, blue: 120 / 255, opacity: 1),
        .pink: Color(Color.RGBColorSpace.sRGB, red: 234 / 255, green: 118 / 255, blue: 203 / 255, opacity: 1),
        .mauve: Color(Color.RGBColorSpace.sRGB, red: 136 / 255, green: 57 / 255, blue: 239 / 255, opacity: 1),
        .red: Color(Color.RGBColorSpace.sRGB, red: 210 / 255, green: 15 / 255, blue: 57 / 255, opacity: 1),
        .maroon: Color(Color.RGBColorSpace.sRGB, red: 230 / 255, green: 69 / 255, blue: 83 / 255, opacity: 1),
        .peach: Color(Color.RGBColorSpace.sRGB, red: 254 / 255, green: 100 / 255, blue: 11 / 255, opacity: 1),
        .yellow: Color(Color.RGBColorSpace.sRGB, red: 223 / 255, green: 142 / 255, blue: 29 / 255, opacity: 1),
        .green: Color(Color.RGBColorSpace.sRGB, red: 64 / 255, green: 160 / 255, blue: 43 / 255, opacity: 1),
        .teal: Color(Color.RGBColorSpace.sRGB, red: 23 / 255, green: 146 / 255, blue: 153 / 255, opacity: 1),
        .sky: Color(Color.RGBColorSpace.sRGB, red: 4 / 255, green: 165 / 255, blue: 229 / 255, opacity: 1),
        .sapphire: Color(Color.RGBColorSpace.sRGB, red: 32 / 255, green: 159 / 255, blue: 181 / 255, opacity: 1),
        .blue: Color(Color.RGBColorSpace.sRGB, red: 30 / 255, green: 102 / 255, blue: 245 / 255, opacity: 1),
        .lavender: Color(Color.RGBColorSpace.sRGB, red: 114 / 255, green: 135 / 255, blue: 253 / 255, opacity: 1),
        .text: Color(Color.RGBColorSpace.sRGB, red: 76 / 255, green: 79 / 255, blue: 105 / 255, opacity: 1),
        .subtext1: Color(Color.RGBColorSpace.sRGB, red: 92 / 255, green: 95 / 255, blue: 119 / 255, opacity: 1),
        .subtext0: Color(Color.RGBColorSpace.sRGB, red: 108 / 255, green: 111 / 255, blue: 133 / 255, opacity: 1),
        .overlay2: Color(Color.RGBColorSpace.sRGB, red: 124 / 255, green: 127 / 255, blue: 147 / 255, opacity: 1),
        .overlay1: Color(Color.RGBColorSpace.sRGB, red: 140 / 255, green: 143 / 255, blue: 161 / 255, opacity: 1),
        .overlay0: Color(Color.RGBColorSpace.sRGB, red: 156 / 255, green: 160 / 255, blue: 176 / 255, opacity: 1),
        .surface2: Color(Color.RGBColorSpace.sRGB, red: 172 / 255, green: 176 / 255, blue: 190 / 255, opacity: 1),
        .surface1: Color(Color.RGBColorSpace.sRGB, red: 188 / 255, green: 192 / 255, blue: 204 / 255, opacity: 1),
        .surface0: Color(Color.RGBColorSpace.sRGB, red: 204 / 255, green: 208 / 255, blue: 218 / 255, opacity: 1),
        .crust: Color(Color.RGBColorSpace.sRGB, red: 220 / 255, green: 224 / 255, blue: 232 / 255, opacity: 1),
        .mantle: Color(Color.RGBColorSpace.sRGB, red: 230 / 255, green: 233 / 255, blue: 239 / 255, opacity: 1),
        .base: Color(Color.RGBColorSpace.sRGB, red: 239 / 255, green: 241 / 255, blue: 245 / 255, opacity: 1),
    ]

    func latte(_ label: ColorLabel) -> Color
    { /*{!we are going to loop through all the cases and ask for the SwiftUI.Color corresponding to that label!}*/
        return latteColor[label]!
    }

    //    for label in ColorLabel.allCases {
    //        _ = latte(label)
    //    }

    _ = latte(ColorLabel.allCases.randomElement()!)
}

Benchmark.main()
