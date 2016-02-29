//
//  CalculatorCore.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

/// Steps are inputs from users. It would be a number or an arithmetic operation, like add.
public enum Step<ValueType: IntegerLiteralConvertible> {
    // Following `typealias` would be changed to `associatedtype` in Swift 2.2
    public typealias OperandType = ValueType
    public typealias OperatorType = (OperandType, OperandType) -> OperandType

    case Operator(OperatorType)
    case Operand(OperandType)
}

/**
 Errors which related to the Core

 - StepOrderInconsistency: The steps should be ordered by one operand, one operator, one operand, one operator, ...
 - LastStepIsOperator:     The last step should be an operand when calling `calculation` method
 */
public enum CoreError: ErrorType {
    case StepOrderInconsistency
    case LastStepIsOperator
}

/**
 *  See playground for usage
 */
public struct Core<ValueType: IntegerLiteralConvertible> {
    public typealias OperandType = Step<ValueType>.OperandType
    public typealias OperatorType = Step<ValueType>.OperatorType
    var steps: [Step<ValueType>] = []

    public init() {}

    public mutating func addStep(operand: Step<ValueType>.OperandType) throws {
        if !self.steps.isEmpty {
            guard case .Operator? = self.steps.last else {
                throw CoreError.StepOrderInconsistency
            }
        }
        self.steps.append(.Operand(operand))
    }

    public mutating func addStep(operation: Step<ValueType>.OperatorType) throws {
        guard case .Operand? = self.steps.last else {
            throw CoreError.StepOrderInconsistency
        }
        self.steps.append(.Operator(operation))
    }

    public func calculate() throws -> ValueType {
        guard case .Operand? = self.steps.last else {
            throw CoreError.LastStepIsOperator
        }

        var value: ValueType = 0
        var lastOperator: Step<ValueType>.OperatorType? = .None
        for step in self.steps {
            switch step {
            case .Operand(let operandValue):
                if let _lastOperation = lastOperator {
                    value = _lastOperation(value, operandValue)
                } else {
                    value = operandValue
                }
            case .Operator(let operation):
                lastOperator = operation
            }
        }
        return value
    }
}
