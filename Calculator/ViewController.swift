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

    /// This computed property would provide a formatted string representation of this double value.
    /// For an integer value, like `2.0`, this property would be `"2"`.
    /// And for other values like `2.4`, this would be `"2.4"`.
    fileprivate var displayString: String {
        // 1. We have to check whether this double value is an integer or not.
        //    Here I subtract the value with its floor. If the result is zero, it's an integer.
        //    (Note: `floor` means removing its fraction part, 無條件捨去.
        //           `ceiling` also removes the fraction part, but it's by adding. 無條件進位.)
        let floor = self.rounded(.towardZero)  // You should check document for the `rounded` method of double
        let isInteger = self.distance(to: floor).isZero

        let string = String(self)
        if isInteger {
            // Okay this value is an integer, so we have to remove the `.` and tail zeros.
            // 1. Find the index of `.` first
            if let indexOfDot = string.characters.index(of: ".") {
                // 2. Return the substring from 0 to the index of dot
                //    For example: "2.0" --> "2"
                return string.substring(to: indexOfDot)
            }
        }
        // Return original string representation
        return String(self)
    }
}


// MARK: Main Body

class ViewController: UIViewController {

    var core = Core<Double>()

    @IBOutlet weak var displayLabel: UILabel!

    // MARK: - View Controller Setup

    // Check the documentation. This value of this computed property decides the style of the system status bar.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Input

    @IBAction func numericButtonClicked(_ sender: UIButton) {
        // Get the digit from the button.
        // There are 2 ways to get the digit set on the button.

        // 1. By the label of the button. Like this way:
        //    (But this only works when the button title is also the digit.
        /*
        let digitText = sender.title(for: .normal)!
        */

        // 2. Use the tag to identify which button it is.
        //    First, I set the tag of each digit button from 1000 to 1009 in Storyboard.
        //    (The unset/default tag of a view is `0`.
        //     So it's better not to use `0` to check button identity. I add 1000 for this)
        let numericButtonDigit = sender.tag - 1000
        let digitText = "\(numericButtonDigit)"

        // Show the digit
        let currentText = self.displayLabel.text ?? "0"
        if currentText == "0" {
            // When the current display text is "0", replace it directly.
            self.displayLabel.text = digitText
        } else {
            // Else, append it
            self.displayLabel.text = currentText + digitText
        }
    }

    @IBAction func doubleZeroButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        // Append the `00` to the display string only when 
        // 1. the string is not zero.
        // 2. there's no `.` in the string.
        guard currentText != "0" && !currentText.contains(".") else {
            return
        }
        // Append and re-assign the string
        self.displayLabel.text = currentText + "00"
    }

    @IBAction func dotButtonClicked(_ sender: UIButton) {
        let currentText = self.displayLabel.text ?? "0"
        // Append the `.` to the display string only when there's no `.` in the string
        guard !currentText.contains(".") else {
            return
        }
        // Append and re-assign the string
        self.displayLabel.text = currentText + "."
    }

    @IBAction func clearButtonClicked(_ sender: UIButton) {
        // Clear (Reset)
        // 1. Clean the display label
        self.displayLabel.text = "0"
        // 2. Reset the core
        self.core = Core<Double>()
    }

    // MARK: - Actions

    @IBAction func operatorButtonClicked(_ sender: UIButton) {
        // Add current number into the core as a step
        let currentNumber = Double(self.displayLabel.text ?? "0")!
        try! self.core.addStep(currentNumber)
        // Clean the display to accept user's new input
        self.displayLabel.text = "0"

        // Here, I use tag to check whether the button it is.
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
        // Add current number into the core as a step
        let currentNumber = Double(self.displayLabel.text ?? "0")!
        try! self.core.addStep(currentNumber)
        // Get and show the result
        let result = self.core.calculate()!
        self.displayLabel.text = result.displayString
        // Reset the core
        self.core = Core<Double>()
    }
}
