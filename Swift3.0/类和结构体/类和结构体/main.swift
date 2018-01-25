//
//  main.swift
//  类和结构体
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 类和结构体是人们构建代码所用的一种通用且灵活的构造体 */

//通常一个类的实例被称为对象。然而在 Swift 中，类和结构体的关系要比在其他语言中更加的密切，本章中所讨论的大部分功能都可以用在类和结构体上。因此，我们会主要使用实例。


//MARK:类和结构体对比

/* 共同点：
 - 定义属性用于存储值
 - 定义方法用于提供功能
 - 定义下标操作使得可以通过下标语法来访问实例所包含的值
 - 定义构造器用于生成初始化值
 - 通过扩展以增加默认实现的功能
 - 实现协议以提供某种标准功能
 */

/* 类的附加功能：
 - 继承允许一个类继承另一个类的特征
 - 类型转换允许在运行时检查和解释一个类实例的类型
 - 析构器允许一个类实例释放任何其所被分配的资源
 - 引用计数允许对一个类的多次引用
 */


//结构体总是通过被复制的方式在代码中传递，不使用引用计数。




//MARK:定义语法

class SomeClass {
    // 在这里定义类
}

struct SomeStructure {
    // 在这里定义结构体
}


struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}





//MARK:类和结构体实例

let someResolution = Resolution()
let someVideoMode = VideoMode()




//MARK:属性访问

print("The width of someResolution is \(someResolution.width)")

print("The width of someVideoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")




//MARK:结构体类型的成员逐一构造器

let vga = Resolution(width: 640, height: 480)
//let vga = Resolution.init(width: 640, height: 480)




//MARK:结构体和枚举是值类型

/* 值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。 */

//实际上，在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。

//在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。


let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
//cinema的值其实是hd的一个拷贝副本，而不是hd本身

cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")
//在将hd赋予给cinema的时候，实际上是将hd中所存储的值进行拷贝，然后将拷贝的数据存储到新的cinema实例中

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}




//MARK:类是引用类型

/* 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")





//MARK:恒等运算符

// === 等价于
// !== 不等价于

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}

/*
 “等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
 
 “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
 “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
 */





//MARK:指针

/*
 如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地址，也不要求你使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同
 */




//MARK:类和结构体的选择

/* 按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
 
 - 该数据结构的主要目的是用来封装少量相关简单数据值。
 - 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
 - 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
 - 该数据结构不需要去继承另一个既有类型的属性或者行为。
 */




//MARK:字符串、数组和字典类型的赋值与复制行为

/*
 Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
 
 Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
 
 注意
 以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Swift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回避赋值来保证性能最优化。
 */

