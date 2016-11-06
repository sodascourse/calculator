//
//  ViewController.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

import UIKit
import CalculatorCore


extension Double {

    /// A formatted string representation by stripping tail `.` and `0`.
    /// For value which is an integer, like `2.0`, this representation would be `"2"`.
    /// Other values would be just the same string. Like `2.4` would be still `"2.4"`.
    fileprivate var displayString: String {
        let floor = self.rounded(.towardZero)  // or just `Int(self)`
        let string = String(self)
        if self.distance(to: floor).isZero {  // Like "2.0" --> "2"
            let indexOfDot = string.index(string.endIndex, offsetBy: -2)
            return string.substring(to: indexOfDot)
        } else {
            return string
        }
    }
}


// MARK: Main Body

class ViewController: UIViewController {

    var core = Core<Double>()

    @IBOutlet weak var displayLabel: UILabel!

    var currentNumber: Double {
        let currentText = self.displayLabel.text ?? "0"
        return Double(currentText)!
    }

    // MARK: - View Controller Setup

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Input

    @IBAction func numericButtonClicked(_ sender: UIButton) {
        let numericButtonDigit = sender.tag - 1000
        let currentText = self.displayLabel.text ?? "0"
        if currentText == "0" {
            self.displayLabel.text = "\(numericButtonDigit)"
        } else {
            self.displayLabel.text = currentText + String(numericButtonDigit)
        }
    }

    @IBAction func doubleZeroButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        guard currentText != "0" else {
            return
        }
        self.displayLabel.text = currentText + "00"
    }

    @IBAction func dotButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        guard !currentText.contains(".") else {
            return
        }
        self.displayLabel.text = currentText + "."
    }

    @IBAction func clearButtonClicked(_ sender: UIButton) {
        self.displayLabel.text = "0"
        self.core = Core<Double>()
    }

    // MARK: - Actions

    @IBAction func operatorButtonClicked(_ sender: UIButton) {
        try! self.core.addStep(self.currentNumber)
        self.displayLabel.text = "0"

        switch sender.tag {
        case 1101: // Add
            try! self.core.addStep(+)
        case 1102: // Sub
            try! self.core.addStep(-)
        default:
            fatalError("Unknown operator button: \(sender)")
        }
    }

    @IBAction func calculateButtonClicked(_ sender: UIButton) {
        try! self.core.addStep(self.currentNumber)
        let result = self.core.calculate()!

        self.displayLabel.text = result.displayString
        self.core = Core<Double>()
    }
}
