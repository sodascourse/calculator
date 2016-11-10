//
//  CalculatorCore.swift
//  Calculator
//
//  Created by sodas on 2/28/16.
//  Copyright © 2016 sodas. All rights reserved.
//

public enum _Error: Swift.Error {
    case invalidStepOrder
}

public enum _Step<Operand, Operator> {
    case operand(Operand)
    case `operator`(Operator)
}

public struct Core<Value> {
    public typealias Operand = Value
    public typealias Operator = (Value, Value) -> Value
    public typealias Step = _Step<Operand, Operator>
    public typealias Error = _Error

    private var steps = [Step]()

    public init() {}

    public mutating func addStep(_ step: Operand) throws {
        if !self.steps.isEmpty {
            guard case .operator? = self.steps.last else {
                throw Error.invalidStepOrder
            }
        }
        self.steps.append(.operand(step))
    }

    public mutating func addStep(_ step: @escaping Operator) throws {
        guard case .operand? = self.steps.last else {
            throw Error.invalidStepOrder
        }
        self.steps.append(.operator(step))
    }

    public func calculate() -> Operand? {
        guard case .operand? = self.steps.last else {
            return .none
        }
        var value: Operand!
        var lastOperator: Operator? = .none
        for step in self.steps {
            switch step {
            case .operand(let operandValue):
                value = lastOperator?(value, operandValue) ?? operandValue
            case .operator(let operation):
                lastOperator = operation
            }
        }
        return value
    }
}
