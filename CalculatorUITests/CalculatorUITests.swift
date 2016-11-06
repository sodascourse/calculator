//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {

    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }

    func testAdd() {
        self.app.buttons["1"].tap()
        self.app.buttons["+"].tap()
        self.app.buttons["5"].tap()
        self.app.buttons["="].tap()
        XCTAssertTrue(self.app.staticTexts["6"].exists)
    }

    func testSub() {
        self.app.buttons["2"].tap()
        self.app.buttons["0"].tap()
        self.app.buttons["−"].tap()
        self.app.buttons["3"].tap()
        self.app.buttons["="].tap()
        XCTAssertTrue(self.app.staticTexts["17"].exists)
    }

    func testReset() {
        self.app.buttons["2"].tap()
        self.app.buttons["0"].tap()
        self.app.buttons["AC"].tap()
        self.app.buttons["2"].tap()
        self.app.buttons["−"].tap()
        self.app.buttons["3"].tap()
        self.app.buttons["="].tap()
        XCTAssertTrue(self.app.staticTexts["-1"].exists)
    }

}
