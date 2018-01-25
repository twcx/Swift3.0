//
//  main.swift
//  泛型
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型 */

/* 它能让你避免代码的重复，用一种清晰和抽象的方式来表达代码的意图 */



//MARK:泛型所解决的问题

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/* a 和 b 类型必须相同。如果 a 和 b 类型不同，那它们俩就不能互换值 */




//MARK:泛型函数

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 占位类型名（在这里用字面T来表示）来代替实际类型名
swapTwoValues(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)





//MARK:类型参数

// 占位类型T是类型参数的一个例子。

/* 类型参数指定并命名一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来（例如<T>）。 */




//MARK:命名类型参数

// Dictionary<Key, Value>
// Array<Element>




//MARK:泛型类型

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//泛型版本
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()






//MARK:扩展一个泛型类型

/* 当你扩展一个泛型类型的时候，你并不需要在扩展的定义中提供类型参数列表 */

//原始类型定义中声明的类型参数列表在扩展中可以直接使用，并且这些来自原始类型中的参数名称会被用作原始定义中类型参数的引用

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}





//MARK:类型约束

/* 类型约束可以指定一个类型参数必须继承自指定类，或者符合一个特定的协议或协议组合 */




//MARK:类型约束语法

/*
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
 // 这里是泛型函数的函数体部分
 }
 */


//上面这个函数有两个类型参数。第一个类型参数 T，有一个要求 T 必须是 SomeClass 子类的类型约束；第二个类型参数 U，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。




//MARK:类型约束实践

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}


func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])





//MARK:关联类型

/* 关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定 */

/* 通过 associatedtype 关键字来指定关联类型 */




//MARK:关联类型实践

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


struct IntStack2: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


struct Stack2<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}






//MARK:通过扩展一个存在的类型来指定关联类型

extension Array: Container {}





//MARK:约束关联类型

//你可以给协议里的关联类型添加类型注释，让遵守协议的类型必须遵循这个约束条件

protocol Container2 {
    associatedtype ItemType: Equatable
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}




//MARK:泛型 where 语句

/*
 类型约束让你能够为泛型函数，下标，类型的类型参数定义一些强制要求。
 
 为关联类型定义约束也是非常有用的。你可以在参数列表中通过 where 子句为关联类型定义约束。
 你能通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。
 你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。
 你可以在函数体或者类型的大括号之前添加 where 子句。
 */


func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
        
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 所有元素都匹配，返回 true
        return true
}

var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}





//MARK:具有泛型 where 子句的扩展

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

struct NotEquatable {}
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // 报错



extension Container where ItemType: Equatable {
    func startWith(_ item: ItemType) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}

extension Container where ItemType == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())





//MARK:具有泛型 where 子句的关联类型


//你可以在关联类型后面加上具有泛型 where 的字句

protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

//一个协议继承了另一个协议，你通过在协议声明的时候，包含泛型 where 子句，来添加了一个约束到被继承协议的关联类型

protocol ComparableContainer: Container3 where Item: Comparable {}





//MARK:泛型下标

//下标能够是泛型的，他们能够包含泛型 where 子句。你可以把占位符类型的名称写在 subscript 后面的尖括号里，在下标代码体开始的标志的花括号之前写下泛型 where 子句

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [ItemType]
        where Indices.Iterator.Element == Int {
            var result = [ItemType]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}

