//: This playground is a demo of `CalculatorCore` framework.

import CalculatorCore

var calculatorCore = Core<Double>()
do {
    try calculatorCore.addStep(2.5)
    try calculatorCore.addStep(*)
    try calculatorCore.addStep(16.8)
    // `result` should be `42`
    let result = calculatorCore.calculate()!
    print("2.5 * 16.8 = \(result)")
} catch {
    print("Fatal error ...")
}

//: To reset the core, just create a new one

calculatorCore = Core<Double>()  // Reset it
do {
    try calculatorCore.addStep(1)
    try calculatorCore.addStep(/)
    try calculatorCore.addStep(2)
    // `result` should be `0.5`.
    let result = calculatorCore.calculate()!
    print("1 / 2 = \(result)")
} catch {
    print("Fatal error ...")
}

//: The core works like real calculator - yes, without the concept of operator precedence

calculatorCore = Core<Double>()  // Reset it
do {
    try calculatorCore.addStep(2)
    try calculatorCore.addStep(+)
    try calculatorCore.addStep(4)
    try calculatorCore.addStep(*)
    try calculatorCore.addStep(7)
    // `result` should be `42` too
    let result = calculatorCore.calculate()!
    print("(2 + 4) * 7 = \(result)")
} catch {
    print("Fatal error ...")
}

//: A core which works with only integer

var integerCore = Core<Int>()
do {
    try integerCore.addStep(1)
    try integerCore.addStep(/)
    try integerCore.addStep(2)
    // `result` should be `zero`.
    let result = integerCore.calculate()!
    print("1 / 2 = \(result)")
} catch {
    print("Fatal error ...")
}
print("===\n")

//:
//: Step Rules:
//: 1. The first step should be an operand. (A number)
//: 2. Steps should be a sequence with operands and operators, like 
//:    `[Operand, Operator, Operand, Operator, Operand]`
//: 3. The last step should be an operand.

calculatorCore = Core<Double>()  // Reset it
do {
    try calculatorCore.addStep(+)
} catch Core.Error.invalidStepOrder {
    print(">> 1. The first step should be an operand.")
}

calculatorCore = Core<Double>()  // Reset it
try! calculatorCore.addStep(1)
do {
    try calculatorCore.addStep(1)
} catch Core.Error.invalidStepOrder {
    print(">> 2. An operand should be followed by an operator.")
}

calculatorCore = Core<Double>()  // Reset it
try! calculatorCore.addStep(1)
try! calculatorCore.addStep(*)
do {
    try calculatorCore.addStep(+)
} catch Core.Error.invalidStepOrder {
    print(">> 3. An operator should be followed by an operand.")
}

calculatorCore = Core<Double>()  // Reset it
try! calculatorCore.addStep(1)
try! calculatorCore.addStep(*)
if calculatorCore.calculate() == nil {
    print(">> 4. The last step should be an operand.")
}
