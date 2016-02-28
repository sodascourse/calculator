//
//  CalculatorCoreTests.swift
//  CalculatorCoreTests
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import XCTest
@testable import CalculatorCore

class CalculatorCoreTests: XCTestCase {

    var core: Core<Float>!

    override func setUp() {
        super.setUp()
        self.core = Core()
    }

    override func tearDown() {
        self.core = nil
        super.tearDown()
    }

    func testAdd() {
        try! self.core.addStep(1)
        try! self.core.addStep(+)
        try! self.core.addStep(2)
        XCTAssertEqual(try? self.core.calculate(), 3)
    }

    func testSubstract() {
        try! self.core.addStep(1)
        try! self.core.addStep(-)
        try! self.core.addStep(2)
        XCTAssertEqual(try? self.core.calculate(), -1)
    }

    func testMultiply() {
        try! self.core.addStep(4)
        try! self.core.addStep(*)
        try! self.core.addStep(2)
        XCTAssertEqual(try? self.core.calculate(), 8)
    }

    func testDivide1() {
        try! self.core.addStep(1)
        try! self.core.addStep(/)
        try! self.core.addStep(2)
        XCTAssertEqual(try? self.core.calculate(), 0.5)
    }

    func testDivide2() {
        try! self.core.addStep(0)
        try! self.core.addStep(/)
        try! self.core.addStep(2)
        XCTAssertEqual(try? self.core.calculate(), 0)
    }

    func testDivide3() {
        try! self.core.addStep(1)
        try! self.core.addStep(/)
        try! self.core.addStep(0)
        XCTAssertEqual(try? self.core.calculate(), Float.infinity)
    }

    func testCalculate0() {
        try! self.core.addStep(1)
        XCTAssertEqual(try? self.core.calculate(), 1)
    }

    func testCalculate1() {
        try! self.core.addStep(1)
        try! self.core.addStep(+)
        try! self.core.addStep(2)
        try! self.core.addStep(*)
        try! self.core.addStep(3)
        XCTAssertEqual(try? self.core.calculate(), 9)
    }

    func testCalculate2() {
        try! self.core.addStep(1)
        try! self.core.addStep(*)
        try! self.core.addStep(2)
        try! self.core.addStep(+)
        try! self.core.addStep(3)
        XCTAssertEqual(try? self.core.calculate(), 5)
    }

}
