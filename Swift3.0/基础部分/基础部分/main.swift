//
//  main.swift
//  基础部分
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//print("Hello, World!")


//常量和变量
//常量是特殊的变量，常量的值一旦设定就不能改变，而变量的值可随意更改

//声明常量和变量
//let 声明常量
//var 声明变量

let a = 10
var b = 0

//用逗号隔开
var x = 0.0, y = 0.0, z = 0.0

//类型标注
//添加类型标注，需要在常量名或者变量名后面加上一个冒号和空格，然后加上类型名称
var welcomeMsg: String
welcomeMsg = "Hello"

var red, green, blue: Double

//常量和变量的命名
//任意字符作为常量和变量名
let π = 3.1415926
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

//注意：如果你需要使用与Swift保留关键字相同的名称作为常量或者变量名，你可以使用反引号（`）将关键字包围的方式将其作为名字使用。无论如何，你应当避免使用关键字作为常量或变量名，除非你别无选择。
let `let` = "let"
print(`let`)


//打印
/*
print(<#T##items: Any...##Any#>)
print(<#T##items: Any...##Any#>, to: &<#T##Target#>)
print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)
print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>, to: &<#T##Target#>)
debugPrint(<#T##items: Any...##Any#>)
...
*/


//Swift支持嵌套多行注释
//Swift不强制在每条语句后面加分号，但多条独立语句写在同一行时必须要用分号


//整数
//整数就是没有小数部分的数字，比如 42 和 -23 。整数可以是 有符号（正、负、零）或者 无符号（正、零）。

//Int,Int8,Int16,Int32,Int64,IntMax
//UInt,UInt8,UInt16,UInt32,UInt64,UIntMax
let min_Int = Int.min
let max_Int = Int.max
print("Int:\(min_Int) - \(max_Int)")

let min_Int8 = Int8.min
let max_Int8 = Int8.max
print("Int8:\(min_Int8) - \(max_Int8)")

let min_Int16 = Int16.min
let max_Int16 = Int16.max
print("Int16:\(min_Int16) - \(max_Int16)")

let min_Int32 = Int32.min
let max_Int32 = Int32.max
print("Int32:\(min_Int32) - \(max_Int32)")

let min_Int64 = Int64.min
let max_Int64 = Int64.max
print("Int64:\(min_Int64) - \(max_Int64)")

let min_IntMax = IntMax.min
let max_IntMax = IntMax.max
print("IntMax:\(min_IntMax) - \(max_IntMax)")

let min_UInt = UInt.min
let max_UInt = UInt.max
print("UInt:\(min_UInt) - \(max_UInt)")

let min_UInt8 = UInt8.min
let max_UInt8 = UInt8.max
print("UInt8:\(min_UInt8) - \(max_UInt8)")

let min_UInt16 = UInt16.min
let max_UInt16 = UInt16.max
print("UInt16:\(min_UInt16) - \(max_UInt16)")

let min_UInt32 = UInt32.min
let max_UInt32 = UInt32.max
print("UInt32:\(min_UInt32) - \(max_UInt32)")

let min_UInt64 = UInt64.min
let max_UInt64 = UInt64.max
print("UInt64:\(min_UInt64) - \(max_UInt64)")

let min_UIntMax = UIntMax.min
let max_UIntMax = UIntMax.max
print("UIntMax:\(min_UIntMax) - \(max_UIntMax)")


//数值型字面量
//一个十进制数，没有前缀
//一个二进制数，前缀是0b
//一个八进制数，前缀是0o
//一个十六进制数，前缀是0x

let decimalInteger = 17
let binaryInteger = 0b10001       // 二进制的17
let octalInteger = 0o21           // 八进制的17
let hexadecimalInteger = 0x11     // 十六进制的17

/*
浮点字面量可以是十进制（没有前缀）或者是十六进制（前缀是 0x ）。小数点两边必须有至少一个十进制数字（或者是十六进制的数字）。十进制浮点数也可以有一个可选的指数（exponent)，通过大写或者小写的 e 来指定；十六进制浮点数必须有一个指数，通过大写或者小写的 p 来指定。

如果一个十进制数的指数为 exp，那这个数相当于基数和10^exp的乘积：

1.25e2 表示 1.25 × 10^2，等于 125.0。
1.25e-2 表示 1.25 × 10^-2，等于 0.0125。
如果一个十六进制数的指数为exp，那这个数相当于基数和2^exp的乘积：

0xFp2 表示 15 × 2^2，等于 60.0。
0xFp-2 表示 15 × 2^-2，等于 3.75。
下面的这些浮点字面量都等于十进制的12.1875：

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
*/

//数值类字面量可以包括额外的格式来增强可读性。整数和浮点数都可以添加额外的零并且包含下划线，并不会影响字面量：
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1



//类型别名
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
print(maxAmplitudeFound)




//元组
//组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。

let http404Error = (404, "Not Found")
// http404Error 的类型是 (Int, String)，值是 (404, "Not Found")

let (statusCode, statusMessage) = http404Error
//let (statusCode, statusMessage): (Int, String) = http404Error

print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

//如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记：
let (justTheStatusCode, _) = http404Error
print(justTheStatusCode)

//通过下标来访问元组中的单个元素，下标从零开始：
print(http404Error.0, http404Error.1)


let http200Status = (statusCode: 200, description: "OK")
print(http200Status.statusCode, http200Status.description)

let http500Status = (statusCode: 500, "Service Exception")
print(http500Status.statusCode, http500Status.1)


