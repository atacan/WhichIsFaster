import Benchmark
import Prelude

func isOneOf_variadic(_ input: String, _ list: String...) -> Bool {
    for item in list {
        if item == input {
            return true
        }
    }
    return false
}

func isOneOf_arrayArgument(_ input: String, _ list: [String]) -> Bool {
    list.contains(input)
}

func isOneOf_array(_ input: String, _ list: [String]) -> Bool {
    let list = ["a", "b", "c", "d", "e", "f", "g", "h"]
    return list.contains(input)
}

func isOneOf_switch(_ input: String) -> Bool {
    switch input {
    case "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h":
        return true
    default:
        return false
    }
}

func isOneOf_preludeVariadic<A: Equatable>(_ look: A...) -> (A) -> Bool {
    { (a: A) -> Bool in
        for value in look {
            if a == value {
                return true
            }
        }
        return false
    }
}

func isOneOf_preludeArray<A: Equatable>(_ look: [A]) -> (A) -> Bool {
    { (a: A) -> Bool in
        look.contains(a)
    }
}

benchmark("Switch") {
    isOneOf_switch("f")
    isOneOf_switch("k")
}

benchmark("Array Hard Coded") {
    //    isOneOf_switch("f")
    isOneOf_switch("k")
    "f" |> isOneOf_switch
}

benchmark("Variadic Argument") {
    isOneOf_variadic("f", "a", "b", "c", "d", "e", "f", "g", "h")
    isOneOf_variadic("k", "a", "b", "c", "d", "e", "f", "g", "h")
}

benchmark("Array Argument") {
    isOneOf_arrayArgument("f", ["a", "b", "c", "d", "e", "f", "g", "h"])
    isOneOf_arrayArgument("k", ["a", "b", "c", "d", "e", "f", "g", "h"])
}

benchmark("Prelude Variadic") {
    "f" |> isOneOf_preludeVariadic("a", "b", "c", "d", "e", "f", "g", "h")
    "k" |> isOneOf_preludeVariadic("a", "b", "c", "d", "e", "f", "g", "h")
}

benchmark("Prelude Array") {
    "f" |> isOneOf_preludeArray(["a", "b", "c", "d", "e", "f", "g", "h"])
    "k" |> isOneOf_preludeArray(["a", "b", "c", "d", "e", "f", "g", "h"])
}

Benchmark.main()
