import CoreGraphics
import XCTest
@testable import FoundationX

private struct DefaultsPayload: Codable, Sendable {
    @DefaultTrue var missingTrue: Bool
    @DefaultFalse var intBool: Bool
    @DefaultTrue var stringBool: Bool
    @DefaultFalse var invalidBool: Bool
    @DefaultEmptyString var name: String
    @DefaultIntZero var count: Int
    @DefaultInt64Zero var largeCount: Int64
    @DefaultFloatZero var ratio: Float
    @DefaultDoubleZero var score: Double
    @DefaultEmptyArray<Int> var items: [Int]
    @DefaultEmptyDictionary<String, Int> var scores: [String: Int]
}

final class FoundationXCoverageTests: XCTestCase {
    func testCodableDefaultWrappersUseFallbacksAndConversions() throws {
        let json = """
        {
            "intBool": 1,
            "stringBool": "false",
            "invalidBool": "maybe",
            "name": null,
            "count": "bad",
            "largeCount": null,
            "ratio": null,
            "score": "bad",
            "items": null,
            "scores": null
        }
        """

        let payload = try JSONDecoder().decode(DefaultsPayload.self, from: Data(json.utf8))

        XCTAssertTrue(payload.missingTrue)
        XCTAssertTrue(payload.intBool)
        XCTAssertFalse(payload.stringBool)
        XCTAssertFalse(payload.invalidBool)
        XCTAssertEqual(payload.name, "")
        XCTAssertEqual(payload.count, 0)
        XCTAssertEqual(payload.largeCount, 0)
        XCTAssertEqual(payload.ratio, 0)
        XCTAssertEqual(payload.score, 0)
        XCTAssertTrue(payload.items.isEmpty)
        XCTAssertTrue(payload.scores.isEmpty)
    }

    func testAnyCodableDecodesPrimitivesAndExposesRawValues() throws {
        let json = """
        {
            "boolean": true,
            "integer": 42,
            "double": 3.5,
            "string": "FoundationX",
            "null": null
        }
        """

        let decoded = try JSONDecoder().decode([String: AnyCodable].self, from: Data(json.utf8))

        XCTAssertEqual(decoded["boolean"], AnyCodable(true))
        XCTAssertEqual(decoded["integer"], AnyCodable(42))
        XCTAssertEqual(decoded["double"], AnyCodable(3.5))
        XCTAssertEqual(decoded["string"], AnyCodable("FoundationX"))
        XCTAssertEqual(decoded["null"]?.description, "<null>")

        let raw = decoded.rawValue
        XCTAssertEqual(raw["boolean"] as? Bool, true)
        XCTAssertEqual(raw["integer"] as? Int, 42)
        XCTAssertEqual(raw["string"] as? String, "FoundationX")
    }

    func testAnyEncodableEncodesPrimitiveValues() throws {
        let payload: [String: AnyEncodable] = [
            "boolean": AnyEncodable(true),
            "integer": AnyEncodable(42),
            "double": AnyEncodable(3.5),
            "string": AnyEncodable("FoundationX"),
            "null": AnyEncodable(nil as String?)
        ]

        let data = try JSONEncoder().encode(payload)
        let object = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])

        XCTAssertEqual(object["boolean"] as? Bool, true)
        XCTAssertEqual(object["integer"] as? Int, 42)
        XCTAssertEqual(object["double"] as? Double, 3.5)
        XCTAssertEqual(object["string"] as? String, "FoundationX")
        XCTAssertTrue(object["null"] is NSNull)
    }

    func testEncodableDictionaryConversion() throws {
        struct Profile: Encodable {
            let name: String
            let age: Int
        }

        let dictionary = try XCTUnwrap(Profile(name: "FoundationX", age: 1).dictionary)

        XCTAssertEqual(dictionary["name"] as? String, "FoundationX")
        XCTAssertEqual(dictionary["age"] as? Int, 1)
    }

    func testValueReturnsDefaultWhenEmpty() {
        XCTAssertEqual(Value<Bool>.none.realValue, false)
        XCTAssertEqual(Value<Int>.none.realValue, 0)
        XCTAssertEqual(Value<String>.some(value: "custom").realValue, "custom")
    }

    func testThenRunAndTrackHelpers() {
        let rect = CGRect.zero.with {
            $0.origin.x = 10
            $0.size.width = 20
        }

        XCTAssertEqual(rect.origin.x, 10)
        XCTAssertEqual(rect.size.width, 20)

        var runCalled = false
        FoundationX.run("coverage") {
            runCalled = true
        }
        XCTAssertTrue(runCalled)

        var trackCalled = false
        track {
            trackCalled = true
        }
        XCTAssertTrue(trackCalled)
    }

    func testStringURLAndOptionalExtensions() throws {
        XCTAssertEqual("hello"[1], "e")
        XCTAssertNil("hello"[5])
        XCTAssertEqual(Character("F").stringValue, "F")
        XCTAssertEqual((nil as Character?).stringValue, "")

        let optionalString: String? = ""
        XCTAssertTrue(optionalString.isNilOrEmpty)

        let optionalArray: [Any]? = []
        XCTAssertTrue(optionalArray.isNilOrEmpty)

        let updatedURL = "https://example.com/search?existing=1"
            .urlAddComponents(from: ["query": "FoundationX"])
        let components = try XCTUnwrap(URLComponents(string: updatedURL))
        let queryItems = components.queryItems ?? []

        XCTAssertEqual(queryItems.first { $0.name == "query" }?.value, "FoundationX")
        XCTAssertEqual(queryItems.first { $0.name == "existing" }?.value, "1")
    }

    func testFileSizeUtilities() throws {
        let directory = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let file = directory.appendingPathComponent("payload.txt")
        let nestedDirectory = directory.appendingPathComponent("nested", isDirectory: true)
        let nestedFile = nestedDirectory.appendingPathComponent("nested.txt")

        try FileManager.default.createDirectory(at: nestedDirectory, withIntermediateDirectories: true)
        try Data("hello".utf8).write(to: file)
        try Data("world".utf8).write(to: nestedFile)
        defer { try? FileManager.default.removeItem(at: directory) }

        XCTAssertEqual(file.fileSize(), 5)
        XCTAssertEqual(nestedFile.fileSize(), 5)
        XCTAssertGreaterThanOrEqual(directory.directorySize(), 10)
        XCTAssertEqual(directory.appendingPathComponent("missing").fileSize(), 0)
    }

    func testMirrorDetectsOptionalValues() {
        let optional: String? = "value"
        let nonOptional = "value"

        XCTAssertTrue(Mirror.isOptional(optional as Any))
        XCTAssertFalse(Mirror.isOptional(nonOptional))
    }
}
