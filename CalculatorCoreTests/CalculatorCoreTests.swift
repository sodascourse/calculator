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
    var core: Core<Double>!

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
        XCTAssertEqual(self.core.calculate(), 3)
    }

    func testSubstract() {
        try! self.core.addStep(1)
        try! self.core.addStep(-)
        try! self.core.addStep(2)
        XCTAssertEqual(self.core.calculate(), -1)
    }

    func testMultiply() {
        try! self.core.addStep(4)
        try! self.core.addStep(*)
        try! self.core.addStep(2)
        XCTAssertEqual(self.core.calculate(), 8)
    }

    func testDivide1() {
        try! self.core.addStep(1)
        try! self.core.addStep(/)
        try! self.core.addStep(2)
        XCTAssertEqual(self.core.calculate(), 0.5)
    }

    func testDivide2() {
        try! self.core.addStep(0)
        try! self.core.addStep(/)
        try! self.core.addStep(2)
        XCTAssertEqual(self.core.calculate(), 0)
    }

    func testDivide3() {
        try! self.core.addStep(1)
        try! self.core.addStep(/)
        try! self.core.addStep(0)
        XCTAssertEqual(self.core.calculate(), Double.infinity)
    }

    func testCalculate0() {
        try! self.core.addStep(1)
        XCTAssertEqual(self.core.calculate(), 1)
    }

    func testCalculate1() {
        try! self.core.addStep(1)
        try! self.core.addStep(+)
        try! self.core.addStep(2)
        try! self.core.addStep(*)
        try! self.core.addStep(3)
        XCTAssertEqual(self.core.calculate(), 9)
    }

    func testCalculate2() {
        try! self.core.addStep(1)
        try! self.core.addStep(*)
        try! self.core.addStep(2)
        try! self.core.addStep(+)
        try! self.core.addStep(3)
        XCTAssertEqual(self.core.calculate(), 5)
    }

    func testCalculate_lastStepShouldBeAnOperand() {
        try! self.core.addStep(1)
        try! self.core.addStep(*)
        XCTAssertNil(self.core.calculate())
    }

    func testInvalidStepOrder_FirstStepShouldBeAnOperand() {
        XCTAssertThrowsError(try self.core.addStep(+)) { (error) in
            XCTAssertEqual(error as? Core.Error, .invalidStepOrder)
        }
    }

    func testInvalidStepOrder_OperandShouldNotFollowOperand() {
        try! self.core.addStep(1)
        XCTAssertThrowsError(try self.core.addStep(1)) { (error) in
            XCTAssertEqual(error as? Core.Error, .invalidStepOrder)
        }
    }

    func testInvalidStepOrder_OperatorShouldNotFollowOperator() {
        try! self.core.addStep(1)
        try! self.core.addStep(+)
        XCTAssertThrowsError(try self.core.addStep(*)) { (error) in
            XCTAssertEqual(error as? Core.Error, .invalidStepOrder)
        }
    }

}
