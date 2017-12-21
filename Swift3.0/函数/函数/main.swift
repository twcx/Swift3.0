//
//  main.swift
//  函数
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//print("Hello, World!")


//MARK:函数的定义与调用
func greet(person: String) -> String {
    let greeting = "Hello," + person + "!"
    return greeting;
}

let greeting = greet(person: "Swift")
print(greeting)



//MARK:函数参数与返回值

//MARK:无参数函数
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())


//MARK:多参数函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person);
    }
}

func greetAgain(person: String) -> String {
    return ""
}
print(greet(person: "Tim", alreadyGreeted: true))


//MARK:无返回值函数
func greets(person: String) {
    print("Hello, \(person)")
}
greets(person: "Dave")


func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

print(printAndCount(string: "hello, John"))
printWithoutCounting(string: "Hello, Lily")




//MARK:多重返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value;
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")




//MARK:可选元组返回类型

//改良版（对传入的数组执行安全检查，元组为可选返回类型）
func minMaxBetter(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    
    return minMax(array: array)
}



//MARK:函数参数标签和参数名称

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)



//MARK:指定参数标签

func someFunction(argumentLabel parameterName: Int) {
    // 在函数体内，parameterName 代表参数值
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}
print(greet(person: "Bill", from: "Cupertino"))



//MARK:忽略参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParameterName: 2)



//MARK:默认参数值

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}

// parameterWithDefault = 6
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)

// parameterWithDefault = 12
someFunction(parameterWithoutDefault: 4)



//MARK:可变参数

//一个函数最多只能拥有一个可变参数
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(1, 2, 3, 4, 5))
print(arithmeticMean(3, 8.25, 18.75))


//MARK:输入输出参数

/* 定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。
 
   你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改。
 */

//注意：输入输出参数不能有默认值，而且可变参数不能用inout标记

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


func say(_ name: inout String) {
    name = "Andy"
}

var name = "Allen"
print(name)
say(&name)
print(name)



//MARK:函数类型

/* 这两个函数的类型是 (Int, Int) -> Int，可以解读为“这个函数类型有两个 Int 型的参数并返回一个 Int 型的值。 */
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}


/* 这个函数的类型是：() -> Void，或者叫“没有参数，并返回 Void 类型的函数 */
func printHelloWorld() {
    print("hello, world")
}



//MARK:使用函数类型

/* 定义一个叫做 mathFunction 的变量，类型是‘一个有两个 Int 型的参数并返回一个 Int 型的值的函数’，并让这个新变量指向 addTwoInts 函数 */
var mathFunction: (Int, Int) -> Int = addTwoInts
//var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)
print("Result: \(mathFunction(2, 3))")

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")

// anotherMathFunction 被推断为 (Int, Int) -> Int 类型
let anotherMathFunction = addTwoInts



//MARK:函数类型作为参数类型

/* 这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数：第一个参数叫 mathFunction，类型是 (Int, Int) -> Int，你可以传入任何这种类型的函数；第二个和第三个参数叫 a 和 b，它们的类型都是 Int，这两个值作为已给出的函数的输入值。 */
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)



//MARK:函数类型作为返回类型

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
var moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("Zero!")


/* 以上所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。 */


//MARK:嵌套函数


func chooseStepFunctionAgain(backward: Bool) -> (Int) -> Int {
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    
    return backward ? stepBackward : stepForward
}

currentValue = -4
moveNearerToZero = chooseStepFunctionAgain(backward: currentValue > 0)

while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("Zero!")





















