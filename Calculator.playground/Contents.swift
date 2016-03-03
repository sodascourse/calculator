//: This playground is a demo of `CalculatorCore` framework.

import CalculatorCore

var floatCore: Core<Float> = Core()
do {
    try floatCore.addStep(6)
    try floatCore.addStep(*)
    try floatCore.addStep(7)
    // `result` should be `42`
    let result = try floatCore.calculate()
} catch {
    print("Fatal error ...")
}

//: The core works like real calculator - yes, without the concept of operator precedence

var realCore: Core<Float> = Core()
do {
    try realCore.addStep(2)
    try realCore.addStep(+)
    try realCore.addStep(4)
    try realCore.addStep(*)
    try realCore.addStep(7)
    // `result` should be `42` too
    let result = try realCore.calculate()
} catch {
    print("Fatal error ...")
}

realCore = Core()  // Reset it
do {
    try realCore.addStep(1)
    try realCore.addStep(/)
    try realCore.addStep(2)
    // `result` should be `zero`.
    let result = try realCore.calculate()
} catch {
    print("Fatal error ...")
}

//: A core which works with only integer

var integerCore: Core<Int> = Core()
do {
    try integerCore.addStep(1)
    try integerCore.addStep(/)
    try integerCore.addStep(2)
    // `result` should be `zero`.
    let result = try integerCore.calculate()
} catch {
    print("Fatal error ...")
}
