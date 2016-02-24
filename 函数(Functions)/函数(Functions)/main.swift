//
//  main.swift
//  函数(Functions)
//
//  Created by Edwin on 16/2/24.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/**************************函数(functions)*******************************/
/*
函数定义与调用（Defining and Calling Functions）
函数参数与返回值（Function Parameters and Return Values）
函数参数名称（Function Parameter Names）
函数类型（Function Types）
嵌套函数（Nested Functions）
*/
//1.函数的定义与调用（Defining and Calling Functions）
//当你定义一个函数时，你可以定义一个或多个有名字和类型的值，作为函数的输入（称为参数，parameters），也可以定义某种类型的值作为函数执行结束的输出（称为返回类型，return type）。
//每个函数有个函数名，用来描述函数执行的任务。要使用一个函数时，你用函数名“调用”，并传给它匹配的输入值（称作实参，arguments）。一个函数的实参必须与函数参数表里参数的顺序一致。
func sayHello(personName:String)->String {
    let greeting = "hello," + personName + "!"
    return greeting
}
func sayHelloAgain(personName: String) -> String {
    return "Hello again, " + personName + "!"
}

let str = sayHello("Abby")
print(str)

//函数参数与返回值（Function Parameters and Return Values）
//函数参数与返回值在 Swift 中极为灵活。你可以定义任何类型的函数，包括从只带一个未名参数的简单函数到复杂的带有表达性参数名和不同参数选项的复杂函数。
//2.无参函数（Functions Without Parameters）
//函数可以没有参数。下面这个函数就是一个无参函数，当被调用时，它返回固定的 String 消息：
func sayHelloWorld()->String {
    return "hello,world!"
}
print(sayHelloWorld())

//3.多参数函数 (Functions With Multiple Parameters)
//函数可以有多种输入参数，这些参数被包含在函数的括号之中，以逗号分隔。
func sayHellos(personName:String,alreadyGreeted:Bool) -> String {
    if alreadyGreeted {
        return sayHelloAgain(personName)
    }else {
        return sayHello(personName)
    }
}
print(sayHellos("Tim", alreadyGreeted: true))

//4. 无返回值函数（Functions Without Return Values）
//函数可以没有返回值。下面是 sayHello(_:) 函数的另一个版本，叫 sayGoodbye(_:)，这个函数直接输出 String 值，而不是返回它：
func sayGoodBye(personName:String) {
    print("GoodBye, \(personName)!")
}
sayGoodBye("Time")
//被调用时一个函数的返回值可以被忽略
func printAndCount(StringToPint:String) -> Int {
    print(StringToPint)
    return StringToPint.characters.count
}

func printWithOutCounting(StringToPint:String) {
    printAndCount(StringToPint)
}
//print("hello,world!")
printAndCount("hello,world!")
printWithOutCounting("hello,tomarrow")
//注意
//返回值可以被忽略，但定义了有返回值的函数必须返回一个值，如果在函数定义底部没有返回任何值，将导致编译错误（compile-time error）。
//5. 多重返回值函数（Functions with Multiple Return Values）
//你可以用元组（tuple）类型让多个值作为一个复合值从函数中返回。
func minMax(Array:[Int]) -> (min:Int,max:Int) {
    var currentMin = Array[0]
    var currentMax = Array[0]
    for value in Array[1..<Array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return(currentMin,currentMax)
}

let bounds = minMax([7,3,8,4,6,501,34,42,45,65])
print("min is \(bounds.min) and max is \(bounds.max)")

//可选元组返回类型(Optional Tuple Return Types)
//如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的（Optional） 元组返回类型反映整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如(Int, Int)?或(String, Int, Bool)?
//注意
//可选元组类型如(Int, Int)?与元组包含可选类型如(Int?, Int?)是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
//为了安全地处理这个“空数组”问题，将minMax(_:)函数改写为使用可选元组返回类型，并且当数组为空时返回nil：
func minMaxx(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let boundas = minMaxx([8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

//函数参数名称（Function Parameter Names）
//函数参数都有一个外部参数名（external parameter name）和一个局部参数名（local parameter name）。外部参数名用于在函数调用时标注传递给函数的参数，局部参数名在函数的实现内部使用。
func someFunction(firstParameterName:Int,secondParameterName:Int){
    let sum = firstParameterName+secondParameterName
    print(sum)
}
//一般情况下，第一个参数省略其外部参数名，第二个以及随后的参数使用其局部参数名作为外部参数名。所有参数必须有独一无二的局部参数名。尽管多个参数可以有相同的外部参数名，但不同的外部参数名能让你的代码更有可读性。
someFunction(10, secondParameterName: 20)

//指定外部参数名（Specifying External Parameter Names）
//你可以在局部参数名前指定外部参数名，中间以空格分隔：
func someFunctions(externalParameterName localParamaterName:Int){
    print(localParamaterName)
}
//果你提供了外部参数名，那么函数在被调用时，必须使用外部参数名
someFunctions(externalParameterName: 20)

func sayHelloWorld(to person:String,and anotherPerson:String) -> String {
    return "hello \(person) and \(anotherPerson)"
}
//为每个参数指定外部参数名后，在你调用sayHello(to:and:)函数时两个外部参数名都必须写出来。
//使用外部函数名可以使函数以一种更富有表达性的类似句子的方式调用，并使函数体意图清晰，更具可读性。
print(sayHelloWorld(to: "Abby", and: "Edwin"))


//忽略外部参数名（Omitting External Parameter Names）
//如果你不想为第二个及后续的参数设置外部参数名，用一个下划线（_）代替一个明确的参数名。
func loveBaby(name:String,_ age:Int,_ sex:String) ->String {
    return "I love \(name),\(age)"
}

print(loveBaby("hxl", 24, "female"))

//默认参数值（Default Parameter Values）
//你可以在函数体中为每个参数定义默认值（Deafult Values）。当默认值被定义后，调用这个函数时可以忽略这个参数。
func sunmmer(parameterWithDefault:Int = 12) ->Int{
    return parameterWithDefault
}

print(sunmmer(24)) //返回传入的值
print(sunmmer()) //返回默认值

//可变参数（Variadic Parameters）
//一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数。
//可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。

func arithmeticMean(numbers:Double...) ->Double{
    var total:Double = 0
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
}

 print(arithmeticMean(1,2,3,4,5,6,7,8,9))
//如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后。
//常量参数和变量参数（Constant and Variable Parameters）
//函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。
//但是，有时候，如果函数中有传入参数的变量值副本将是很有用的。你可以通过指定一个或多个参数为变量参数，从而避免自己在函数中定义新的变量。变量参数不是常量，你可以在函数中把它当做新的可修改副本来使用。
//通过在参数名前加关键字 var 来定义变量参数：
func alignRight(var string: String, totalLength: Int, pad: Character) -> String {
    let amountToPad = totalLength - string.characters.count
    if amountToPad < 1 {
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let originalString = "hello"
let paddedString = alignRight(originalString, totalLength: 10, pad: "-")
print(paddedString)

//输入输出参数（In-Out Parameters）
//变量参数，正如上面所述，仅仅能在函数体内被更改。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）。
//定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。想获取更多的关于输入输出参数的细节和相关的编译器优化，请查看输入输出参数一节。
//你只能传递变量给输入输出参数。你不能传入常量或者字面量（literal value），因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加&符，表示这个值可以被函数修改。
//输入输出参数不能有默认值，而且可变参数不能用 inout 标记。如果你用 inout 标记一个参数，这个参数不能被 var 或者 let 标记。
func swapTwoInts(inout a:Int,inout _ b:Int) {
    let temporary = a
    a = b
    b = temporary
}

var someInt = 3
var anotherInt = 5
swap(&someInt, &anotherInt)
print("someInt now is \(someInt),and anotherInt now is \(anotherInt)")

//函数类型（Function Types）
//每个函数都有种特定的函数类型，由函数的参数类型和返回类型组成。这两个函数的类型是 (Int, Int) -> Int，
func addTwoInts(a:Int,_ b:Int) ->Int {
    return a+b
}

func multiplyTwoInts(a:Int,_ b:Int) -> Int{
    return a*b
}
//无参数无返回值
func printHelloWorld(){
    print("hello,world!")
}

//使用函数类型（Using Function Types）

//在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
//
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result:\(mathFunction(2,4))")

//有相同匹配类型的不同函数可以被赋值给同一个变量，就像非函数类型的变量一样：
mathFunction = multiplyTwoInts
print("Result:\(mathFunction(2,4))")
let anotherMathFunction = addTwoInts //就像其他类型一样，当赋值一个函数给常量或变量时，你可以让 Swift 来推断其函数类型：

//函数类型作为参数类型（Function Types as Parameter Types）
//你可以用(Int, Int) -> Int这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给函数的调用者来提供。
func printMathResult(mathFunction:(Int,Int) -> Int,_ a:Int,_ b:Int){
    print("result:\(mathFunction(a,b))")
}

printMathResult(addTwoInts, 5, 10)

//函数类型作为返回类型（Function Types as Return Types）
//你可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头（->）后写一个完整的函数类型。?
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards:Bool) -> (Int) ->Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = 10
let moveNearerToZero = chooseStepFunction(currentValue>0)
print("Counting to zero:")
// Counting to zero:
//while currentValue != 0 {
//    print("\(currentValue)... ")
//    currentValue = moveNearerToZero(currentValue)
//}
while currentValue != 0{
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

//嵌套函数（Nested Functions）
//这章中你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。你也可以把函数定义在别的函数体中，称作嵌套函数（nested functions）。
//默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
func chooseStepFunctions(backwards:Bool) ->(Int) -> Int{
    func stepForward(input:Int) ->Int {
        return input + 1
    }
    func stepBackward(input:Int) -> Int {
        return input - 1
    }
    
    return backwards ? stepBackward : stepForward
}

var currentValues = -5
let moveNearerToZeros = chooseStepFunctions(currentValue > 0)
while currentValues != 0 {
    print("\(currentValues)...")
    currentValues = moveNearerToZeros(currentValues)
}
print("zero!")
