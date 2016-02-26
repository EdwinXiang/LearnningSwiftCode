//
//  main.swift
//  方法（Methods）
//
//  Created by Edwin on 16/2/25.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/************************方法（Methods）************************/
/**
实例方法(Instance Methods)
类型方法(Type Methods)

方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。
结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
*/

//1. 实例方法 (Instance Methods)
//实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。实例方法的语法与函数完全一致，详情参见函数。
//
//实例方法要写在它所属的类型的前后大括号之间。实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。实例方法只能被它所属的类的某个特定实例调用。实例方法不能脱离于现存的实例而被调用。
class Couter {
    var count = 0
    func increment() {
        ++count
    }
    
    func incrementBy(amout:Int){
        count += amout
    }
    
    func reset() {
        count = 0
    }
}

//Counter类定义了三个实例方法：
//
//increment让计数器按一递增；
//incrementBy(amount: Int)让计数器按一个指定的整数值递增；
//reset将计数器重置为0。
let counter = Couter()
counter.increment() //1
print(counter.count)
counter.incrementBy(5) //6
print(counter.count)
counter.reset()//0
print(counter.count)

//方法的局部参数名称和外部参数名称 (Local and External Parameter Names for Methods)
class Counter {
    var count:Int = 0
    func incrementBy(amount:Int,numberOfTimes:Int) {
        count += amount * numberOfTimes
    }
}
//incrementBy(_:numberOfTimes:)方法有两个参数： amount和numberOfTimes。默认情况下，Swift 只把amount当作一个局部名称，但是把numberOfTimes即看作局部名称又看作外部名称。下面调用这个方法：
let counters = Counter()
counters.incrementBy(5, numberOfTimes: 5)//25
print(counters.count)

//修改方法的外部参数名称(Modifying External Parameter Name Behavior for Methods)
//有时为方法的第一个参数提供一个外部参数名称是非常有用的，尽管这不是默认的行为。你自己可以为第一个参数添加一个显式的外部名称。
//相反，如果你不想为方法的第二个及后续的参数提供一个外部名称，可以通过使用下划线（_）作为该参数的显式外部名称，这样做将覆盖默认行为。


//self 属性(The self Property)

//类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。你可以在一个实例的实例方法中使用这个隐含的self属性来引用当前实例
class Couters {
    var count = 0
    func increment() {
        self.count++
    }
    
    func incrementBy(amout:Int){
        count += amout
    }
    
    func reset() {
        count = 0
    }
}

/*
实际上，你不必在你的代码里面经常写self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确地写self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的Counter中已经示范了：Counter中的三个实例方法中都使用的是count（而不是self.count）。

使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用self属性来区分参数名称和属性名称。
*/
struct Point {
    var x = 0.0,y = 0.0
    func isToTheRightOfX(x:Double) -> Bool {
        //self消除方法参数x和实例属性x之间的歧义：
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("this point is to the right of the line where x == 1.0")
}


//在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)

//结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
//但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
//要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
struct Points {
    var x = 0.0, y = 0.0
     mutating func moveByX(deltaX: Double, y deltaY: Double) {//mutating 修改值类型
        x += deltaX
        y += deltaY
    }
}
var somePoints = Points(x: 1.0, y: 1.0)
somePoints.moveByX(2.0, y: 3.0)
print("the point is now at \(somePoints.x),\(somePoints.y)")

//上面的Point结构体定义了一个可变方法 moveByX(_:y:) 来移动Point实例到给定的位置。该方法被调用时修改了这个点，而不是返回一个新的点。方法定义时加上了mutating关键字，从而允许修改属性。

//注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变，即使属性是变量属性
let fixedPoint = Points(x: 3.0, y: 3.0)
//fixedPoint.moveByX(2.0, y: 3.0)  //会报错

//在可变方法中给 self 赋值(Assigning to self Within a Mutating Method)
//可变方法能够赋给隐含属性self一个全新的实例。上面Point的例子可以用下面的方式改写：
struct Point1 {
    var x = 0.0,y = 0.0
    mutating func moveByX(deltaX:Double,deltaY:Double) {
        self = Point1(x: x + deltaX, y: y + deltaY)
    }
}
print("------------------------------------")
var newPoint = Point1(x: 1.0, y: 1.0)
newPoint.moveByX(2.0, deltaY: 3.0)
print("the point is now at \(newPoint.x),\(newPoint.y)")

//枚举的可变方法可以把self设置为同一枚举类型中不同的成员
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
//上面的例子中定义了一个三态开关的枚举。每次调用next()方法时，开关在不同的电源状态（Off，Low，High）之间循环切换。
var ovenLight = TriStateSwitch.Low
ovenLight.next() // == .high
ovenLight.next() // == .off


//2. 类型方法 (Type Methods)
//实例方法是被某个类型的实例调用的方法。你也可以定义在类型本身上调用的方法，这种方法就叫做类型方法（Type Methods）。在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
//🐷 在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含。
class SomeClass {
    static func someTypeMethod() {//类型方法
    
    }
}

SomeClass.someTypeMethod() //使用点语法调用类型方法
//在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。这意味着你可以用self来消除类型属性和类型方法参数之间的歧义（类似于我们在前面处理实例属性和实例方法参数时做的那样）。


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    var currentLevel = 1
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
/*
LevelTracker监测玩家已解锁的最高等级。这个值被存储在类型属性highestUnlockedLevel中。

LevelTracker还定义了两个类型方法与highestUnlockedLevel配合工作。第一个类型方法是unlockLevel，一旦新等级被解锁，它会更新highestUnlockedLevel的值。第二个类型方法是levelIsUnlocked，如果某个给定的等级已经被解锁，它将返回true。（注意，尽管我们没有使用类似LevelTracker.highestUnlockedLevel的写法，这个类型方法还是能够访问类型属性highestUnlockedLevel）

除了类型属性和类型方法，LevelTracker还监测每个玩家的进度。它用实例属性currentLevel来监测每个玩家当前的等级。

为了便于管理currentLevel属性，LevelTracker定义了实例方法advanceToLevel。这个方法会在更新currentLevel之前检查所请求的新等级是否已经解锁。advanceToLevel方法返回布尔值以指示是否能够设置currentLevel
*/
class Player {
    var tracker = LevelTracker()
    let playerName:String
    func completedLevel(level:Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name:String){
        playerName = name
    }
    
}

var player = Player(name: "xiaowei")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)") //2
//如果你创建了第二个玩家，并尝试让他开始一个没有被任何玩家解锁的等级，那么试图设置玩家当前等级将会失败
player = Player(name: "Beto")
 if player.tracker.advanceToLevel(3){
    print("player is now on level 6")
} else {
    print("level 6 has net yet been unlocked")
}