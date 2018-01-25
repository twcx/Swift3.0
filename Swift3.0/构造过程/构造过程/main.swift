//
//  main.swift
//  构造过程
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。 */

/* 两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。 */


/*
Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程能不出错地完成：

安全检查 1
指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。

如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。

安全检查 2
指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。

安全检查 3
便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。

安全检查 4
构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用self作为一个值。

类实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，该实例才会成为有效实例，才能访问属性和调用方法。
*/

/*
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicyle: Vehicle {
    
    var quantity = 0
    
    override init() {   // 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成
        super.init()    // 之后，指定构造器才能向上代理调用父类构造器
        numberOfWheels = 2  // 然后，再为继承的属性设置新值
    }
    
    convenience init(quantity: Int) {
        self.init()   // 便利构造器必须先代理调用同一类中的其它构造器
        numberOfWheels = 3
        self.quantity = quantity
    }
}

var bicyle = Bicyle()
print(bicyle.numberOfWheels)

bicyle = Bicyle(quantity: 1)
print(bicyle.quantity)
print(bicyle.numberOfWheels)

*/
 
 

/*
以下是两段式构造过程中基于上述安全检查的构造流程展示：

阶段 1
- 某个指定构造器或便利构造器被调用。
- 完成新实例内存的分配，但此时内存还没有被初始化。
- 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
- 指定构造器将调用父类的构造器，完成父类属性的初始化。
- 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
- 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。

阶段 2
- 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
- 最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。
*/


/*
class Car: Vehicle {
    
    var name: String
    
    init(name: String) {
        self.name = name
        super.init()
        numberOfWheels = 4
    }

    override convenience init() {
        self.init(name: "Audi")
    }
    
}


class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let recipeIngredient = RecipeIngredient()
print(recipeIngredient.quantity)


let wholeNumber: Double = 12345.1
if let valueMaintained = Int(exactly: wholeNumber) {
    print(valueMaintained)
} else {
    print("does not maintain value")
}

*/


 

//MARK: ---------------------------------


//MARK:存储属性的初始赋值



//MARK:构造器
/*
 init() {
 // 在此处执行构造过程
 }
 */


struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")



//MARK:默认属性值

struct Fahrenheit1 {
    var temperature = 32.0
}



//MARK:自定义构造过程




//MARK:构造参数

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)






//MARK:参数的内部名称和外部名称


struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)





//MARK:不带外部名的构造器参数

struct Celsius1 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(31.7)
print(bodyTemperature.temperatureInCelsius)




//MARK:可选属性类型

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

cheeseQuestion.response = "Yes, I do like cheese."
print(cheeseQuestion.response!)





//MARK:构造过程中常量属性的修改

class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()

beetsQuestion.response = "I also like beets. (But not with chees.)"
print(beetsQuestion.response!)





//MARK:默认构造器


class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()






//MARK:结构体的逐一成员构造器

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)





//MARK:值类型的构造器代理

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
print("basicRect 的 origin 是 (\(basicRect.origin.x, basicRect.origin.y)，size 是 (\(basicRect.size.width, basicRect.size.height)")

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
print("originRect 的 origin 是 (\(originRect.origin.x, originRect.origin.y)，size 是 (\(originRect.size.width, originRect.size.height)")

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print("centerRect 的 origin 是 (\(centerRect.origin.x, centerRect.origin.y)，size 是 (\(centerRect.size.width, centerRect.size.height)")






//MARK:类的继承和构造过程

//MARK:指定构造器和便利构造器


//MARK:指定构造器和便利构造器的语法
/*
 init(parameters) {
 statements
 }
 */

/*
 convenience init(parameters) {
 statements
 }
 */




//MARK:类的构造器代理规则

//MARK:两段式构造过程

//MARK:构造器的继承和重写


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")


class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")




//MARK:构造器的自动继承


//MARK:指定构造器和便利构造器实践

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
print(namedMeat.name)

let mysteryMeat = Food()
print(mysteryMeat.name)


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
print(oneMysteryItem.name)
print(oneMysteryItem.quantity)

let oneBacon = RecipeIngredient(name: "Bacon")
print(oneBacon.name)
print(oneBacon.quantity)

let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
print(sixEggs.name)
print(sixEggs.quantity)


class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name) "
        output += purchased ? "✔" : "✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem1(),
    ShoppingListItem1(name: "Bacon"),
    ShoppingListItem1(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}






//MARK:可失败构造器


let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value")
}

let valueChanged = Int(exactly: pi)
// valueChanged 是 Int? 类型，不是 Int 类型

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}



struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
// someCreature 的类型是 Animal? 而不是 Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}


let anonymousCreature = Animal(species: "")
// anonymousCreature 的类型是 Animal? 而不是 Animal

if anonymousCreature == nil {
    print("Tje anonymous creature could not be initialized")
}





//MARK:枚举类型的可失败构造器

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheit = TemperatureUnit(symbol: "F")
if fahrenheit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit = TemperatureUnit(symbol: "X")
if unknowUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}





//MARK:带原始值的枚举类型的可失败构造器

enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit1(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit1 = TemperatureUnit1(rawValue: "X")
if unknowUnit1 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}






//MARK:构造失败的传递

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CarItem1: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CarItem1(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CarItem1(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}


if let oneUnnamed = CarItem1(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}






//MARK:重写一个可失败构造器

class Document {
    var name: String?
    // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
    init() {}
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}


class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}






//MARK:可失败构造器 init!


//MARK:必要构造器

class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}



class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}



//MARK:通过闭包或函数设置属性的默认值

/*
 class SomeClass {
 let someProperty: SomeType = {
 // 在这个闭包中给 someProperty 创建一个默认值
 // someValue 必须和 SomeType 类型相同
 return someValue
 }()
 }
 */

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// 打印 "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// 打印 "false"
