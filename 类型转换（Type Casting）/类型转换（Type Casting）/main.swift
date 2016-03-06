//
//  main.swift
//  类型转换（Type Casting）
//
//  Created by Edwin on 16/3/5.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/***********************类型转换（Type Casting）***************************/
/**
定义一个类层次作为例子
检查类型
向下转型（Downcasting）
Any 和 AnyObject 的类型转换

类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
*/
class MediaItem {
    var name:String
    init(name:String) {
        self.name = name
    }
}
//创建子类 电影 继承与mediaitem 和构造方法 添加一个导演属性
class Movie: MediaItem {
    var director:String
    init(name:String,director:String) {
        self.director = director
        super.init(name: name)
    }
}
//创建子类 song 添加一个艺术家属性
class Song: MediaItem {
    var artist:String
    init(name: String,artist:String) {
        self.artist = artist
        super.init(name: name)
    }
}
 /// 数组常量 library，包含两个 Movie 实例和三个 Song 实例。library 的类型是在它被初始化时根据它数组中所包含的内容推断来的。Swift 的类型检测器能够推断出 Movie 和 Song 有共同的父类 MediaItem，所以它推断出 [MediaItem] 类作为 library 的类型：
let library = [
    Movie(name: "Casablanca", director: "Michael curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//检查类型 checking type
/*用类型检查操作符（is）来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。*/
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie { //检查特定类型
        ++movieCount
    } else if item is Song {//检查特定类型
        ++songCount
    }
}
print("Media library contains \(movieCount) movies and \(songCount) songs")

//向下转型（Downcasting）
//某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。
/**
向下转型（Downcasting）
某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。

因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式（conditional form）as? 返回一个你试图向下转成的类型的可选值（optional value）。强制形式 as! 把试图向下转型和强制解包（force-unwraps）转换结果结合为一个操作。

当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。

只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
*/


//数组中的每一个 item 可能是 Movie 或 Song。事前你不知道每个 item 的真实类型，所以这里使用条件形式的类型转换（as?）去检查循环里的每次下转：
for item in library {
    if let movie = item as? Movie {
        print("Movie:'\(movie.name)',dir \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}
//转换没有真的改变实例或它的值。根本的实例保持不变；只是简单地把它作为它被转换成的类型来使用
/**
Any 和 AnyObject 的类型转换
Swift 为不确定类型提供了两种特殊的类型别名：

AnyObject 可以表示任何类类型的实例。
Any 可以表示任何类型，包括函数类型。
注意
只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject。在你的代码里使用你期望的明确类型总是更好的。
*/
//AnyObject 类型
//当在工作中使用 Cocoa APIs 时，我们经常会接收到一个 [AnyObject] 类型的数组，或者说“一个任意类型对象的数组”。这是因为 Objective-C 没有明确的类型化数组。但是，你常常可以从 API 提供的信息来确定数组中对象的类型。
//在这些情况下，你可以使用强制形式的类型转换（as）来下转数组中的每一项到比 AnyObject 更明确的类型，不需要可选解包（optional unwrapping）。
let someObjects:[AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
//因为知道这个数组只包含 Movie 实例，你可以直接用（as!）下转并解包到非可选的 Movie 类型
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name),dir.\(movie.director)'")
}

print("---------------------------")
for movie in someObjects as! [Movie] {
    print("Movie:'\(movie.name)',dir.\(movie.director)")
}

//Any 类型

//这里有个示例，使用 Any 类型来和混合的不同类型一起工作，包括函数类型和非类类型。它创建了一个可以存储 Any 类型的数组 things：
var things = [Any]()
things.append(0)
things.append(1.0)
things.append(2)
things.append(35)
things.append(4)
things.append("hello")
things.append((3.0,3.5))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
///things 数组包含两个 Int 值，两个 Double 值，一个 String 值，一个元组 (Double, Double)，一个Movie实例“Ghostbusters”，以及一个接受 String 值并返回另一个 String 值的闭包表达式。

//你可以在 switch 表达式的 case 中使用 is 和 as 操作符来找出只知道是 Any 或 AnyObject 类型的常量或变量的具体类型。下面的示例迭代 things 数组中的每一项，并用 switch 语句查找每一项的类型。有几个 switch 语句的 case 绑定它们匹配到的值到一个指定类型的常量，从而可以打印这些值
print("-----------any types-----------")
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}