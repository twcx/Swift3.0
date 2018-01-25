//
//  main.swift
//  错误处理
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 错误处理（Error handling）是响应错误以及从错误中恢复的过程 */

// Swift 中的错误处理涉及到错误处理模式，这会用到 Cocoa 和 Objective-C 中的NSError



//MARK:表示并抛出错

/* 错误用符合Error协议的类型的值来表示 */

enum VendingMachineError: Error {
    case invalidSelection                       //选择无效
    case insufficientFunds(coinsNeeded: Int)    //金额不足
    case outOfStock                             //缺货
}

/* 抛出错误使用throw关键字 */
// 抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)





//MARK:处理错误

/* 某个错误被抛出时，附近的某部分代码必须负责处理这个错误，例如纠正这个问题、尝试另外一种方式、或是向用户报告错误 */

// Swift 中有4种处理错误的方式：
// - 可以把函数抛出的错误传递给调用此函数的代码
// - 用do-catch语句处理错误
// - 将错误作为可选类型处理
// - 断言此错误根本不会发生

/* Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的 */





//MARK:用 throwing 函数传递错误

/*
 为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。一个标有throws关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。
 */

// func canThrowErrors() throws -> String
// func cannotThrowErrors() -> String

/* 只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。 */

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}



let favoritesSnacks = ["Alice": "Chips",
                       "Bob": "Licorice",
                       "Eve": "Pretzels",
]
func buyFavoritesSnack(person: String, vendingMachine: VendingMachine) throws {
    let sanckName = favoritesSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: sanckName)
}



struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}





//MARK:用 Do-Catch 处理错误

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoritesSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}





//MARK:将错误转换成可选值

/*
 func someThrowingFunction() throws -> Int {
 // ...
 }
 
 let x = try? someThrowingFunction()
 
 let y: Int?
 do {
 y = try someThrowingFunction()
 } catch {
 y
 }
 */


/*
 func fetchData() -> Data? {
 if let data = try? fetchDataFromDisk() {
 return data
 }
 
 if let data = try? fetchDataFromServer() {
 return data
 }
 
 return nil
 }
 */






//MARK:禁用错误传递

/*
 有时你知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。
 */

// let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")






//MARK:指定清理操作

// defer语句将代码的执行延迟到当前的作用域退出之前
// 延迟执行的语句不能包含任何控制转移语句，例如break、return语句，或是抛出一个错误
// 延迟执行的操作会按照它们声明的顺序从后往前执行——也就是说，第一条defer语句中的代码最后才执行，第二条defer语句中的代码倒数第二个执行，以此类推。最后一条语句会第一个执行


/*
 func processFile(filename: String) throws {
 if exists(filename) {
 let file = open(filename)
 defer {
 close(file)
 }
 while let line = try file.readline() {
 // 处理文件
 }
 // close(file) 会在这里被调用，即作用域的最后。
 }
 }
 */

