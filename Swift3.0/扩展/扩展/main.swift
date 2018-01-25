//
//  main.swift
//  扩展
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能 */

//这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）

//扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）

/*
 Swift 中的扩展可以：
 
 - 添加计算型属性和计算型类型属性
 - 定义实例方法和类型方法
 - 提供新的构造器
 - 定义下标
 - 定义和使用新的嵌套类型
 - 使一个已有类型符合某个协议
 */


/* 扩展可以为一个类型添加新的功能，但是不能重写已有的功能 */



//MARK:扩展语法

//使用关键字 extension 来声明扩展：

/*
 extension SomeType {
 // 为 SomeType 添加的新功能写到这里
 }
 */



//可以通过扩展来扩展一个已有类型，使其采纳一个或多个协议。在这种情况下，无论是类还是结构体，协议名字的书写方式完全一样：

/*
 extension SomeType: SomeProtocol, AnotherProtocol {
 // 协议实现写到这里
 }
 */

//如果你通过扩展为一个已有类型添加新功能，那么新功能对该类型的所有已有实例都是可用的，即使它们是在这个扩展定义之前创建的





//MARK:计算型属性

extension Double {
    var km: Double { return self * 1_000.0 }
    var m:  Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
// 这些属性是只读的计算型属性，为了更简洁，省略了 get 关键字。

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let twoMeters = 2.0.m
print("Two meters is \(twoMeters) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

/* 扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器 */




//MARK:构造器

/* 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。 */

/* 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。 */


struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

//默认构造器
let defaultRect = Rect()
//逐一成员构造器
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

//扩展
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

//如果你使用扩展提供了一个新的构造器，你依旧有责任确保构造过程能够让实例完全初始化。





//MARK:方法

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

//函数调用
3.repetitions(task: {
    print("Hello")
})

//尾随闭包调用函数
3.repetitions() {
    print("World")
}

//函数体只有一个闭包参数，省略括号
3.repetitions {
    print("Goodbye!")
}





//MARK:可变实例方法


extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print(someInt)





//MARK:下标

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

//746381295[0]
//746381295[1]
//746381295[2]
//746381295[8]
//746381295[9]





//MARK:嵌套类型

extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}


func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

