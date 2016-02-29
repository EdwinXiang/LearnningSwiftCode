//
//  main.swift
//  构造过程（Initialization）
//
//  Created by Edwin on 16/2/27.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/*************************构造过程（Initialization）****************************/
/**
*存储属性的初始赋值
自定义构造过程
默认构造器
值类型的构造器代理
类的继承和构造过程
可失败构造器
必要构造器
通过闭包或函数设置属性的默认值
*/

//存储属性的初始赋值
//类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
//你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。以下小节将详细介绍这两种方法。
//注意
//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者（property observers）。
/*
构造器

构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字init命名：

init() {
// 在此处执行构造过程
}
*/
struct Fahrenheit {
    var temperature:Double
        init () {
            temperature = 32.0
        }
}
var f = Fahrenheit()
print("the default temperature is \(f.temperature)")
//默认属性值 你可以在构造器中为存储型属性设置初始值。同样，你也可以在属性声明时为其设置默认值。
struct fahrenheit {
    var temperature = 32.0
}

//自定义构造过程

//构造参数
//自定义构造过程时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方法的参数相同。
struct Celsius {
    var temperatureInCelsius:Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(FromKelvin kelvin:Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 213.0)
print(boilingPointOfWater)
let freezingPointWater = Celsius(FromKelvin: 273.15)
print(freezingPointWater)
//第一个构造器拥有一个构造参数，其外部名字为fromFahrenheit，内部名字为fahrenheit；第二个构造器也拥有一个构造参数，其外部名字为fromKelvin，内部名字为kelvin。这两个构造器都将唯一的参数值转换成摄氏温度值，并保存在属性temperatureInCelsius中。

//参数的内部名称和外部名称
/*
跟函数和方法参数相同，构造参数也拥有一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字。

然而，构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
*/
struct Color {
    let red,green,blue:Double
    init(red:Double,green:Double,blue:Double) {//构造方法
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white:Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color(red: 1.0, green: 0.5, blue: 0.8)
let halfGray = Color(white: 0.5)
//注意，如果不通过外部参数名字传值，你是没法调用这个构造器的。只要构造器定义了某个外部参数名，你就必须使用它，忽略它将导致编译错误：


//不带外部名的构造器参数
//如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名，以此重写上面所说的默认行为。
struct Celsiuses {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init (fromKelvin kelvin:Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init (_ celsius:Double) { //不带外部参数构造方法
        temperatureInCelsius = celsius
    }
}
let bodyTemperate = Celsiuses(37.0)


//可选属性类型
//如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为可选类型（optional type）。可选类型的属性将自动初始化为nil，表示这个属性是有意在初始化时设置为空的。
class SurveyQuestion {
    var text:String
    var response:String? //设置为可选属性
    init(text:String) {
        self.text = text
    }
    func ask(){
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "yes,I do like cheese"
/*调查问题的答案在回答前是无法确定的，因此我们将属性response声明为String?类型，或者说是可选字符串类型（optional String）。当SurveyQuestion实例化时，它将自动赋值为nil，表明此字符串暂时还没有值。*/


//构造过程中常量属性的修改
//你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
class SurveryQuestion {
    let text:String
    var response :String?
    init(text:String) {
        self.text = text
    }
    func ask(){
        print(text)
    }
}
let beetsQuestion = SurveryQuestion(text: "how about beets?")
beetsQuestion.ask()
beetsQuestion.response = "i also like beets"
let glassQuestion = SurveryQuestion(text: "dasdasd")
glassQuestion.ask()

//默认构造器
//如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
class shoppingListItem {
    var name:String?
    var quantity = 1
    var purchased = false
    func prints() {
        print("商品名称:\(name),质量:\(quantity)")
    }
}
var item = shoppingListItem()
item.prints()//name :nil
item.name = "香蕉"
item.quantity = 2
item.prints() // name:香蕉

//结构体的逐一成员构造器
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
struct Size {
    var width = 0.0,height = 0.0
    var size:Double?
    init(width:Double,height:Double) {
        self.width = width
        self.height = height
    }
    mutating func JiSuanSize(){
        self.size = self.width * self.height
        print(self.size!)
    }
        
}
var twoByTwo = Size(width: 2.0, height: 2.0)
twoByTwo.JiSuanSize()

//值类型的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
//对于值类型，你可以使用self.init在自定义的构造器中引用类型中的其它构造器。并且你只能在构造器内部调用self.init。
struct Sizes {
    var width = 0.0,height = 0.0
}
struct Point {
    var x = 0.0,y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Sizes()
    init(){}
    init(origin:Point,size:Sizes) {
        self.origin = origin
        self.size = size
    }
    init(center:Point,size:Sizes) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:Point(x: originX, y: originY),size:size)
    }
}
let basicRect = Rect() //使用默认值
print(basicRect)

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Sizes(width: 3.0, height: 3.0)) //构造器init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。这个构造器只是简单地将origin和size的参数值赋给对应的存储型属性：
print(originRect)

let centerRect = Rect(center: Point(x: 3.0, y: 3.0), size: Sizes(width: 5.0, height: 5.0)) //构造器init(center:size:)稍微复杂一点。它先通过center和size的值计算出origin的坐标，然后再调用（或者说代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中：
print(centerRect)


//类的继承和构造过程
//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
//Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
/**
*  指定构造器和便利构造器

指定构造器（designated initializers）是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。

每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。

便利构造器（convenience initializers）是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。

你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。
*/

/**
*  指定构造器和便利构造器的语法

类的指定构造器的写法跟值类型简单构造器一样：

init(parameters) {
statements
}
便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：

convenience init(parameters) {
statements
}
*/
/**
*  类的构造器代理规则

为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：

规则 1

指定构造器必须调用其直接父类的的指定构造器。

规则 2

便利构造器必须调用同一类中定义的其它构造器。

规则 3

便利构造器必须最终导致一个指定构造器被调用。

一个更方便记忆的方法是：

指定构造器必须总是向上代理
便利构造器必须总是横向代理
*/
//两段式构造过程
//
//Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
//
//两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。

//构造器的继承和重写 override

//跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误地用来创建子类的实例。
//
//注意
//父类的构造器仅会在安全和适当的情况下被继承。当你重写一个父类的指定构造器时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器
class Vehicle {
    var numberOfWheels = 0
    var description:String {
        return "\(numberOfWheels) wheels"
    }
}
//Vehicle类只为存储型属性提供默认值，而不自定义构造器。因此，它会自动获得一个默认构造器
let vehicle = Vehicle()
print("vehicle:\(vehicle.description)")

class Bicycle:Vehicle {
    override init() { //重新父类的指定构造器
        super.init() //调用父类的init方法
        /**
        *  这个方法的作用是调用Bicycle的父类Vehicle的默认构造器。这样可以确保Bicycle在修改属性之前，它所继承的属性numberOfWheels能被Vehicle类初始化。在调用super.init()之后，属性numberOfWheels的原值被新值2替换。
        */
        numberOfWheels = 273
    }
}
let bicycle = Bicycle()
print("bicycle:\(bicycle.description)") //子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。


/*
构造器的自动继承

如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。

假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：

规则 1

如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。

规则 2

如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器
*/

//指定构造器和便利构造器实战
class Food {
    var name:String
    init(name:String) { //指定构造器
        self.name = name
    }
    convenience init(){ //便利构造器
        self.init(name:"[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
print(namedMeat)
//Food类同样提供了一个没有参数的便利构造器init()。这个init()构造器为新食物提供了一个默认的占位名字，通过横向代理到指定构造器init(name: String)并给参数name传值[Unnamed]来实现：
let mysteryMeat = Food()
print(mysteryMeat)

class RecipeIngredient:Food {
    var quantity:Int
    init(name: String, quantity:Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name:name,quantity:1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem:RecipeIngredient {
    var purchased = false
    var description:String {
        var output = "\(quantity) x \(name)"
        output += purchased ?  " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x orange juice ✔
// 1 x bacon ✘
// 6 x eggs ✘


//可失败构造器
//如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
//
//为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
struct Animal {
    let species:String
    init?(species:String) {
        if species.isEmpty{return nil}
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")//// someCreature 的类型是 Animal? 而不是 Animal
if let giraffe = someCreature {
    print("an animal was initialized with a species of \(giraffe.species)")
}
//如果你给该可失败构造器传入一个空字符串作为其参数，则会导致构造失败
let anonyousCreature = Animal(species: "")
if anonyousCreature == nil {
    print("The anonymous creature could not be initialized")
}

/*
枚举类型的可失败构造器

你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
*/
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
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("this is a defined temperature unit, so initialization succeeded")
}
let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

/*
带原始值的枚举类型的可失败构造器

带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)，该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。
*/
enum TemperatureUnits: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnits = TemperatureUnits(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit = TemperatureUnits(rawValue: "X")
if unknowUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

/*
类的可失败构造器

值类型（也就是结构体或枚举）的可失败构造器，可以在构造过程中的任意时间点触发构造失败。比如在前面的例子中，结构体Animal的可失败构造器在构造过程一开始就触发了构造失败，甚至在species属性被初始化前。

而对类而言，可失败构造器只能在类引入的所有存储型属性被初始化后，以及构造器代理调用完成后，才能触发构造失败。
*/
class Product {
    let name:String
    init?(name:String) {
        self.name = name
        if name.isEmpty{
            return nil
        }
    }
}
if let bowTie = Product(name: "bow tie") {
    print("the product's name is \(bowTie.name)")
}
/*
构造失败的传递

类，结构体，枚举的可失败构造器可以横向代理到类型中的其他可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。

无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
*/
class CarItem: Product {
    let quantity:Int!
    init?(name: String,quantity:Int) {
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 {
            return nil
        }
    }
}
if let twoSocks = CarItem(name: "sock", quantity: 2) {
    print("item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
if let zeroShift = CarItem(name: "zero", quantity: 0) { //返回nil 构造失败
    print("")
}else {
    print("unable to initialize zero shft")
}

/*
重写一个可失败构造器

如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。

注意，当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
*/
class Document {
    var name:String?
    init() {} //构造方法
        init ? (name:String) { //可失败构造器
            self.name = name
            if name.isEmpty {
                return nil
            }
        }
}

//重写父类的可失败构造器
class AutomaticallyNamedDocument:Document {
    override init(){
        super.init()
        self.name = "[Untitled]"
    }
    override init?(name: String) {
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
        super.init(name: "[Untitled]")! //强制解包
    }
}
/*
可失败构造器 init!

通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（(init!)），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。

你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。


必要构造器
在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
*/
class SomeClass {
    required init() {
        
    }
}
/// 在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加override修饰符：
class someSubClass: SomeClass {
    required init() {
        //
    }
}

//通过闭包或函数设置属性的默认值
//如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
//
//这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。
/*
class SomeClass {
let someProperty: SomeType = {
// 在这个闭包中给 someProperty 创建一个默认值
// someValue 必须和 SomeType 类型相同
return someValue
}()
}
注意闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
*/
struct Checkerboard {
    let boardColors:[Bool] = {
        var remporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                remporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return remporaryBoard
    }()
    func squareIsBlackAtRow(row:Int,column:Int) ->Bool {
        return boardColors[(row * 10) + column]
    }
}
let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))//ture
print(board.squareIsBlackAtRow(9, column: 9))//
print(board.squareIsBlackAtRow(1, column: 1))
print(board.squareIsBlackAtRow(0, column: 2))//false
print(board.squareIsBlackAtRow(0, column: 3))//true