//
//  main.swift
//  闭包(Closures)
//
//  Created by Edwin on 16/2/24.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/****************************闭包(Closures)************************/
/*
闭包表达式（Closure Expressions）
尾随闭包（Trailing Closures）
值捕获（Capturing Values）
闭包是引用类型（Closures Are Reference Types）
非逃逸闭包(Nonescaping Closures)
自动闭包（Autoclosures）
*/
//闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似。
//闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着这些常量和变量，俗称闭包。

//1. 闭包表达式
/*
闭包表达式（Closure Expressions）
嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式。当然，有时候撰写小巧的没有完整定义和命名的类函数结构也是很有用处的，尤其是在您处理一些函数并需要将另外一些函数作为该函数的参数时。

闭包表达式是一种利用简洁语法构建内联闭包的方式。闭包表达式提供了一些语法优化，使得撰写闭包变得简单明了。下面闭包表达式的例子通过使用几次迭代展示了sort(_:)方法定义和语法优化的方式。每一次迭代都用更简洁的方式描述了相同的功能。
*/
//1.1 sort 方法（The Sort Method）
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1 s1:String,s2:String) -> Bool {
    return s1 < s2
}
var reversed = names.sort(backwards)
print(reversed)
//1.2 闭包表达式语法（Closure Expression Syntax）
/**
闭包表达式语法有如下一般形式：
{ (parameters) -> returnType in
statements
}
*/
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})
//需要注意的是内联闭包参数和返回值类型声明与backwards(_:_:)函数类型声明相同。在这两种方式中，都写成了(s1: String, s2: String) -> Bool。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。
//闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
reversed = names.sort( { (s1:String,s2:String) -> Bool in return s1 > s2})
print("----------result:\(reversed)")
//1.3 根据上下文推断类型（Inferring Type From Context）
//因为排序闭包函数是作为sort(_:)方法的参数传入的，Swift 可以推断其参数和返回值的类型。sort(_:)方法被一个字符串数组调用，因此其参数必须是(String, String) -> Bool类型的函数。这意味着(String, String)和Bool类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
reversed = names.sort({s1,s2 in return s1 > s2})

//1.4 单表达式闭包隐式返回（Implicit Return From Single-Expression Clossures）
//单行表达式闭包可以通过省略return关键字来隐式返回单行表达式的结果
reversed = names.sort({s1,s2 in s1 < s2})

//1.5 参数名称缩写（Shorthand Argument Names）
//Swift 自动为内联闭包提供了参数名称缩写功能，您可以直接通过$0，$1，$2来顺序调用闭包的参数，以此类推。
//如果您在闭包表达式中使用参数名称缩写，您可以在闭包参数列表中省略对其的定义，并且对应参数名称缩写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全由闭包函数体构成：
reversed = names.sort({$0 > $1})
print("later \(reversed)")
//1.6 运算符函数（Operator Functions）
//实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。Swift 的String类型定义了关于大于号（>）的字符串实现，其作为一个函数接受两个String类型的参数并返回Bool类型的值。而这正好与sort(_:)方法的第二个参数需要的函数类型相符合。因此，您可以简单地传递一个大于号，Swift 可以自动推断出您想使用大于号的字符串函数实现：
reversed = names.sort(>)

/*****************2.尾随闭包*******************/
/*
尾随闭包（Trailing Closures）
如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
*/
func someFunctionThatTakesAclosure(closure:() -> Void) {
    
}
// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAclosure({
    
})
//// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAclosure(){
    
}
reversed = names.sort(){
    $0 > $1
}
//如果函数只需要闭包表达式一个参数，当您使用尾随闭包时，您甚至可以把()省略掉
reversed = names.sort {
    $0 > $1
}

let digitNames = [0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
let numbers = [16,58,510]
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0{
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}
print(strings)

/******************************捕获值***********************************/
/**
捕获值（Capturing Values）
闭包可以在其被定义的上下文中捕获常量或变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
*/

func makeIncrementor(forIncrement amount:Int) -> () ->Int {
    var runningTotal = 0
    func incrementor() ->Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}
//makeIncrementor返回类型为() -> Int。这意味着其返回的是一个函数，而不是一个简单类型的值。该函数在每次调用时不接受参数，只返回一个Int类型的值。
let incrementByTen = makeIncrementor(forIncrement: 10)
print(incrementByTen())//10
print(incrementByTen())//20
print(incrementByTen())//30
let incrementBySeven = makeIncrementor(forIncrement: 7)
print(incrementBySeven())//7
print(incrementByTen())//40
//2.闭包是引用类型（Closures Are Reference Types）
//上面的例子中，incrementBySeven和incrementByTen是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
//无论您将函数或闭包赋值给一个常量还是变量，您实际上都是将常量或变量的值设置为对应函数或闭包的引用。上面的例子中，指向闭包的引用incrementByTen是一个常量，而并非闭包内容本身。
//这也意味着如果您将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包：
let alsoIncrementByTen = incrementByTen
print(alsoIncrementByTen())//50

//3. 非逃逸闭包(Nonescaping Closures)
//当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注@noescape，用来指明这个闭包是不允许“逃逸”出这个函数的。将闭包标注@noescape能使编译器知道这个闭包的生命周期（译者注：闭包只能在函数体中被执行，不能脱离函数体执行，所以编译器明确知道运行时的上下文），从而可以进行一些比较激进的优化
func someFunctionWithNoescapeClosure(@noescape closure:() ->Void) {
    closure()
}
//一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。eg:
var completionHandlers:[() -> Void] = []
func someFunctionWithNoescapingClosure(completionHander:() -> Void) {
    completionHandlers.append(completionHander)
}
//someFunctionWithEscapingClosure(_:)函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你试图将这个参数标注为@noescape，你将会获得一个编译错误。
//
//将闭包标注为@noescape使你能在闭包中隐式地引用self。
class someClass {
    var x = 10
    func doSomething() {
        someFunctionWithNoescapingClosure { self.x = 100 }
        someFunctionWithNoescapeClosure { x = 200 }
    }
}

let instance = someClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

/*************************** autoclosures 自动闭包 ***********************************/
/*
自动闭包（Autoclosures）
自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够用一个普通的表达式来代替显式的闭包，从而省略闭包的花括号。
*/
var customersInline = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInline.count)

let customerProvider = {customersInline.removeAtIndex(0)}
print(customersInline.count)
print("now serving \(customerProvider())!")
print(customersInline.count)

//尽管在闭包的代码中，customersInLine的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。请注意，customerProvider的类型不是String，而是() -> String，一个没有参数且返回值为String的函数。

//将闭包作为参数传递给函数时，你能获得同样的延时求值行为
print(customersInline)
func serveCustomer(@autoclosure customerProvider:() -> String) {
    print("now serving \(customerProvider())!")
}
serveCustomer(customersInline.removeAtIndex(0))
//过度使用autoclosures会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。

//@autoclosure特性暗含了@noescape特性，这个特性在非逃逸闭包一节中有描述。如果你想让这个闭包可以“逃逸”，则应该使用@autoclosure(escaping)特性.
var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInline.removeAtIndex(0))
collectCustomerProviders(customersInline.removeAtIndex(0))

print("Collected \(customerProviders.count) closures.")
// prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
//在上面的代码中，collectCustomerProviders(_:)函数并没有调用传入的customerProvider闭包，而是将闭包追加到了customerProviders数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包将会在函数返回之后被调用。因此，customerProvider参数必须允许“逃逸”出函数作用域。