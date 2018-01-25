//
//  main.swift
//  析构过程
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 析构器只适用于类类型 */

/* 当一个类的实例被释放之前，析构器会被立即调用 */

/* 析构器用关键字deinit来标示，类似于构造器要用init来标示 */



//MARK:析构过程原理

/* Swift 会自动释放不再需要的实例以释放资源 */

//在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数
/*
 deinit {
 // 执行析构过程
 }
 */

/* 析构器是在实例释放发生前被自动调用 */

//不能主动调用析构器

//子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。

//析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）






//MARK:析构器实践


class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}



class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")

print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")

print("The bank now only has \(Bank.coinsInBank) coins left")


playerOne = nil

print("PlayOne has left the game")

print("The Bank has \(Bank.coinsInBank) coins")

