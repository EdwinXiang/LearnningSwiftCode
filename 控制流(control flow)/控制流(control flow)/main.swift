//
//  main.swift
//  控制流(control flow)
//
//  Created by Edwin on 16/2/23.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/**
For 循环
While 循环
条件语句
控制转移语句（Control Transfer Statements）
提前退出
检测API可用性
*/

/**************For 循环***************/
//Swift 提供两种for循环形式来按照指定的次数执行一系列语句：
//
//for-in循环对一个集合里面的每个元素执行一系列语句。
//for 循环，用来重复执行一系列语句直到达成特定条件达成，一般通过在每次循环完成后增加计数器的值来实现。
//1 For-In

//你可以使用for-in循环来遍历一个集合里面的所有元素，例如由数字表示的区间、数组中的元素、字符串中的字符。 使用闭区间操作符（...）表示的从1到5的数字
for index in 1...5 {
    print("\(index) times 5 is \(index*5)")
}
//如果不需要知道区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略对值的访问
let base = 3
let power = 10
var answer = 1
for _ in 1...power{
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

// 使用for-in遍历一个数组所有元素：
let names = ["Anna","Alex","Brian","Jack"]
for name in names {
    print("hello, \(name)!")
}
//字典元素的遍历顺序和插入顺序可能不同，字典的内容在内部是无序的，所以遍历元素时不能保证顺序。
//下面是一般情况下这种循环方式的格式：

//for initialization; condition; increment {
//    statements
//}
var index:Int
for index = 0;index<5;index++ {
    print("index is \(index)")
}
print("index++ = \(index)")

/********************while 循环*************************/
/*
while循环运行一系列语句直到条件变成false。这类循环适合使用在第一次迭代前迭代次数未知的情况下。Swift 提供两种while循环形式：

while循环，每次在循环开始时计算条件是否符合；
repeat-while循环，每次在循环结束时计算条件是否符合。
*/
//while循环从计算单一条件开始。如果条件为true，会重复运行一系列语句，直到条件变为false。

//下面是一般情况下 while 循环格式：
//
//while condition {
//    statements
//}
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
//while square < finalSquare {
//    // 掷骰子
//    if ++diceRoll == 7 { diceRoll = 1 }
//    // 根据点数移动
//    square += diceRoll
//    if square < board.count {
//        // 如果玩家还在棋盘上，顺着梯子爬上去或者顺着蛇滑下去
//        square += board[square]
//    }
//}
//print("Game over!")

//Repeat-While
//
//while循环的另外一种形式是repeat-while，它和while的区别是在判断循环条件之前，先执行一次循环的代码块，然后重复循环直到条件为false。
//
//注意： Swift语言的repeat-while循环合其他语言中的do-while循环是类似的。
//下面是一般情况下 repeat-while循环的格式：
//repeat {
//    statements
//} while condition
/************************************************************/
//repeat {
//    // 顺着梯子爬上去或者顺着蛇滑下去
//    square += board[square]
//    // 掷骰子
//    if ++diceRoll == 7 { diceRoll = 1 }
//    // 根据点数移动
//    square += diceRoll
//} while square < finalSquare
//print("Game over!")
/************************************************************/
//条件语句
//根据特定的条件执行特定的代码通常是十分有用的，例如：当错误发生时，你可能想运行额外的代码；或者，当输入的值太大或太小时，向用户显示一条消息等。要实现这些功能，你就需要使用条件语句。
//
//Swift 提供两种类型的条件语句：if语句和switch语句。通常，当条件较为简单且可能的情况很少时，使用if语句。而switch语句更适用于条件较复杂、可能情况较多且需要用到模式匹配（pattern-matching）的情境。
// if 语句
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
//你可以把多个if语句链接在一起，像下面这样：
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// switch 

//switch语句会尝试把某个值与若干个模式（pattern）进行匹配。根据第一个匹配成功的模式，switch语句会执行对应的代码。当有可能的情况较多时，通常用switch语句替换if语句。
//
//switch语句最简单的形式就是把某个值与一个或若干个相同类型的值作比较：
/*
switch some value to consider {
case value 1:
respond to value 1
case value 2, value 3:
respond to value 2 or 3
default:
otherwise, do something else
}
*/

let someCharacter:Character = "e"
switch someCharacter {
    case "a","e","i","o","u":
    print("\(someCharacter) is vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
//每一个 case 分支都必须包含至少一条语句。像下面这样书写代码是无效的，因为第一个 case 分支是空的：
//let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a":
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
//一个 case 也可以包含多个模式，用逗号把它们分开（如果太长了也可以分行写）：

//switch some value to consider {
//    case value 1, value 2:
//    statements
//}

//区间
let approximateCount = 62
let countedThings = "moons orbiting saturn"
var naturalCount:String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
    
default:
    naturalCount = "many"
}
print("there are \(naturalCount) \(countedThings)")
//闭区间操作符(...)以及半开区间操作符(..<)功能被重载去返回IntervalType或Range。一个区间可以决定他是否包含特定的元素，就像当匹配一个switch声明的case一样。区间是一个连续值的集合，可以用for-in语句遍历它。

//元组（Tuple）

//我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
let somePoint = (1,0)
switch somePoint {
case(0,0):
    print("(0,0) is at the origin")
case(_,0):
    print("\(somePoint.0),0) is on the x-axis ")
case(0,_):
     print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
//值绑定（Value Bindings）

//case 分支的模式允许将匹配的值绑定到一个临时的常量或变量，这些常量或变量在该 case 分支里就可以被引用了——这种行为被称为值绑定（value binding）。
let anotherPoint = (2,0)
switch anotherPoint {
case(let x,0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

/*******************where ************************/
//Where
//case 分支的模式可以使用where语句来判断额外的条件。
let yetAnotherPoint = (1,-1)
switch yetAnotherPoint {
case let(x,y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}



/****************控制转移语句**********************/
/**
*控制转移语句（Control Transfer Statements）
控制转移语句改变你代码的执行顺序，通过它你可以实现代码的跳转。Swift 有五种控制转移语句：
continue
break
fallthrough
return
throw
*/
//1. continue   continue语句告诉一个循环体立刻停止本次循环迭代，重新开始下次循环迭代。就好像在说“本次循环迭代我已经执行完了”，但是并不会离开整个循环体   🐷在一个带有条件和递增的for循环体中，调用continue语句后，迭代增量仍然会被计算求值。循环体继续像往常一样工作，仅仅只是循环体中的执行代码会被跳过。

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for Character in puzzleInput.characters {
    switch Character {
    case "a", "e", "i", "o", "u", " ":
        continue
    default:
        puzzleOutput.append(Character)
    }
}

print("---\(puzzleOutput)---")

//2. Break
//break语句会立刻结束整个控制流的执行。当你想要更早的结束一个switch代码块或者一个循环体时，你都可以使用break语句。
//循环语句中的 break
//当在一个循环体中使用break时，会立刻中断该循环体的执行，然后跳转到表示循环体结束的大括号(})后的第一行代码。不会再有本次循环迭代的代码被执行，也不会再有下次的循环迭代产生。
//Switch 语句中的 break
//当在一个switch代码块中使用break时，会立即中断该switch代码块的执行，并且跳转到表示switch代码块结束的大括号(})后的第一行代码。
let numberSymbol: Character = "三"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}

//贯穿（Fallthrough）
//Swift 中的switch不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支完成了它需要执行的语句，整个switch代码块完成了它的执行。相比之下，C 语言要求你显式地插入break语句到每个switch分支的末尾来阻止自动落入到下一个 case 分支中。Swift 的这种避免默认落入到下一个分支中的特性意味着它的switch 功能要比 C 语言的更加清晰和可预测，可以避免无意识地执行多个 case 分支从而引发的错误。
//如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用fallthrough关键字。下面的例子使用fallthrough来创建一个数字的描述语句。
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
//🐷 fallthrough关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough简单地使代码执行继续连接到下一个 case 中的执行代码，这和 C 语言标准中的switch语句特性是一样的。

//带标签的语句

//label name: while condition {
//statements
//}
gameLoop: while square != finalSquare {
    if ++diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // 到达最后一个方块，游戏结束
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // 超出最后一个方块，再掷一次骰子
        continue gameLoop
    default:
        // 本次移动有效
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")


//提前退出
//像if语句一样，guard的执行取决于一个表达式的布尔值。我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else分句，如果条件不为真则执行else分句中的代码。
func greet(person:[String:String]) {
    guard let name = person["name"] else {
        return
    }
    print("hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

greet(["name":"Jone"])

greet(["name":"Jane","location":"chengdu"])
//检测 API 可用性
if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 的 API, 在 OS X 使用 OS X v10.10 的 API
} else {
    // 使用先前版本的 iOS 和 OS X 的 API
}
//if #available(platform name version, ..., *) {
//    statements to execute if the APIs are available
//} else {
//    fallback statements to execute if the APIs are unavailable
//}
