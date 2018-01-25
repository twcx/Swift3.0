//
//  main.swift
//  嵌套类型
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//枚举常被用于为特定类或结构体实现某些功能。类似地，枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体。



//MARK:嵌套类型实践

struct BlackjackCard {
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamond = "♢", clubs = "♣"
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}


let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

let theJackOfHearts = BlackjackCard(rank: .jack, suit: .hearts)
print("theJackOfHearts: \(theJackOfHearts.description)")




//MARK:引用嵌套类型

//在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol)

