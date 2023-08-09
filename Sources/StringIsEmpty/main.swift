import Benchmark

benchmark(".isEmpty") {
    let s = "Hello, world!"
    s.isEmpty
}

benchmark(".count") {
    let s = "Hello, world!"
    s.count
}

let someText = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed diam neque, fringilla in consectetur nec, finibus a dolor. Cras pulvinar, ligula ut aliquet placerat, nisl nisi ultricies odio, nec tincidunt dolor erat in lacus. Nulla facilisi. Suspendisse potenti. Suspendisse potenti. Suspendisse potenti. Sed at nisl id metus interdum interdum. Nullam eget nunc sed ipsum aliquam ultricies. Aliquam erat volutpat. Fusce eget justo in ante aliquet condimentum. Aenean bibendum turpis vitae mi maximus, eu ultrices ante lacinia. Sed at elit ullamcorper, porta odio a, molestie nisl. Fusce quis odio ac tortor convallis dapibus. Sed efficitur, tellus vitae ultricies pharetra, lacus ipsum lacinia orci, ut euismod arcu nisi et urna. Phasellus rutrum, ex vitae vulputate laoreet, massa neque consequat felis, quis mattis enim dui eget risus. Duis auctor ultrices ligula, quis rhoncus risus.
    """

benchmark(".isEmpty Long String") {
    let s = someText
    s.isEmpty
}

benchmark(".count Long String") {
    let s = someText
    s.count
}

Benchmark.main()
