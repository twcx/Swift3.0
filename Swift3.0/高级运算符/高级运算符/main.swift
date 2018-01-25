//
//  main.swift
//  高级运算符
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* Swift 中的算术运算符默认是不会溢出的 */

// 所有溢出行为都会被捕获并报告为错误
// 如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）
// 所有的这些溢出运算符都是以 & 开头的




//MARK:位运算符

/* 位运算符可以操作数据结构中每个独立的比特位 */




//MARK:按位取反运算符

/* 按位取反运算符（~）可以对一个数值的全部比特位进行取反： */

// 按位取反运算符是一个前缀运算符，需要直接放在运算的数之前，并且它们之间不能添加任何空格

let initialBits: UInt8 = 0b00001111 // 这个值等价于十进制的 15
let invertedBits = ~initialBits // 等于 0b1111000，等价于无符号十进制数的 240

/* UInt8 类型的整数有 8 个比特位，可以存储 0 ~ 255 之间的任意整数 */






//MARK:按位与运算符

/* 按位与运算符（&）可以对两个数的比特位进行合并 */

// 它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 等于 00111100，等价于无符号十进制数的 60





//MARK:按位或运算符

/* 按位或运算符（|）可以对两个数的比特位进行比较 */

// 它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1

let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits // 等于 11111110，等价于无符号十进制数的 254





//MARK:按位异或运算符

/* 按位异或运算符（^）可以对两个数的比特位进行比较 */

// 它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1

let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 等于 00010001





//MARK:按位左移、右移运算符

/*
 按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
 
 对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算：
 - 将一个整数左移一位，等价于将这个数乘以 2
 - 将一个整数右移一位，等价于将这个数除以 2
 */


/* 无符号整数的移位运算
 1.已经存在的位按指定的位数进行左移和右移。
 2.任何因移动而超出整型存储范围的位都会被丢弃。
 3.用 0 来填充移位后产生的空白位。
 
 这种方法称为【逻辑移位】
 */

// 11111111 << 1（即把 11111111 向左移动 1 位）
// 11111111 >> 1（即把 11111111 向右移动 1 位）

let shiftBits: UInt8 = 4    // 即二进制的 00000100
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000001


let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16      // redComponent 是 0xCC，即 204
let greenComponent  = (pink & 0x00FF00) >> 8    // greenComponent 是 0x66，即 102
let blueComponent = pink & 0x0000FF             // blueComponent 是 0x99，即 153



/* 有符号整数的移位运算 */

// 有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数

// 负数的表示通常被称为二进制补码表示

// 使用二进制补码可以使负数的按位左移和右移运算得到跟正数同样的效果，即每向左移一位就将自身的数值乘以 2，每向右一位就将自身的数值除以 2

// 算术移位：当对整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0






//MARK:溢出运算符

/* 在默认情况下，当向一个整数赋予超过它容量的值时，Swift 默认会报错，而不是生成一个无效的数。这个行为为我们在运算过大或着过小的数的时候提供了额外的安全性 */

var potentialOverflow = Int16.max
// potentialOverflow 的值是 32767，这是 Int16 能容纳的最大整数
//potentialOverflow += 1
// 这里会报错


//使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算
// - 溢出加法 &+
// - 溢出减法 &-
// - 溢出乘法 &*






//MARK:数值溢出

/* 数值有可能出现上溢或者下溢 */

var unsignedOverflow = UInt8.max
// unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
unsignedOverflow = unsignedOverflow &+ 1
// 此时 unsignedOverflow 等于 0


unsignedOverflow = UInt8.min
// unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
unsignedOverflow = unsignedOverflow &- 1
// 此时 unsignedOverflow 等于 255

// 对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大的数。



var signedOverflow = Int8.min
// signedOverflow 等于 Int8 所能容纳的最小整数 -128
signedOverflow = signedOverflow &- 1
// 此时 signedOverflow 等于 127






//MARK:优先级和结合性

/* 运算符的优先级使得一些运算符优先于其他运算符，高优先级的运算符会先被计算 */

// 2 + 3 % 4 * 5
// 2 + ((3 % 4) * 5)
// 2 + (3 * 5)
// 2 + 15
// 17






//MARK:运算符函数

/* 类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载 */

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector 是一个新的 Vector2D 实例，值为 (5.0, 5.0)







//MARK:前缀和后缀运算符

/* 类与结构体也能提供标准单目运算符的实现 */

// 单目运算符只运算一个值

//当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
let alsoPositive = -negative
// alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例







//MARK:复合赋值运算符

/* 复合赋值运算符将赋值运算符（=）与其它运算符进行结合 */

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 的值现在为 (4.0, 6.0)

// 不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载







//MARK:等价运算符

/* 自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为“相等”运算符（==）与“不等”运算符（!=） */


extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherVector {
    print("These two vectors are equivalent.")
}





//MARK:自定义运算符

/* 新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符： */

prefix operator +++

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在的值为 (2.0, 8.0)
// afterDoubling 现在的值也为 (2.0, 8.0)






//MARK:自定义中缀运算符的优先级

/* 每个自定义中缀运算符都属于某个优先级组 */

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)


// 当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算

