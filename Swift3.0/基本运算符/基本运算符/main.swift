//
//  main.swift
//  基本运算符
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//print("Hello, World!")


//运算符分为一元、二元和三元运算符
//一元：如-a
//二元：如a+b
//三元（也叫‘三目运算符’）：如a ? b : c

//赋值运算符


//算术运算符


//组合赋值运算符


//比较运算符
//比较元组大小会按照从左到右，逐值比较的方式，直到发现有两个值不等时停止。如果所有的值都相等，那么这一对元组我们就称它们是相等的。
//(1, "zebra") < (2, "apple") //true，因为 1 小于 2
//(3, "apple") < (3, "bird")  //true，因为 3 等于 3，但是 apple 小于 bird
//(4, "dog") == (4, "dog")    //true，因为 4 等于4，dog 等于 dog
//注意：
//Swift标准库只能比较7个以内元素的元组比较函数。如果你的元组元素超过7个时，你需要自己实现比较运算符。


//三目运算符


//空合运算符
//“空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。
//表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。”
//a != nil ? a! : b

let defaultColorName = "red"
var userDefinedColorName: String?   //默认值为 nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)



//区间运算符
//闭区间运算符 (a...b) 定义了一个包含从 a 到 b (包括 a 和 b) 的所有值的区间。a 的值不能超过 b 。
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

//半开区间运算符
//“半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间。 之所以称为半开区间，是因为该区间包含第一个值而不包括最后的值。”
let names = ["Anna", "Alex", "Brain", "Jack"]
let count = names.count
for i in 0..<count {
    print("第\(i + 1)个人叫\(names[i])")
}



//逻辑运算符
/*
“逻辑运算符的操作对象是逻辑布尔值。Swift 支持基于 C 语言的三个标准逻辑运算。

逻辑非（!a）
逻辑与（a && b）
逻辑或（a || b）”
*/
















