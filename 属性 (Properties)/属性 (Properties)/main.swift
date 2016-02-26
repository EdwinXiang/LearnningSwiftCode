//
//  main.swift
//  属性 (Properties)
//
//  Created by Edwin on 16/2/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/***************** 属性(Properties) **********************/
/**
存储属性（Stored Properties）
计算属性（Computed Properties）
属性观察器（Property Observers）
全局变量和局部变量（Global and Local Variables）
类型属性（Type Properties）

属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算（不是存储）一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属性。
另外，还可以定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上。
*/

//1. 存储属性
//简单来说，一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量。存储属性可以是变量存储属性（用关键字var定义），也可以是常量存储属性（用关键字let定义）。
struct FixedLenghtRange {
    var firstValue:Int
    let lenght:Int
}
//length在创建实例的时候被初始化，因为它是一个常量存储属性，所以之后无法修改它的值
var rangeOfThreeItems = FixedLenghtRange(firstValue: 0, lenght: 3) //0,1,2
print(rangeOfThreeItems.firstValue) //0

rangeOfThreeItems.firstValue = 6 //6,7,8

let rangeOfFourItems = FixedLenghtRange(firstValue: 0, lenght: 4) //0,1,2,3
//因为rangeOfFourItems被声明成了常量（用let关键字），即使firstValue是一个变量属性，也无法再修改它了。
//这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
//属于引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
//rangeOfFourItems.firstValue = 3 //

//2. 延迟存储属性

//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用lazy来标示一个延迟存储属性。
//🐷 必须将延迟存储属性声明成变量（使用var关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
//延迟属性很有用，当属性的值依赖于在实例的构造过程结束后才会知道具体值的外部因素时，或者当获得属性的初始值需要复杂或大量计算时，可以只在需要的时候计算它。

class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //这里提供数据管理功能
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
/**
DataManager的一个功能是从文件导入数据。该功能由DataImporter类提供，DataImporter完成初始化需要消耗不少时间：因为它的实例在初始化时可能要打开文件，还要读取文件内容到内存。

DataManager管理数据时也可能不从文件中导入数据。所以当DataManager的实例被创建时，没必要创建一个DataImporter的实例，更明智的做法是第一次用到DataImporter的时候才去创建它。
*/
//由于使用了lazy，importer属性只有在第一次被访问的时候才被创建。比如访问它的属性fileName时：
print(manager.importer.fileName) //属性现在被创建
//🐷 如果一个被标记为lazy的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。


//3. 存储属性和实例变量
/**
*  计算属性
除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
*/
struct Point {
    var x = 0.0,y = 0.0
}

struct Size {
    var width = 0.0,height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center //get 方法
print(initialSquareCenter)

square.center = Point(x: 15.0, y: 15.0) //rect 的set方法
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
/*
这个例子定义了 3 个结构体来描述几何形状：

Point封装了一个(x, y)的坐标
Size封装了一个width和一个height
Rect表示一个有原点和尺寸的矩形
Rect也提供了一个名为center的计算属性。一个矩形的中心点可以从原点（origin）和尺寸（size）算出，所以不需要将它以显式声明的Point来保存。Rect的计算属性center提供了自定义的 getter 和 setter 来获取和设置矩形的中心点，就像它有一个存储属性一样
*/

//便捷 setter 声明

//如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称newValue。下面是使用了便捷 setter 声明的Rect结构体代码：
struct alternativeRect {
    var origin = Point()
    var size = Size()
    var center:Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set { //set(newCenter)
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
//必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let关键字只用来声明常量属性，表示初始化后再也无法修改的值。
struct Cuboid {
    var width = 0.0,height = 0.0,depth = 0.0
    var volume:Double {
        get {
            return width * height * depth
        }
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 12.0, depth: 5.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
/*
这个例子定义了一个名为Cuboid的结构体，表示三维空间的立方体，包含width、height和depth属性。结构体还有一个名为volume的只读计算属性用来返回立方体的体积。为volume提供 setter 毫无意义，因为无法确定如何修改width、height和depth三者的值来匹配新的volume。然而，Cuboid提供一个只读计算属性来让外部用户直接获取体积是很有用的。
*/


//属性观察器
//属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，甚至新值和当前值相同的时候也不例外。
//可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。
//不需要为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化
/*
可以为属性添加如下的一个或全部观察器：
willSet在新的值被设置之前调用
didSet在新的值被设置之后立即调用
willSet观察器会将新的属性值作为常量参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称newValue表示。
类似地，didSet观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue。
*/

//这里是一个willSet和didSet的实际例子，其中定义了一个名为StepCounter的类，用来统计一个人步行时的总步数。这个类可以跟计步器或其他日常锻炼的统计装置的输入数据配合使用。
class StepCounter {
    var totalSteps:Int = 0 {
        willSet(newTotalSteps) {
            print("about to set totalSteps to \(newTotalSteps)")
        }
        didSet {  //如果在一个属性的didSet观察器里为它赋值，这个值会替换之前设置的值。
//            totalSteps = 500
            if totalSteps > oldValue {
                print("added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepcounter = StepCounter()
stepcounter.totalSteps = 200
//about to set totalSteps to 200
//added 200 steps
stepcounter.totalSteps = 530
//about to set totalSteps to 530
//added 330 steps
stepcounter.totalSteps = 989
//about to set totalSteps to 989
//added 459 steps
//StepCounter类定义了一个Int类型的属性totalSteps，它是一个存储属性，包含willSet和didSet观察器。
//当totalSteps被设置新值的时候，它的willSet和didSet观察器都会被调用，甚至新值和当前值完全相同时也会被调用。

//全局变量和局部变量
//计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
/**
另外，在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样，返回一个计算结果而不是存储值，声明格式也完全一样。
注意
全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记lazy修饰符。
局部范围的常量或变量从不延迟计算。
*/

//类型属性
//实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互独立。
//也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性。
/*
类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量（就像 C 语言中的静态常量），或者所有实例都能访问的一个变量（就像 C 语言中的静态变量）。
存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
🐷：
跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用lazy修饰符。
*/

//类型属性语法
//使用关键字static来定义类型属性。在为类定义计算型类型属性时，可以改用关键字class来支持子类对父类的实现进行重写。
struct SomeStructure {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty:Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty:Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "some value"
    static var computedTypeProperty:Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//例子中的计算型类型属性是只读的，但也可以定义可读可写的计算型类型属性，跟计算型实例属性的语法相同。

//获取和设置类型属性的值
//跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例。比如：
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "another value"
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)

//两个声道来模拟立体声的音量
struct audioChannel {
    static let thresholdLevel = 10 //音量的最大上限阈值
    static var maxInputLevelForAllChannels = 0 //变量存储属性 表示最大音量
    var currentLevel:Int = 0{ //当前音量限制的音量 0-10
        didSet {//添加属性观察器
            /**
            *  属性currentLevel包含didSet属性观察器来检查每次设置后的属性值，它做如下两个检查：
            如果currentLevel的新值大于允许的阈值thresholdLevel，属性观察器将currentLevel的值限定为阈值thresholdLevel。
            如果修正后的currentLevel值大于静态类型属性maxInputLevelForAllChannels的值，属性观察器就将新值保存在maxInputLevelForAllChannels中。
            */
            if currentLevel > audioChannel.thresholdLevel {
                //将当前音量限制在阈值之内
                currentLevel = audioChannel.thresholdLevel
            }
            if currentLevel > audioChannel.maxInputLevelForAllChannels {
                //存储当前音量作为新的最大输入音量
                audioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

//可以使用结构体AudioChannel创建两个声道leftChannel和rightChannel，用以表示立体声系统的音量：
print("--------------------获取和设置类型属性的值-----------------------")
var leftChannel = audioChannel()
var rightChannel = audioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(rightChannel.currentLevel)
print(audioChannel.maxInputLevelForAllChannels)
print("------------修改最大属性值-----------------")
//如果试图将右声道的currentLevel设置成11，它会被修正到最大值10，同时maxInputLevelForAllChannels的值也会更新到10：
rightChannel.currentLevel = 15
print(leftChannel.currentLevel)
print(rightChannel.currentLevel)
print(audioChannel.maxInputLevelForAllChannels)
