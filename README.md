# Calculator

This example is also part of the homework 1. So some features are not all implemented. (Leave as homework)

## Integrate with Cocoapods

`CocoaPods` is used as package manager in `Cocoa` and `CocoaTouch` development. If you never use it before, don't worry
this is planned to be taught in future classes.

You can use `CocoaPods` to integrate this Core by adding following lines to your `Podfile`:
```ruby
pod 'CalculatorCore', :git => 'https://github.com/sodascourse/calculator.git', :branch => 'master'
```

And use following line to include this core when you need it:
```swift
import CalculatorCore
```

## Integrate manually

Just drag this file `CalculatorCore/CalculatorCore.swift` into your Xcode project. Since then this core is actually
part of your project, you don't need the `import` statement.
