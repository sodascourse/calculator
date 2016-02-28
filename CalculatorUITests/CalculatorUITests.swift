//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIDevice.sharedDevice().orientation = .Portrait

        let app = XCUIApplication()
        app.launch()
        app.buttons["AC"].tap()
    }

    func testLaunch() {
        XCTAssertTrue(XCUIApplication().staticTexts["0"].exists)
    }
    
    func testInput() {
        let app = XCUIApplication()

        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["5"].tap()
        XCTAssertTrue(app.staticTexts["1235"].exists)

        app.buttons["+/-"].tap()
        XCTAssertTrue(app.staticTexts["-1235"].exists)

        app.buttons["9"].tap()
        app.buttons["+/-"].tap()
        XCTAssertTrue(app.staticTexts["12359"].exists)
    }

    func testAdd() {
        let app = XCUIApplication()

        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["42"].exists)
    }

    func testSub() {
        let app = XCUIApplication()

        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["-"].tap()
        app.buttons["1"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["42"].exists)
    }
    
}
