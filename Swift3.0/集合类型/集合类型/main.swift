//
//  main.swift
//  集合类型
//
//  Created by 沿途の风景 on 17/8/13.
//  Copyright © 2017年 yanghailong. All rights reserved.
//

import Foundation

//print("Hello, World!")


//MARK:数组(Arrays)
//是有序数据的集。使用有序列表存储同一类型的多个值，相同的值可以多次出现在一个数组的不同位置。

//创建一个空数组
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)
print(someInts)

someInts = []//现在是空数组，但是仍然是[Int]类型的。
print(someInts)


//创建一个带有默认值的数组
var threeDoubles = Array(repeatElement(0.0, count: 3))//被推断为Double，等价于[0.0, 0.0, 0.0]
//同threeDoubles = Array(repeating: 0.0, count: 3)
//同threeDoubles = Array.init(repeating: 0.0, count: 3)
print(threeDoubles)


//通过两个数组相加创建一个数组
var anotherThreeDoubles = Array.init(repeating: 2.5, count: 3)
print(anotherThreeDoubles)

var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)


//用数组字面量构造数组
var shoppingList: [String] = ["Eggs", "Milk"]
//同shoppingList = ["Eggs", "Milk"]，Swift可以推断出[Sting]
print(shoppingList)



//访问和修改数组
print("The shopping list contains \(shoppingList.count) items.")

if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

//拼接
shoppingList.append("Flour")
print(shoppingList)

shoppingList += ["Backing Powder"]
print(shoppingList)

shoppingList += ["Chocolate Spread", "Chesse", "Butter"]
print(shoppingList)

//下标索引取值
var firstItem = shoppingList[0]
print(firstItem)


//使用下标改变某个已有索引值对应的数据值
shoppingList[0] = "Six eggs"
print(shoppingList.first!)


shoppingList[4...6] = ["Bananas", "Apples"]
print(shoppingList)


//插入
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)


//删除
let mapleSyrup = shoppingList.remove(at: 0)
print(mapleSyrup)
//shoppingList.remove(at: 10) //索引越界，运行时会报错

//shoppingList.removeAll()//删除全部元素

//shoppingList.removeFirst()//删除第一个元素

let apples = shoppingList.removeLast()//删除最后一个元素
print(apples)
print(shoppingList)



//数组的遍历
for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}



//MARK:集合
//--------------------------集合(Sets)--------------------------
//无序无重复数据的集。用来存储相同类型并且没有确定顺序的值。
//-------------------------------------------------------------


//创建和构造一个空的集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")
print(letters)

letters = []//现在是一个空的Set，但是它依然是Set<Character>类型
print(letters)


//用数组字面量创建集合
var favoriteGenres:Set<String> = ["Rock", "Classical", "Hip hop"]
//同favoriteGenres:Set = ["Rock", "Classical", "Hip hop"]//Swift可以推断出是Set<String>类型
print(favoriteGenres)



//访问和修改一个集合
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}


favoriteGenres.insert("Jazz")
print(favoriteGenres)


if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
print("")



//遍历一个集合
for genre in favoriteGenres {
    print(genre)
}
print("")

for genre in favoriteGenres.sorted() {
    print(genre)
}
print("")



//基本集合操作
/*
使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
使用union(_:)方法根据两个集合的值创建一个新的集合。
使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。
*/

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

let unionDigis = oddDigits.union(evenDigits).sorted()
print(unionDigis)//[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

var intersectionDigits = oddDigits.intersection(evenDigits).sorted()
print(intersectionDigits)//[]

intersectionDigits = oddDigits.intersection(singleDigitPrimeNumbers).sorted()
print(intersectionDigits)//[3, 5, 7]

let subtractingDigits = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
print(subtractingDigits)//[1, 9]

let symmetricDifferenceDigits = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
print(symmetricDifferenceDigits)//[1, 2, 9]




//集合成员关系和相等
/*
使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)
*/

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

let isSubset = houseAnimals.isSubset(of: farmAnimals)
print(isSubset) // true
let isSuperset = farmAnimals.isSuperset(of: houseAnimals)
print(isSuperset) // true
let isDisjoint = farmAnimals.isDisjoint(with: cityAnimals)
print(isDisjoint) // true
let isStrictSubset = houseAnimals.isStrictSubset(of: farmAnimals)
print(isStrictSubset) // true
let isStrictSuperset = farmAnimals.isStrictSuperset(of: houseAnimals)
print(isStrictSuperset) // true




//MARK:字典
//--------------------------字典(Dictionaries)--------------------------
/*
无序的键值对的集。
字典是一种存储多个相同类型的值的容器。
每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。
和数组中的数据项不同，字典中的数据项并没有具体顺序。
我们在需要通过标识符（键）访问数据的时候使用字典，这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样。
*/
//----------------------------------------------------------------------

//创建一个空字典
var namesOfIntegers = [Int: String]()
print(namesOfIntegers)//是一个空的[Int: Sting]字典

namesOfIntegers[16] = "sixteen"
print(namesOfIntegers)

namesOfIntegers = [:]//成为了一个 [Int: String] 类型的空字典
print(namesOfIntegers)



var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//同airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print(airports)


//访问和修改字典
print("The dictionary of airports contains \(airports.count) items.")

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

airports["LHR"] = "London"
print(airports)

airports["LHR"] = "London Heathrow"
print(airports)

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let airportName = airports["DUB"] {
    print("The name of airport is \(airportName).")
} else {
    print("The airport is not in the airports dictionary.")
}

airports["APL"] = "Apple Internation"
print(airports)
airports["APL"] = nil
print(airports)

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is (removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// prints "The removed airport's name is Dublin Airport.



//字典遍历
for (airportCode, airportName) in airports {
    print("\(airportCode):\(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
print(airportCodes)

let airportNames = [String](airports.values)
print(airportNames)



