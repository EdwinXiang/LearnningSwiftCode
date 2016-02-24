//
//  main.swift
//  字符串和字符
//
//  Created by Edwin on 16/2/22.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

//1、初始化
var emptyString = ""  //空字符串字面量
var anotherEmptyString = String() //字符串初始化
//字符串可以通过传递一个值类型为Character的数组作为自变量来初始化：
let catCharaters:[Character] = ["c","a","t","🐱"]
let catString = String(catCharaters)
print(catString)

//2、判断字符串是否为空
if emptyString.isEmpty{
    
    print("nothing to see here")
}

//3、可变字符串
var variableString = "horse"
variableString += "and carriage"
print(variableString)

//注意：不可变字符串是不能相加的  不然会报错 eg :
//let constantString = "highlander"
//constantString += "and another highlander"
//Swift 的String类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操作


//4、使用字符（Working with Characters）
//您可通过for-in循环来遍历字符串中的characters属性来获取每一个字符的值：
for character in "chinese".characters{
    print(character)
}

//另外，通过标明一个Character类型并用字符字面量进行赋值，可以建立一个独立的字符常量或变量：
let exclanationMark:Character = "a"

//5、连接字符串和字符 (Concatenating Strings and Characters)
//5.1字符串可以通过加法运算符（+）相加在一起（或称“连接”）创建一个新的字符串：
let string1 = "hello"
let string2 = " world"
var welcome = string1 + string2
print("两个字符串相加=\(welcome)")
//5.2也可以通过加法赋值运算符 (+=) 将一个字符串添加到一个已经存在字符串变量上
var instruction = "look over"
instruction += string2
print(instruction)
//5.3 您可以用append()方法将一个字符附加到一个字符串变量的尾部
var exclamationMask2:Character = "!"
welcome.append(exclamationMask2)
print("添加字符过后的welcome\(welcome)")

//6、字符串插值 (String Interpolation)
//字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。 您插入的字符串字面量的每一项都在以反斜线为前缀的圆括号中：
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier)*2.5)"
print(message)

//在上面的例子中，multiplier作为\(multiplier)被插入到一个字符串常量量中。 当创建字符串执行插值计算时此占位符会被替换为multiplier实际的值。

//multiplier的值也作为字符串中后面表达式的一部分。 该表达式计算Double(multiplier) * 2.5的值并将结果 (7.5) 插入到字符串中。 在这个例子中，表达式写为\(Double(multiplier) * 2.5)并包含在字符串字面量中。
/*
*注意：
*插值字符串中写在括号中的表达式不能包含非转义反斜杠 (\)，并且不能包含回车或换行符。不过，插值字符串可以包含其他字面量。
*/

//7、Unicode
//7.1 Unicode 是一个国际标准，用于文本的编码和表示。 它使您可以用标准格式表示来自任意语言几乎所有的字符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。 Swift 的String和Character类型是完全兼容 Unicode 标准的。
//7.2 Swift 的String类型是基于 Unicode 标量 建立的。 Unicode 标量是对应字符或者修饰符的唯一的21位数字，例如U+0061表示小写的拉丁字母(LATIN SMALL LETTER A)("a")，U+1F425表示小鸡表情(FRONT-FACING BABY CHICK) ("🐥")。
//7.3 注意： Unicode 码位(code poing) 的范围是U+0000到U+D7FF或者U+E000到U+10FFFF。Unicode 标量不包括 Unicode 代理项(surrogate pair) 码位，其码位范围是U+D800到U+DFFF。
//7.5 字符串字面量的特殊字符 (Special Characters in String Literals)

//字符串字面量可以包含以下特殊字符：
//
//转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
//Unicode 标量，写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。
//下面的代码为各种特殊字符的使用示例。 wiseWords常量包含了两个双引号。 dollarSign、blackHeart和sparklingHeart常量演示了三种不同格式的 Unicode 标量：
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imageination is more important than knowledge" - Enistein
let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496
 print(dollarSign,blackHeart,sparklingHeart)

//8. 可扩展的字形群集(Extended Grapheme Clusters)

//每一个 Swift 的Character类型代表一个可扩展的字形群。 一个可扩展的字形群是一个或多个可生成人类可读的字符 Unicode 标量的有序排列。 举个例子，字母é可以用单一的 Unicode 标量é(LATIN SMALL LETTER E WITH ACUTE, 或者U+00E9)来表示。然而一个标准的字母e(LATIN SMALL LETTER E或者U+0065) 加上一个急促重音(COMBINING ACTUE ACCENT)的标量(U+0301)，这样一对标量就表示了同样的字母é。 这个急促重音的标量形象的将e转换成了é。
let eAcute:Character = "\u{E9}"
let conbinedAcute:Character = "\u{65}\u{301}"
print(eAcute,conbinedAcute)


//9、计算字符数量 (Counting Characters)
//如果想要获得一个字符串中Character值的数量，可以使用字符串的characters属性的count属性：
let unusualMenagerie = "koala 🐂,snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count)characters")

//字符串索引 (String Indices)

//每一个String值都有一个关联的索引(index)类型，String.Index，它对应着字符串中的每一个Character的位置。
//
//前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道Character的确定位置，就必须从String开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数(integer)做索引。
//
//使用startIndex属性可以获取一个String的第一个Character的索引。使用endIndex属性可以获取最后一个Character的后一个位置的索引。因此，endIndex属性不能作为一个字符串的有效下标。如果String是空串，startIndex和endIndex是相等的。
//
//通过调用String.Index的predecessor()方法，可以立即得到前面一个索引，调用successor()方法可以立即得到后面一个索引。任何一个String的索引都可以通过锁链作用的这些方法来获取另一个索引，也可以调用advancedBy(_:)方法来获取。但如果尝试获取出界的字符串索引，就会抛出一个运行时错误。
//
//你可以使用下标语法来访问String特定索引的Character。
let greeting = "Guten Tag!"
 var characters = greeting[greeting.startIndex]
print(characters)
characters = greeting[greeting.endIndex.predecessor()]
print(characters)
 characters = greeting[greeting.startIndex.successor()]
print(characters)

let index = greeting.startIndex.advancedBy(7)
 characters = greeting[index]
print(characters)
//9.1 使用characters属性的indices属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单个字符。
print("\n\n\n")
for index in greeting.characters.indices{
    
    print("\(greeting[index]) ", terminator: "")
}

//10 插入和删除 (Inserting and Removing)

//10.1调用insert(_:atIndex:)方法可以在一个字符串的指定索引插入一个字符。
print("\n===========================")
var welcomes = "hello"
welcomes.insert("!", atIndex: welcomes.endIndex)
print(welcomes)
//10.1.1 调用insertContentsOf(_:at:)方法可以在一个字符串的指定索引插入一个字符串。
//welcomes.insertContentsOf("here", at: welcomes.endIndex.predecessor())
//welcome.insertContentsOf("", at: welcome.endIndex.predecessor())
welcomes.insertContentsOf(" there".characters, at: welcomes.endIndex.predecessor())
// welcome 现在等于 "hello there!"
//10.2 调用removeAtIndex(_:)方法可以在一个字符串的指定索引删除一个字符。
welcomes.removeAtIndex(welcomes.endIndex.predecessor())
print(welcomes)
//10.3 调用removeRange(_:)方法可以在一个字符串的指定索引删除一个子字符串。
let range = welcomes.endIndex.advancedBy(-6)..<welcomes.endIndex
welcomes.removeRange(range)
print(welcomes)

//11 比较字符串 (Comparing Strings)
//Swift 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等。
/*
字符串/字符相等 (String and Character Equality)

字符串/字符可以用等于操作符(==)和不等于操作符(!=)，详细描述在比较运算符：
*/
let quotation = "we're a lot alike,you and I"
let sameQuotation = "we're a lot alike,you and I"
if quotation == sameQuotation{
    print("these two string are consider equal!!!")
}

//如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等的，那就认为它们是相等的。在这个情况下，即使可扩展的字形群集是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等。
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
print(eAcuteQuestion)
// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
print(combinedEAcuteQuestion)
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
//注意 ：：：：相反，英语中的LATIN CAPITAL LETTER A(U+0041，或者A)不等于俄语中的CYRILLIC CAPITAL LETTER A(U+0410，或者A)。两个字符看着是一样的，但却有不同的语言意义：
let latinCapitalLetterA: Character = "\u{41}"
print(latinCapitalLetterA)
let cyrillicCapitalLetterA: Character = "\u{0410}"
print(cyrillicCapitalLetterA)
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}

//12 前缀/后缀相等 (Prefix and Suffix Equality)

//通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值。
//
//下面的例子以一个字符串数组表示莎士比亚话剧《罗密欧与朱丽叶》中前两场的场景位置：
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var actionSceneCount = 0
for scene in romeoAndJuliet{
    if scene.hasPrefix("Act 1"){
        ++actionSceneCount
    }
    
}

print("There are \(actionSceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        ++mansionCount
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        ++cellCount
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
//hasPrefix(_:)和hasSuffix(_:)方法都是在每个字符串中逐字符比较其可扩展的字符群集是否标准相等

//13 字符串的 Unicode 表示形式（Unicode Representations of Strings）
/*
Swift 提供了几种不同的方式来访问字符串的 Unicode 表示形式。 您可以利用for-in来对字符串进行遍历，从而以 Unicode 可扩展的字符群集的方式访问每一个Character值。 该过程在 使用字符 中进行了描述。

另外，能够以其他三种 Unicode 兼容的方式访问字符串的值：

UTF-8 代码单元集合 (利用字符串的utf8属性进行访问)
UTF-16 代码单元集合 (利用字符串的utf16属性进行访问)
21位的 Unicode 标量值集合，也就是字符串的 UTF-32 编码格式 (利用字符串的unicodeScalars属性进行访问)
*/

let dogString = "Dog!!🐶"
//您可以通过遍历String的utf8属性来访问它的UTF-8表示。 其为String.UTF8View类型的属性，UTF8View是无符号8位 (UInt8) 值的集合，每一个UInt8值都是一个字符的 UTF-8 表示：
for codeUnit in dogString.utf8 {
    print("\(codeUnit)",terminator: " ")
}

print("")

//utf-16
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")

//Unicode 标量表示 (Unicode Scalars Representation)
//
//您可以通过遍历String值的unicodeScalars属性来访问它的 Unicode 标量表示。 其为UnicodeScalarView类型的属性，UnicodeScalarView是UnicodeScalar类型的值的集合。 UnicodeScalar是21位的 Unicode 代码点。
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
    print(scalar)
}
print("")