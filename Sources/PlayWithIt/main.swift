let strings = ["Hello", "World"]
let numbers = [1, 2, 3]
let colors = ["Red", "Green", "Blue"]

var combinations: [(String, Int, String)] = []

for string in strings {
    for number in numbers {
        for color in colors {
            combinations.append((string, number, color))
        }
    }
}

// Now 'combinations' contains all possible pairings of 'strings', 'numbers', and 'colors'.
// for combination in combinations {
//     print(combination)
// }

extension Sequence {
    func cartesianProduct<S: Sequence, T: Sequence>(_ sequence1: S, _ sequence2: T) -> [(Element, S.Element, T.Element)] {
        return self.flatMap { element in
            sequence1.flatMap { element1 in
                sequence2.map { element2 in
                    (element, element1, element2)
                }
            }
        }
    }
}

let cartesianCombinations = strings.cartesianProduct(numbers, colors)

// Now 'combinations' contains all possible pairings of 'strings', 'numbers', and 'colors'.
for combination in cartesianCombinations {
    print(combination)
}