//
//  CodableTests.swift
//  FoundationX 
// 
//  Created by 梁光辉 on 2023/4/2.
//  Copyright © 2023 Guanghui Liang. All rights reserved.
//

import XCTest
@testable import FoundationX

fileprivate struct TestModel: Codable {
    let scheme: String?
    let name: String?
}

struct Model: Codable {
    @DefaultTrue var bool: Bool
    @DefaultEmptyString var emptyStr: String
    var dict: [String: AnyCodable]
    var desc: AnyCodable
}

final class CodableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCodableDiction() throws {
        let jsonString = """
        {
            "name": "Guanghui Liang",
            "scheme": "https://liangguanghui.site"
        }
        """
        let jsonData = Data(jsonString.utf8)
        if let model = try? JSONDecoder().decode(TestModel.self, from: jsonData) {
            XLogger.log(model) // output: TestModel(scheme: Optional("https://liangguanghui.site"), name: Optional("Guanghui Liang"))
        }
    }
    
    func testCodable() throws {
        let jsonString = """
        {
            "name": "Guanghui Liang",
            "scheme": "https://liangguanghui.site",
            "dict": {
                "val": 1,
                "name": "name"
            },
            "desc": null
        }
        """
        let jsonData = Data(jsonString.utf8)
        let void: Void
        if let model = try? JSONDecoder().decode(Model.self, from: jsonData) {
            XLogger.log(model)
            XLogger.log(model.dict.rawValue)
            XLogger.log(model.desc.description)
            XLogger.log(AnyCodable(Void.self))
            XLogger.log(AnyCodable(void))
        }
    }
    
    func testEquatable() throws {
        let void: Void
        let dict: [String: AnyCodable] = [
            "bool": true,
            "int": AnyCodable(1 as Int),
            "int8": AnyCodable(1 as Int8),
            "int16": AnyCodable(16 as Int16),
            "int32": AnyCodable(32 as Int32),
            "int64": AnyCodable(64 as Int64),
            "uint": AnyCodable(1 as UInt),
            "uint8": AnyCodable(1 as UInt8),
            "uint16": AnyCodable(16 as UInt16),
            "uint32": AnyCodable(32 as UInt32),
            "uint64": AnyCodable(64 as UInt64),
            "float": AnyCodable(0.1 as Float),
            "double": AnyCodable(0.01 as Double),
            "str": AnyCodable("str"),
            "array": [AnyCodable(1), AnyCodable("1")],
            "dict": ["1": AnyCodable("1")],
            "void": AnyCodable(void),
            "diff": false
        ]
        
        var dict2 = dict
        dict2["diff"] = "str"
        
        for key in dict.keys {
            print(dict[key] == dict2[key])
        }
    }
}
