//
//  main.swift
//  方法
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 方法是与某些特定类型相关联的函数 */

/* 类型方法与 Objective-C 中的类方法（class methods）相似 */

/* 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一 */

//类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。
//类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联



//MARK:实例方法

/* 实例方法是属于某个特定类、结构体或者枚举类型实例的方法 */

//实例方法要写在它所属的类型的前后大括号之间。
//实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。
//实例方法只能被它所属的类的某个特定实例调用。
//实例方法不能脱离于现存的实例而被调用。


class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()
print(counter.count)

counter.increment()
print(counter.count)

counter.increment(by: 5)
print(counter.count)

counter.reset()
print(counter.count)




//MARK:self属性

/* 类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身 */

class Person {
    var name = ""
    
    func changeName(_ newName: String) {
        self.name = newName;
    }
}

let person = Person()
person.changeName("Lily")
print(person.name)

/* 实例方法的某个参数名称与实例的某个属性名称相同的时候：参数名称享有优先权 */

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}




//MARK:在实例方法中修改值类型


struct PPoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    /* 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。 */
    /*
     // 编译报错
     func changeX(x: Double) {
     self.x = x
     }
     */
}
var somePPoint = PPoint(x: 1.0, y: 1.0)
somePPoint.moveByX(deltaX: 2.0, y: 3.0)
print("The point is now at (\(somePPoint.x), \(somePPoint.y)")

//不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性




//MARK:在可变方法中给self赋值

struct EPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = EPoint(x: x + deltaX, y: y + deltaY)
    }
}

var someEPoint = EPoint(x: 2.0, y: 2.0)
someEPoint.moveBy(x: 3.0, y: 4.0)
print("The point is now at (\(someEPoint.x), \(someEPoint.y)")


enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()




//MARK:类型方法

//实例方法是被某个类型的实例调用的方法。
//在类型本身上调用的方法，这种方法就叫做类型方法。
//在方法的 func 关键字之前加上关键字 static ，来指定类型方法。
//类还可以用关键字 class 来允许子类重写父类的方法实现。

class SomeClass {
    class func someTypeMethod() {
        // 在这里实现类型方法
    }
}
SomeClass.someTypeMethod()



struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    // 尽管我们没有使用类似LevelTracker.highestUnlockedLevel的写法，这个类型方法还是能够访问类型属性highestUnlockedLevel
    
    
    @discardableResult  // 忽略返回值，不会产生编译警告
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")


player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}

