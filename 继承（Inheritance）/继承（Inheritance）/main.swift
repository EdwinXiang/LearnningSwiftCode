//
//  main.swift
//  继承（Inheritance）
//
//  Created by Edwin on 16/2/26.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/*******************继承（Inheritance）********************/
/**
定义一个基类（Base class）
子类生成（Subclassing）
重写（Overriding）
防止重写（Preventing Overrides）

一个类可以继承（inherit）另一个类的方法（methods），属性（properties）和其它特性。当一个类继承其它类时，继承类叫子类（subclass），被继承类叫超类（或父类，superclass）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。

在 Swift 中，类可以调用和访问超类的方法，属性和下标（subscripts），并且可以重写（override）这些方法，属性和下标来优化或修改它们的行为。Swift 会检查你的重写定义在超类中是否有匹配的定义，以此确保你的重写行为是正确的。

可以为类中继承来的属性添加属性观察器（property observers），这样一来，当属性值改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原本被定义为存储型属性（stored property）还是计算型属性（computed property）。
*/

//1、定义一个基类（base class）
class vehicle {
    var currentSpeed = 0.0
    var discription:String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("汽笛声")
    }
}
//创建一个类实例
let someVehicle = vehicle()
someVehicle.currentSpeed = 50
print("vehicle:\(someVehicle.discription)")
someVehicle.makeNoise()

//子类生成（Subclassing）
//子类生成（Subclassing）指的是在一个已有类的基础上创建一个新的类。子类继承超类的特性，并且可以进一步完善。你还可以为子类添加新的特性。
//
//为了指明某个类的超类，将超类名写在子类名的后面，用冒号分隔：
class Bicycle:vehicle {
    var hasBasket = false
}
//新的Bicycle类自动获得Vehicle类的所有特性，比如currentSpeed和description属性，还有它的makeNoise()方法。

let bicycle = Bicycle()
bicycle.currentSpeed = 15
bicycle.hasBasket = true
print("bicycle:\(bicycle.discription)")

//子类还可以继续被其它类继承，下面的示例为Bicycle创建了一个名为Tandem（双人自行车）的子类：

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentSpeed = 200
tandem.currentNumberOfPassengers = 5
print("tanden:\(tandem.discription)")

//重写（Overriding）
//子类可以为继承来的实例方法（instance method），类方法（class method），实例属性（instance property），或下标（subscript）提供自己定制的实现（implementation）。我们把这种行为叫重写（overriding）。
//
//如果要重写某个特性，你需要在重写定义的前面加上override关键字。这么做，你就表明了你是想提供一个重写版本，而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误，任何缺少override关键字的重写都会在编译时被诊断为错误。
//
//override关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确的。
/*
访问超类的方法，属性及下标

当你在子类中重写超类的方法，属性或下标时，有时在你的重写版本中使用已经存在的超类实现会大有裨益。比如，你可以完善已有实现的行为，或在一个继承来的变量中存储一个修改过的值。

在合适的地方，你可以通过使用super前缀来访问超类版本的方法，属性或下标：

在方法someMethod()的重写实现中，可以通过super.someMethod()来调用超类版本的someMethod()方法。
在属性someProperty的 getter 或 setter 的重写实现中，可以通过super.someProperty来访问超类版本的someProperty属性。
在下标的重写实现中，可以通过super[someIndex]来访问超类版本中的相同下标
*/

//重写方法
class Train:vehicle {
    override func makeNoise() {
        print("choo choo !!!!!!")
    }
}
let train = Train()
train.makeNoise()

//重写属性
//你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变。
//
//重写属性的 Getters 和 Setters
//
//你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。你在重写一个属性时，必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类型的属性相匹配的。
//
//你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性。
class Car:vehicle {
    var gear = 1
    override var discription:String { //重写属性
        return super.discription + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 130
car.gear = 3
print("car:\(car.discription)")

//重写属性观察器（Property Observer）
//你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被通知到，无论那个属性原本是如何实现的。
class AutomaticCar:Car {
    override var currentSpeed:Double  {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 150
print("automatic: \(automatic.discription)")

//防止重写
//你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。
//
//如果你重写了final方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final 的。
//
//你可以通过在关键字class前添加final修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。