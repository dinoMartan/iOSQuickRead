//
//  QuickReadTests.swift
//  QuickReadTests
//
//  Created by Dino Martan on 05/05/2021.
//

import XCTest
@testable import QuickRead

class QuickReadTests: XCTestCase {

    func testStringExtensionTitleCase() {
        let test = "thisIsTest"
        let result = test.titleCase()
        XCTAssertEqual(result, "This Is Test")
    }
    
    func testStringCheckTrue() {
        let test = ["test", "test2"]
        let result = StringCheck.checkStrings(strings: test)
        XCTAssertTrue(result)
    }
    
    func testStringCheckFalse() {
        let test = ["test", ""]
        let result = StringCheck.checkStrings(strings: test)
        XCTAssertFalse(result)
    }

}

