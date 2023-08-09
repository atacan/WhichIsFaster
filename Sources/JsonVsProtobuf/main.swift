import Benchmark
import Foundation
import IkigaJSON
import MongoSwift
import SwiftAvroCore
import SwiftCBOR
import SwiftProtobuf
import XMLCoder

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
        Person.with {
            $0.id = id
            $0.name = name
            $0.age = age
        }
    }
}

extension PersonInternal: CBOREncodable {
    func encode(options: SwiftCBOR.CBOROptions) -> [UInt8] {
        let cborWrapper: CBOR = [
            "id": CBOR(integerLiteral: Int(id)),
            "name": CBOR.utf8String(name),
            "age": CBOR(integerLiteral: Int(age)),
        ]
        return cborWrapper.encode()
    }

    func toCBOR(options: SwiftCBOR.CBOROptions) -> SwiftCBOR.CBOR {
        CBOR(integerLiteral: Int(id))
    }
}

// let schema = """
// {
//  "type": "record",
//  "name": "PersonInternal",
//  "fields": [
//    {"name": "id", "type": "int"},
//    {"name": "name", "type": "string"},
//    {"name": "age", "type": "int"}
//  ]
// }
// """

let avro = Avro()

let sameGuy = PersonInternal(id: 1735, name: "Even More Interesting", age: 87)

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()
var ikigaEncoder = IkigaJSONEncoder()
var ikigaDecoder = IkigaJSONDecoder()
let bsonEncoder = BSONEncoder()
let bsonDecoder = BSONDecoder()
let xmlEncoder = XMLEncoder()
let xmlDecoder = XMLDecoder()
let plistEncoder = PropertyListEncoder()
let plistDecoder = PropertyListDecoder()

benchmark("Codable JSON Encoding to Data") {
    _ = try! jsonEncoder.encode(sameGuy)
}

benchmark("Ikiga Encoding to Data") {
    _ = try! ikigaEncoder.encode(sameGuy)
}

benchmark("Plist Encoding to Data") {
    _ = try! plistEncoder.encode(sameGuy)
}

benchmark("XMLCoder Encoding to Data") {
    _ = try! xmlEncoder.encode(sameGuy, withRootKey: "PersonInternal")
}

benchmark("BSON Encoding to Data") {
    _ = try! bsonEncoder.encode(sameGuy)
}

benchmark("Avro Encoding to Data") {
    _ = try! avro.encode(sameGuy)
}

benchmark("CBOR Encoding to Data") {
    _ = CBOR.encode(sameGuy)
}

benchmark("Protobuf Encoding to Data") {
    _ = try guy.serializedData()
}

benchmark("Protobuf Encoding to Data - First Convert Internal Type to Proto Model") {
    let protoGuy = sameGuy.toProtoModel()
    _ = try protoGuy.serializedData()
}

benchmark("Manual Encoding") {
    let json: [String: Any] = [
        "id": sameGuy.id,
        "name": sameGuy.name,
        "age": sameGuy.age,
    ]
    _ = try! JSONSerialization.data(withJSONObject: json, options: [])
}

// MARK: - DECODING

let guyData = try guy.serializedData()
let sameGuyData = try jsonEncoder.encode(sameGuy)
let bsonData = try bsonEncoder.encode(sameGuy)
let xmlData = try xmlEncoder.encode(sameGuy, withRootKey: "PersonInternal")
let avroData = try avro.encode(sameGuy)
let plistData = try PropertyListEncoder().encode(sameGuy)
let cborData = try CBOR.encode(sameGuy)

benchmark("Codable JSON Decoding from Data") {
    _ = try! jsonDecoder.decode(PersonInternal.self, from: sameGuyData)
}

benchmark("Ikiga Decoding from Data") {
    _ = try! ikigaDecoder.decode(PersonInternal.self, from: sameGuyData)
}

benchmark("BSON Decoding from Data") {
    _ = try! bsonDecoder.decode(PersonInternal.self, from: bsonData)
}

benchmark("Avro Decoding from Data") {
    _ = try! avro.decode(from: avroData)
}

benchmark("Plist Decoding from Data") {
    _ = try! plistDecoder.decode(PersonInternal.self, from: plistData)
}

benchmark("XMLCoder Decoding from Data") {
    _ = try! xmlDecoder.decode(PersonInternal.self, from: xmlData)
}

benchmark("CBOR Decoding from Data") {
    _ = try! CBOR.decode(cborData)
}

benchmark("Protobuf Decoding from Data") {
    _ = try! Person(serializedData: guyData)
}

benchmark("Protobuf Decoding from Data - Convert to Internal") {
    let newguy = try! Person(serializedData: guyData)
    _ = PersonInternal(id: newguy.id, name: newguy.name, age: newguy.age)
}

benchmark("Manual Decoding") {
    let json = try! JSONSerialization.jsonObject(with: sameGuyData, options: []) as! [String: Any]
    _ = PersonInternal(id: json["id"] as! Int32, name: json["name"] as! String, age: json["age"] as! Int32)
}

// try print(String(data: jsonEncoder.encode(sameGuy), encoding: .utf8)!)
// try print(String(data: ikigaEncoder.encode(sameGuy), encoding: .utf8)!)

Benchmark.main()

// import Yams

// Encoding
// let yamlString = try Yams.dump(object: sameGuy)
// print("YAML String:", yamlString)
//
//// Decoding
// let decodedGuyyams = try Yams.load(yaml: yamlString) as! PersonInternal
// print("Decoded YAML:", decodedGuyyams)
