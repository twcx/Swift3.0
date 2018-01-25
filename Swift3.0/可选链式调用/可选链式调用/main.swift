//
//  main.swift
//  可选链式调用
//
//  Created by yanghailong on 2017/8/16.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

/* 可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法 */

// - 如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil
// - 多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil

/* Swift 的可选链式调用和 Objective-C 中向nil发送消息有些相像，但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功 */




//MARK:使用可选链式调用代替强制展开

/* 通过在想调用的属性、方法、或下标的可选值后面放一个问号（?），可以定义一个可选链 */

//在可选值后面放一个叹号（!）来强制展开它的值
//主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误


class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

//let roomCount = john.residence!.numberOfRooms
// 这会引发运行时错误

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}





//MARK:为可选链式调用定义模型类

class Person2 {
    var residence: Residence2?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber!) \(street!)"  // 去除编译警告，加上'!'强制使用
        } else {
            return nil
        }
    }
}


class Residence2 {
    var roos = [Room]()
    var numberOfRooms: Int {
        return roos.count
    }
    subscript(i: Int) -> Room {
        get {
            return roos[i]
        }
        set {
            roos[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}





//MARK:通过可选链式调用访问属性

let joes = Person2()

if let roomCount = joes.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// john.residence为nil


let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
joes.residence?.address = someAddress
// 通过john.residence来设定address属性也会失败，因为john.residence当前为nil


func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
joes.residence?.address = createAddress()
// 没有任何打印消息，可以看出createAddress()函数并未被执行





//MARK:通过可选链式调用调用方法

/* 可以通过可选链式调用来调用方法，并判断是否调用成功，即使这个方法没有返回值 */

if joes.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (joes.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}






//MARK:通过可选链式调用访问下标

/* 通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面 */

if let firstRoomName = joes.residence?[0].name {
    print("The first room name is  \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

joes.residence?[0] = Room(name: "Bathroom")
// 赋值同样会失败，因为residence目前是nil


let johnsHouse = Residence2()
johnsHouse.roos.append(Room(name: "Living Room"))
johnsHouse.roos.append(Room(name: "Kitchen"))
joes.residence = johnsHouse

if let firstRoomName = joes.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}





//MARK:访问可选类型的下标

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
// testScores字典中没有"Brian"这个键，所以第三个调用失败





//MARK:连接多层可选链式调用

/* 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标 */
/* 多层可选链式调用不会增加返回值的可选层级 */


// - 如果你访问的值不是可选的，可选链式调用将会返回可选值。
// - 如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”

if let johnsStreet = joes.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}


let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
joes.residence?.address = johnsAddress

if let johnsStreet = joes.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}






//MARK:在方法的可选返回值上进行可选链式调用

/* 我们还可以在一个可选值上通过可选链式调用来调用方法，并且可以根据需要继续在方法的可选返回值上进行可选链式调用 */

if let buildingIdentifier = joes.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe = joes.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// 在方法的圆括号后面加上问号是因为你要在buildingIdentifier()方法的可选返回值上进行可选链式调用，而不是方法本身

