//
//  main.swift
//  自动引用计数（Automatic Reference Counting）
//
//  Created by Edwin on 16/2/29.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/****************** 自动引用计数（Automatic Reference Counting）***************/
/**
自动引用计数的工作机制
自动引用计数实践
类实例之间的循环强引用
解决实例之间的循环强引用
闭包引起的循环强引用
解决闭包引起的循环强引用
Swift 使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存。通常情况下，Swift 内存管理机制会一直起作用，你无须自己来考虑内存的管理。ARC 会在类的实例不再被使用时，自动释放其占用的内存。
*/
//自动引用计数的工作机制
/*
当你每次创建一个类的新的实例的时候，ARC 会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储型属性的值。

此外，当实例不再被使用时，ARC 释放实例所占用的内存，并让释放的内存能挪作他用。这确保了不再被使用的实例，不会一直占用内存空间。

然而，当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用。实际上，如果你试图访问这个实例，你的应用程序很可能会崩溃。

为了确保使用中的实例不会被销毁，ARC 会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。

为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。
*/

//自动引用计数
/// Person类有一个构造函数，此构造函数为实例的name属性赋值，并打印一条消息以表明初始化过程生效。Person类也拥有一个析构函数，这个析构函数会在实例被销毁时打印一条消息。
class Person {
    let name:String
    init(name:String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

//定义三个person类型的可选变量  他们的值会自动化初始化为nil
var referance1:Person?
var referance2:Person?
var referance3:Person?

referance1 = Person(name: "John appleseed")//构造函数被执行
//由于Person类的新实例被赋值给了reference1变量，所以reference1到Person类的新实例之间建立了一个强引用。正是因为这一个强引用，ARC 会保证Person实例被保持在内存中不被销毁。

referance2 = referance1 //强引用
referance3  = referance1 //强引用
/**
现在这一个Person实例已经有三个强引用了。

如果你通过给其中两个变量赋值nil的方式断开两个强引用（包括最先的那个强引用），只留下一个强引用，Person实例不会被销毁：
*/
referance1 = nil
referance2 = nil
//第三个也被赋值为nil，表明最后一个强引用被断开，ARC会自动销毁
referance3 = nil //打印析构方法的print

print("---------------------------------------循环强引用----------------------------------------------")
//类实例之间的循环强引用
/*然而，我们可能会写出一个类实例的强引用数永远不能变成0的代码。如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题*/

//产生循环强引用的例子
class PersonOne {
    let name:String
    init(name:String) {
        self.name = name
    }
    var apartment:Apartment?
    deinit{
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: PersonOne?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

//循环强引用产生
var John:PersonOne?
var unit4A:Apartment?
John = PersonOne(name: "John")
unit4A = Apartment(unit: "4A")
//在两个实例被创建和赋值后，下图表现了强引用的关系。变量john现在有一个指向Person实例的强引用，而变量unit4A有一个指向Apartment实例的强引用：
//现在你能够将这两个实例关联在一起，这样人就能有公寓住了，而公寓也有了房客。注意感叹号是用来展开和访问可选变量john和unit4A中的实例，这样实例的属性才能被赋值：
John!.apartment = unit4A
unit4A!.tenant = John
//不幸的是，这两个实例关联后会产生一个循环强引用。Person实例现在有了一个指向Apartment实例的强引用，而Apartment实例也有了一个指向Person实例的强引用。因此，当你断开john和unit4A变量所持有的强引用时，引用计数并不会降为0，实例也不会被 ARC 销毁：
John = nil
unit4A = nil
//注意，当你把这两个变量设为nil时，没有任何一个析构函数被调用。循环强引用会一直阻止Person和Apartment类实例的销毁，这就在你的应用程序中造成了内存泄漏。

print("----------弱引用和无主引用----------------")
//解决实例之间的循环强引用  弱引用和无主引用
/*
Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
对于生命周期中会变为nil的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。

弱引用  弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。

弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型。在 Swift 中，推荐使用可选类型描述可能没有值的类型

在实例的生命周期中，如果某些时候引用没有值，那么弱引用可以避免循环强引用。如果引用总是有值，则可以使用无主引用，在无主引用中有描述。在上面Apartment的例子中，一个公寓的生命周期中，有时是没有“居民”的，因此适合使用弱引用来解决循环强引用。
*/

class PersonTwo {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentTwo?
    deinit { print("\(name) is being deinitialized") }
}
class ApartmentTwo {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonTwo? //
    deinit { print("Apartment \(unit) is being deinitialized") }
}
var john1: PersonTwo?
var unit4A1: ApartmentTwo?

john1 = PersonTwo(name: "John Appleseed")
unit4A1 = ApartmentTwo(unit: "4A")

john1!.apartment = unit4A1
unit4A1!.tenant = john1
john1 = nil
unit4A1 = nil

//无主引用

//和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
//
//由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
class Customer {
    let name:String
    var card:CreditCard?
    init(name:String) {
        self.name = name
    }
    deinit{
        print("\(name) is being deinitialized")
    }
}
//CreditCard类的number属性被定义为UInt64类型而不是Int类型，以确保number属性的存储量在 32 位和 64 位系统上都能足够容纳 16 位的卡号。
class CreditCard {
    let number:UInt64
    unowned let customer:Customer //无主引用
    init(number:UInt64,customer:Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("card # \(number) is being deinitialized")
    }
}
var Edwin:Customer?
Edwin = Customer(name: "Edwin")
Edwin!.card = CreditCard(number: 1234_5678_3456, customer: Edwin!)
Edwin = nil
//最后的代码展示了在john变量被设为nil后Customer实例和CreditCard实例的构造函数都打印出了“销毁”的信息。


//无主引用以及隐式解析可选属性
/*Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。

Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。

然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
*/
class Country {
    let name:String
    var capitalCity:City! //将capitalCity申明为隐式解析可选类型
    init(name:String,capitalName:String) {
        self.name = name
        self.capitalCity = City(name:capitalName,country:self)
    }
}
class City {
    let name:String
    unowned let country:Country //无主类型
    init(name:String,country:Country){
        self.name = name
        self.country = country
    }
}
var country = Country(name: "Canada", capitalName: "ottawa")
print("\(country.name)'s capital is called \(country.capitalCity.name)")
//使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用。


//闭包引起的循环强引用
/*循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod()。这两种情况都导致了闭包“捕获”self，从而产生了循环强引用。

循环强引用的产生，是因为闭包和类相似，都是引用类型。当你把一个闭包赋值给某个属性时，你是将这个闭包的引用赋值给了属性。实质上，这跟之前的问题是一样的——两个强引用让彼此一直有效。但是，和两个类实例不同，这次一个是类实例，另一个是闭包。

Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closure capture list）。同样的，在学习如何用闭包捕获列表打破循环强引用之前，先来了解一下这里的循环强引用是如何产生的，这对我们很有帮助。
*/
class HTMLElement {
    let name:String
    let text:String?
    
    lazy var asHTML:Void -> String = {
        [unowned self] in //解决闭包引起的循环强引用 一个捕获列表。这里，捕获列表是[unowned self]，表示“将self捕获为无主引用而不是强引用”。
        if let text = self.text {
            return"<\(self.name)>\(text)</\(self.name)>"
        } else {
            return"<\(self.name)/>"
        }
    }
    
    init(name:String,text:String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
let heading = HTMLElement(name: "H1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
//asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
var pareagraph:HTMLElement? = HTMLElement(name: "p", text: "hello,world")
print(pareagraph?.asHTML())
//如果设置paragraph变量为nil，打破它持有的HTMLElement实例的强引用，HTMLElement实例和它的闭包都不会被销毁，也是因为循环强引用：
pareagraph = nil

//解决闭包引起的循环强引用
//在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
