//
// https://github.com/atacan
// 30.04.23

import Benchmark
import Foundation
import IkigaJSON
import SwiftProtobuf

let guy = Person.with {
    $0.id = 1735
    $0.name = "Even More Interesting"
    $0.age = 87
}

struct PersonInternal: Codable {
    var id: Int32 = 0
    var name: String = .init()
    var age: Int32 = 0
}

extension PersonInternal {
    func toProtoModel() -> Person {
        return Person.with {
            $0.id = id
            $0.name = name
            $0.age = age
        }
    }
}

let sameGuy = PersonInternal(id: 1735, name: "Even More Interesting", age: 87)

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()
var ikigaEncoder = IkigaJSONEncoder()
var ikigaDecoder = IkigaJSONDecoder()

benchmark("JSON Encoding to Data") {
    _ = try! jsonEncoder.encode(sameGuy)
}

benchmark("Ikiga Encoding to Data") {
    _ = try! ikigaEncoder.encode(sameGuy)
}

benchmark("Protobuf Encoding to Data") {
    _ = try guy.serializedData()
}

benchmark("Protobuf Encoding to Data - First Convert Internal Type to Proto Model") {
    let protoGuy = sameGuy.toProtoModel()
    _ = try protoGuy.serializedData()
}

let guyData = try guy.serializedData()
let sameGuyData = try jsonEncoder.encode(sameGuy)

benchmark("JSON Decoding from Data") {
    _ = try! jsonDecoder.decode(PersonInternal.self, from: sameGuyData)
}

benchmark("Ikiga Decoding from Data") {
    _ = try! ikigaDecoder.decode(PersonInternal.self, from: sameGuyData)
}

benchmark("Protobuf Decoding from Data") {
    _ = try! Person(serializedData: guyData)
}

benchmark("Protobuf Decoding from Data - Convert to Internal") {
    let newguy = try! Person(serializedData: guyData)
    _ = PersonInternal(id: newguy.id, name: newguy.name, age: newguy.age)
}

try print(String(data: jsonEncoder.encode(sameGuy), encoding: .utf8)!)
try print(String(data: ikigaEncoder.encode(sameGuy), encoding: .utf8)!)

Benchmark.main()
