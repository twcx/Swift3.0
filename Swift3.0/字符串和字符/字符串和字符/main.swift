//
//  main.swift
//  字符串和字符
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//print("Hello, World!")


//初始化空字符串
var emptyString = ""    //空字符串字面量
var anotherEmptySting = String()    //初始化方法
//两个字符串均为空并等价

if emptyString.isEmpty {
    print("Nothing to see herer")
}


//字符串可变性
//通过关键字‘var’来声明变量的可变性
var variableString = "Horse"
variableString += "and carriage"
print(variableString)

/*
let variableString = "Highlander"
variableString += "and other Hignlander"
这会报告一个编译错误：常量字符串不可以被修改
*/


//字符串是值类型
//Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。
//任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作

//Swift 默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值。 很明显无论该值来自于哪里，都是您独自拥有的。
//您可以确信传递的字符串不会被修改，除非你自己去修改它。




//使用字符
for character in "Dog!🐶".characters {
    print(character)
}

let exclamationMark: Character = "!"

let catCharacters: [Character] = ["C","a","t","!","🐱"]
let catString = String(catCharacters)
print(catString)


//链接字符串和字符
let string1 = "Hello"
let string2 = " there"
var welcome = string1 + string2
print(welcome)

var instruction = "look over"
instruction += string2
print(instruction)

welcome.append(exclamationMark)
print(welcome)


//字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message)
//注意：插值字符串中写在括号中的表达式不能包含非转义反斜杠 (\)，并且不能包含回车或换行符。不过，插值字符串可以包含其他字面量。


//Unicode
let wiseWords = "\"imagination is more important than knowledge\" -Einstein"
print(wiseWords)

let dollarSign = "\u{24}"
print(dollarSign)

let blackHeart = "\u{2665}"
print(blackHeart)

let sparkingHeart = "\u{1F496}"


let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́
// eAcute 是 é, combinedEAcute 是 é

let precomposed: Character = "\u{D55C}"                 // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed 是 한, decomposed 是 한


let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 是 é⃝


let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 是 🇺🇸”

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count)")


//例如，如果你用四个字符的单词cafe初始化一个新的字符串，然后添加一个COMBINING ACTUE ACCENT(U+0301)作为字符串的结尾。最终这个字符串的字符数量仍然是4，因为第四个字符是é，而不是e：
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")
// 打印输出 "the number of characters in café is 4"
/*
 注意：
 可扩展的字符群集可以组成一个或者多个 Unicode 标量。这意味着不同的字符以及相同字符的不同表示方式可能需要不同数量的内存空间来存储。所以 Swift 中的字符在一个字符串中并不一定占用相同的内存空间数量。因此在没有获取字符串的可扩展的字符群的范围时候，就不能计算出字符串的字符数量。如果您正在处理一个长字符串，需要注意characters属性必须遍历全部的 Unicode 标量，来确定字符串的字符数量。
 
 另外需要注意的是通过characters属性返回的字符数量并不总是与包含相同字符的NSString的length属性相同。NSString的length属性是利用 UTF-16 表示的十六位代码单元数字，而不是 Unicode 可扩展的字符群集。作为佐证，当一个NSString的length属性被一个Swift的String值访问时，[…]
 */




//访问和修改字符串
var greeting = ""
//print(greeting[greeting.startIndex])
//print(greeting[greeting.endIndex])
//运行时报错：试图获取越界索引对应的Character

greeting = "Guten Tag!"
print(greeting[greeting.startIndex])
//print(greeting[greeting.endIndex])    //运行时报错：试图获取越界索引对应的Character

print(greeting[greeting.index(before: greeting.endIndex)])

print(greeting[greeting.index(after: greeting.startIndex)])

let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index])


for index in greeting.characters.indices {
    print("\n\(greeting[index])")
}

for index in word.characters.indices {
    print("\n\(word[index])")
}


//插入和删除
welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
print(welcome)

welcome.insert(contentsOf: " there".characters, at: welcome.index(before: welcome.endIndex))
print(welcome);

welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
print(welcome)



//比较字符串
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}


//使用LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
//使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}


let latinCapitalLetterA: Character = "\u{41}"
print(latinCapitalLetterA)

let cyrillicCapitalLetterA: Character = "\u{0410}"
print(cyrillicCapitalLetterA)

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equal")
}

//前缀/后缀相等
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")


var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes;\(cellCount) cell scenes")



//字符串的Unioncode表现形式
let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ",terminator:"")
}
print("")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ",terminator:"")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ",terminator:"")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}




























































































