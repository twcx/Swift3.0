//
//  main.swift
//  枚举
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//MARK:枚举语法

/* 枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。 */

enum SomeEnumeration {
    // 枚举定义放在这里
}

/* 不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串，字符，或是一个整型值或浮点数。
 */

//下面是用枚举表示指南针四个方向的例子：
enum CompassPoint {
    case north
    case south
    case east
    case west
}

/* 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，north，south，east和west不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
 */


enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west

directionToHead = .east;




//MARK:使用Switch语句匹配枚举值
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth

switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}




//MARK:关联值

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85900, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}


//拓展
//附加标签
enum Trade {
    case Buy(stock: String, amount: Int)
    case Sell(stock: String, amount: Int)
}

let aTrade = Trade.Buy(stock: "APPL", amount: 500)
if case let Trade.Buy(stock, amount) = aTrade {
    print("buy \(amount) of \(stock)")
}

let tp = Trade.Buy(stock: "TSLA", amount: 100)
//let bTrade = Trade.Sell(tp) //错误❌
let bTrade = Trade.Sell(stock: "TSLA", amount: 100)

if case let Trade.Sell(stock, amount) = bTrade {
    print("buy \(amount) of \(stock)")
}

typealias Config = (RAM: Int, CPU: String, GPU: String)

func selectRAM(_ config: Config) -> Config {
    return (RAM: 32, CPU: config.CPU, GPU: config.GPU)
}

func selectCPU(_ config: Config) -> Config {
    return (RAM: config.RAM, CPU: "3.2GHZ", GPU: config.GPU)
}

func selectGPU(_ config: Config) -> Config {
    return (RAM: config.RAM, CPU: config.CPU, GPU: "NVidia")
}

enum Desktop {
    case Cube(Config)
    case Tower(Config)
    case Rack(Config)
}

let aTower = Desktop.Tower(selectGPU(selectCPU(selectRAM((0, "", "")) as Config)))

//自定义运算符
precedencegroup tt {
    associativity: left //指定结合性
    higherThan: MultiplicationPrecedence    //指定优先级
}
infix operator <^> : tt

func <^>(a: Config, f: (Config) -> Config) -> Config {
    return f(a)
}

let config = (0, "", "") <^> selectRAM <^> selectCPU <^> selectGPU
let aCube = Desktop.Cube(config)





//MARK:原始值

/* 原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的 */

/* 原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
 */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}






//MARK:原始值的隐式赋值


/* 在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
 例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0。
 */
enum OPlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/* 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。 */
enum OCompassPoint: String {
    case north, south, east, west
}
print(OCompassPoint.north)


//使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
let earthOrder = OPlanet.earth.rawValue

let sunsetDirection = OCompassPoint.west.rawValue




//MARK:使用原始值初始化枚举实例

// possiblePlanet 类型为 Planet? 值为 Planet.uranus
let possiblePlanet = OPlanet(rawValue: 7)
//let possiblePlanet = OPlanet.init(rawValue: 7)
// 等价于 let possiblePlanet: OPlanet? = OPlanet.init(rawValue: 7)


let positionToFind = 11
if let somePlanet = OPlanet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind).")
}






//MARK:递归枚举

/*
 enum ArithmeticExpression {
 case number(Int)
 indirect case addtion(ArithmeticExpression, ArithmeticExpression)
 indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
 }
 */

//在枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的：
indirect enum ArithmeticExpression {
    case number(Int)
    case addtion(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addtion(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evalute(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value;
    case let .addtion(left, right):
        return evalute(left) + evalute(right)
    case let .multiplication(left, right):
        return evalute(left) * evalute(right)
    }
}

var result = evalute(five)
result = evalute(four)
result = evalute(sum)
result = evalute(product)



//--------拓展--------

//MARK:嵌套枚举
enum Role {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    case Thief
    case Warrior
    case Knight
}

let character = Role.Thief
let weapon = Role.Weapon.Bow
let helmet = Role.Helmet.Iron


//MARK:包含枚举
struct CRole {
    enum RoleType {
        case Thief
        case Warrior
        case Knight
    }
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    let type: RoleType
    let weapon: Weapon
}

let warrior = CRole(type: .Warrior, weapon: .Sword)
//let warrior = CRole.init(type: .Warrior, weapon: .Sword)
warrior.type
warrior.weapon



//MARK:方法和属性

enum Wearable {
    enum Weight: Int {
        case Light = 1
    }
    
    enum Armor: Int {
        case Light = 2
    }
    
    case Helmet(weight: Weight, armor: Armor)
    
    func attributes() -> (weight: Int, armor: Int) {
        switch self {
        case .Helmet(let w, let a):
            return (weight: w.rawValue * 2, armor: a.rawValue * 4)
        }
    }
}

let woodenHelmetProps = Wearable.Helmet(weight: .Light, armor: .Light).attributes()
//print(woodenHelmetProps)

/* 枚举中的方法为每一个 'enum case' 而“生” */

enum Device {
    case iPad, iPhone, AppleTV, AppleWatch
    
    func introduce() -> String {
        switch self {
        case .AppleTV:
            return "\(self) was introduced 2006"
        case .iPhone:
            return "\(self) was introduced 2007"
        case .iPad:
            return "\(self) was introduced 2010"
        case .AppleWatch:
            return "\(self) was introduced 2014"
        }
    }
}
print(Device.iPhone.introduce())




//MARK:属性
enum DDevice {
    case iPad, iPhone
    
    var year: Int {
        switch self {
        case .iPhone:
            return 2007
        case .iPad:
            return 2010
        }
    }
}
print(DDevice.iPad.year)




//MARK:静态方法
enum EDevice {
    case AppleWatch
    
    static func fromSlang(term: String) -> EDevice? {
        if term == "iWatch" {
            return .AppleWatch
        }
        return nil
    }
}
print(EDevice.fromSlang(term: "iWatch"))




//MARK:可变方法
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
// ovenLight 现在等于High
ovenLight.next()
// ovenLight 现在等于Off

