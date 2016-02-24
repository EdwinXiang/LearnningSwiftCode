//
//  main.swift
//  枚举（Enumerations）
//
//  Created by Edwin on 16/2/24.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/***************************** 枚举（Enumerations）*************************/
/**
枚举语法（Enumeration Syntax）
使用 Switch 语句匹配枚举值（Matching Enumeration Values with a Switch Statement）
关联值（Associated Values）
原始值（Raw Values）
递归枚举（Recursive Enumerations）
*/
//1.枚举语法
//使用enum关键词来创建枚举并且把它们的整个定义放在一对大括号内：

enum SomeEnumeration {
    // 枚举定义放在这里
}
enum CompassPoint {
    case north
    case south
    case east
    case west
}
//与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，North，South，East和West不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。

//多个成员值可以出现在同一行上，用逗号隔开：
enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var directionToHead = CompassPoint.west
//directionToHead的类型可以在它被CompassPoint的某个值初始化时推断出来。一旦directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值：
directionToHead = .north
//当directionToHead的类型已知时，再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时，这种写法让代码具有更好的可读性。
//2. 使用 Switch 语句匹配枚举值
//你可以使用switch语句匹配单个枚举值：
directionToHead = .east
switch directionToHead {
case .north:
    print("lots of planets have a north")
case .south:
    print("watch out for penguins")
case .east:
    print("where the sun rises")
case .west:
    print("where the skies are blue")
}

//当不需要匹配每个枚举成员的时候，你可以提供一个default分支来涵盖所有未明确处理的枚举成员
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//3. 关联值（Associated Values）
//在 Swift 中，使用如下方式定义表示两种商品条形码的枚举
enum barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(String)
}
//然后可以使用任意一种条形码类型创建新的条形码，
var productBarcode = barcode.UPCA(8, 8542, 32342, 32)
//同一个商品可以分配不同类型的条形码
productBarcode = barcode.QRCode("ASDHIASDANFKAS")

//这时，原始的Barcode.UPCA和其整数关联值被新的Barcode.QRCode和其字符串关联值所替代。Barcode类型的常量和变量可以存储一个.UPCA或者一个.QRCode（连同它们的关联值），但是在同一时间只能存储这两个值中的一个。

//像先前那样，可以使用一个 switch 语句来检查不同的条形码类型。然而，这一次，关联值可以被提取出来作为 switch 语句的一部分。你可以在switch的 case 分支代码中提取每个关联值作为一个常量（用let前缀）或者作为一个变量（用var前缀）来使用：
switch productBarcode {
    case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case .QRCode(let string):
    print("QR code:\(string)")
}

//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
productBarcode = barcode.UPCA(9, 23123, 12312, 5)
switch productBarcode {
case let .UPCA(numberSystem,manufacturer,product,check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(string):
    print("QR code:\(string)")
}

/********************* 原始值（Raw Values）*************************/
//在关联值小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
//1. 这是一个使用 ASCII 码作为原始值的枚举：
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}
//原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。

//2. 原始值的隐式赋值（Implicitly Assigned Raw Values）
//在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
//例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0。
enum Planets: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
//上面的例子中，Plant.Mercury的显式原始值为1，Planet.Venus的隐式原始值为2，依次类推。

//当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
//下面的例子是CompassPoint枚举的细化，使用字符串类型的原始值来表示各个方向的名称：
enum CompassPoints:String {
    case north,south,east,west
}

//使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
let earthOrder = Planets.Jupiter.rawValue
print("earthOrder = \(earthOrder)")
let sunsetDirection = CompassPoints.south.rawValue
print("sunsetDirection = \(sunsetDirection)")
let earthSun = Planets.Jupiter.hashValue
print(earthSun)

//使用原始值初始化枚举实例（Initializing from a Raw Value）
//如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，这个方法接收一个叫做rawValue的参数，参数类型即为原始值类型，返回值则是枚举成员或nil。你可以使用这个初始化方法来创建一个新的枚举实例。
let passiblePlanet = Planets(rawValue: 5)
print(passiblePlanet)

//如果你试图寻找一个位置为9的行星，通过原始值构造器返回的可选Planet值将是nil：

let positionToFind = 7
if let somePlanet = Planets(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

/**************递归枚举（Recursive Enumerations)************/
//递归枚举（recursive enumeration）是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。

//例如，下面的例子中，枚举类型存储了简单的算术表达式：
enum arithmeticExpression {
    case number(Int)
    indirect case addition(arithmeticExpression,arithmeticExpression)
    indirect case mutiplication(arithmeticExpression,arithmeticExpression)
}

//也可以在枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的
indirect enum arithmeticExpressions {
    case number(Int)
    case addition(arithmeticExpressions,arithmeticExpressions)
    case mutiplication(arithmeticExpressions,arithmeticExpressions)
}

func evaluate(expression:arithmeticExpressions) -> Int {
    switch expression{
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .mutiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

// 计算 (5 + 4) * 2
let five = arithmeticExpressions.number(5)
let four = arithmeticExpressions.number(4)
let sum = arithmeticExpressions.addition(five, four)
let product = arithmeticExpressions.mutiplication(five, four)
print(evaluate(product))
// 输出 "18"
//该函数如果遇到纯数字，就直接返回该数字的值。如果遇到的是加法或乘法运算，则分别计算左边表达式和右边表达式的值，然后相加或相乘。
