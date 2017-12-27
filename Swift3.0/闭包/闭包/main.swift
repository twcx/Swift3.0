//
//  main.swift
//  闭包
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。 */

/*
 在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一：
 
 全局函数是一个有名字但不会捕获任何值的闭包
 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
 Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：
 
 利用上下文推断参数和返回值类型
 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
 参数名称缩写
 尾随闭包语法
 */


//MARK:闭包表达式

/* 嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式 */

/* 闭包表达式是一种利用简洁语法构建内联闭包的方式 */




//MARK:sorted 方法

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
//倒序输出
print(reversedNames)



//MARK:闭包表达式语法

/*
{   (parameters) -> returnType in
        statements
}
*/

/* 在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外 */
/* 闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始 */


reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})




//MARK:根据上下文推断类型

/* 所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略 */

reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})




//MARK:单表达式闭包隐式返回

/* 单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果 */

reversedNames = names.sorted(by: {s1, s2 in s1 > s2})




//MARK:参数名称缩写

/* 如果你在闭包表达式中使用参数名称缩写，你可以在闭包定义中省略参数列表，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成 */

reversedNames = names.sorted(by: { $0 > $1 } )

//使用 尾随闭包 改写：
reversedNames = names.sorted() { $0 > $1 }

//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
reversedNames = names.sorted { $0 > $1 }



//MARK:运算符方法

/* 实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现 */

reversedNames = names.sorted(by: >)




//MARK:尾随闭包

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}


// 下例介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值的数组["OneSix", "FiveEight", "FiveOneZero"]：

let digitNames = [0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
                  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    
    var number = number
    var output = ""
    
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
print(strings)





//MARK:值捕获

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

print(incrementByTen()) // 10
print(incrementByTen()) // 20
print(incrementByTen()) // 30

//如果你创建了另一个 incrementer，它会有属于自己的引用，指向一个全新、独立的 runningTotal 变量：
let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())   // 7

//再次调用原来的 incrementByTen 会继续增加它自己的 runningTotal 变量，该变量和 incrementBySeven 中捕获的变量没有任何联系：
print(incrementByTen()) // 40


//MARK:闭包是引用类型

/* 上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
 
 无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用 incrementByTen 是一个常量，而并非闭包内容本身。
 
 这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：
 */

let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen()) // 50




//MARK:逃逸闭包

/* 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸 */

/* 当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的 */

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

/* 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self。比如说，在下面的代码中，传递到 someFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 self
 */

func someFunctionWithNonespcapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        
        someFunctionWithNonespcapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)   // 200

completionHandlers.first?()
print(instance.x)   // 100


//MARK:自动闭包

/* 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式 */

/* 这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
 */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)    // 5

let customerProvider = { customersInLine.remove(at: 0) }
//等同于 let customerProvider = () -> String { customersInLine.remove(at: 0) }

print(customersInLine.count)    // 5

print("Now serving \(customerProvider())!")
print(customersInLine.count)    // 4

//customerProvider 的类型不是 String，而是 () -> String，一个没有参数且返回值为 String 的函数

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: { customersInLine.remove(at: 0) })
//等同于 serve(customer: customerProvider)


/* 下面这个版本的 serve(customer:) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
 */

func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。


/* 如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性 */

var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closure.")
// 打印 "Collected 2 closures."

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// 打印 "Now serving Barry!"
// 打印 "Now serving Daniella!"

