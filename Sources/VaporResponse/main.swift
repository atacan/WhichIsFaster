import Benchmark
import Foundation

benchmark("Python Script") {
    // make a get request to url "http://127.0.0.1:8080/python"
    let url = URL(string: "http://127.0.0.1:8080/python")!
    
    Task {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return
            }

        guard let string = String(data: data, encoding: .utf8) else {
                return
            }
    }
    
//    let task = URLSession.shared.dataTask(with: .init(url: url)) { data,resp,err in
//        // print(data)
//    }
//    task.resume()
}

benchmark("JavaScript") {
    // make a get request to url "http://127.0.0.1:8080/python"
    let url = URL(string: "http://127.0.0.1:8080/javascript")!
    
    let task = URLSession.shared.dataTask(with: .init(url: url)) { data,resp,err in
        // print(data)
    }
    task.resume()
}

benchmark("pwd") {
    // make a get request to url "http://127.0.0.1:8080/python"
    let url = URL(string: "http://127.0.0.1:8080/pwd")!
    
    let task = URLSession.shared.dataTask(with: .init(url: url)) { data,resp,err in
        // print(data)
    }
    task.resume()
}

benchmark("hello") {
    // make a get request to url "http://127.0.0.1:8080/python"
    let url = URL(string: "http://127.0.0.1:8080/hello")!
    
    let task = URLSession.shared.dataTask(with: .init(url: url)) { data,resp,err in
        // print(data)
    }
    task.resume()
}


Benchmark.main()

let url = URL(string: "http://127.0.0.1:8080/javascript")!
let task = URLSession.shared.dataTask(with: .init(url: url)) { data,resp,err in
    // print(data)
    print(String(data: data!, encoding: .utf8)!)
}
task.resume()

//Thread.sleep(forTimeInterval: 2)

// name          time          std        iterations
// -------------------------------------------------
// Python Script 595270.500 ns ±  48.49 %       1926
// JavaScript    606250.000 ns ±  36.26 %       2025
// pwd           608875.000 ns ±  38.34 %       2153
// hello         623979.000 ns ±  34.57 %       2084
