//
//  main.swift
//  扩展（Extensions）
//
//  Created by Edwin on 16/3/6.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation
/************************* 扩展（Extensions）***************************/
/**
扩展语法
计算型属性
构造器
方法
下标
嵌套类型
扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）

Swift 中的扩展可以：

添加计算型属性和计算型类型属性
定义实例方法和类型方法
提供新的构造器
定义下标
定义和使用新的嵌套类型
使一个已有类型符合某个协议
在 Swift 中，你甚至可以对协议进行扩展，提供协议要求的实现，或者添加额外的功能，从而可以让符合协议的类型拥有这些功能。你可以从协议扩展获取更多的细节。
*/
//注意🐷：扩展可以为一个类型添加新的功能，但是不能重写已有的功能。

/**
扩展语法（Extension Syntax）
使用关键字 extension 来声明扩展：
extension SomeType {
// 为 SomeType 添加的新功能写到这里
}

可以通过扩展来扩展一个已有类型，使其采纳一个或多个协议。在这种情况下，无论是类还是结构体，协议名字的书写方式完全一样：
extension SomeType: SomeProtocol, AnotherProctocol {
// 协议实现写到这里
}
*/


/**
计算型属性（Computed Properties）
扩展可以为已有类型添加计算型实例属性和计算型类型属性。下面的例子为 Swift 的内建 Double 类型添加了五个计算型实例属性，从而提供与距离单位协作的基本支持：
*/
extension Double {
    //这些属性是只读的计算型属性，为了更简洁，省略了 get 关键字。它们的返回值是 Double，而且可以用于所有接受 Double 值的数学计算中：
    var km:Double{return self * 1_000}
    var m: Double{return self}
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("one inch is \(oneInch) meters")
let threeFeet = 3.ft
print("three feet is \(threeFeet) meters")
let aMarathon = 42.km + 195.m
print("a marathon is \(aMarathon) meters long")
//扩展可以添加新的计算型属性，但是不可以添加存储型属性，也不可以为已有属性添加属性观察器。


//构造器（Initializers）
//扩展可以为已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项。
//扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供
struct Size {
    var width = 0.0,height = 0.0
}

struct Point {
    var x = 0.0,y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
//因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。详情请参阅默认构造器。这些构造器可以用于构造新的 Rect 实例：
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

//你可以提供一个额外的接受指定中心点和大小的构造器来扩展 Rect 结构体：
extension Rect {
    init(center:Point,size:Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))


//方法（Methods）
//扩展可以为已有类型添加新的实例方法和类型方法。下面的例子为 Int 类型添加了一个名为 repetitions 的实例方法：
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
print("----------------------------")
3.repetitions({
    print("hello word")
})

//可以使用尾随闭包让调用更加简洁：
2.repetitions{print("good bye")}


//可变实例方法（Mutating Instance Methods）
//通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating，正如来自原始实现的可变方法一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
 someInt.square()
print(someInt) // 9


//下标（Subscripts）
//扩展可以为已有类型添加新下标。这个例子为 Swift 内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第 n 个数字：
extension Int {
    subscript (var digitIndex:Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}
print(237923759387429[5])
//如果该 Int 值没有足够的位数，即下标越界，那么上述下标实现会返回 0，犹如在数字左边自动补 0：
print(2342342[9])


//嵌套类型（Nested Types）
//扩展可以为已有的类、结构体和枚举添加新的嵌套类型：
// MARK: - 该例子为 Int 添加了嵌套枚举。这个名为 Kind 的枚举表示特定整数的类型。具体来说，就是表示整数是正数、零或者负数。
//这个例子还为 Int 添加了一个计算型实例属性，即 kind，用来根据整数返回适当的 Kind 枚举成员。
extension Int {
    enum Kind {
        case Negative,Zero,Positive
    }
    var kind:Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers:[Int]) {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("-",terminator:" ")
        case .Zero:
            print("0",terminator:" ")
        case .Positive:
            print("+",terminator:" ")
        }
    }
    print("")
}
printIntegerKinds([3,56,34,-34,0,67,-54])
//函数 printIntegerKinds(_:) 接受一个 Int 数组，然后对该数组进行迭代。在每次迭代过程中，对当前整数的计算型属性 kind 的值进行评估，并打印出适当的描述。
//由于已知 number.kind 是 Int.Kind 类型，因此在 switch 语句中，Int.Kind 中的所有成员值都可以使用简写形式，例如使用 . Negative 而不是 Int.Kind.Negative。
