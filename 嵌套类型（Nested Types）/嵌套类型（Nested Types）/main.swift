//
//  main.swift
//  嵌套类型（Nested Types）
//
//  Created by Edwin on 16/3/6.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/**********************嵌套类型（Nested Types）****************************/
/**
嵌套类型实践
引用嵌套类型
枚举常被用于为特定类或结构体实现某些功能。类似的，也能够在某个复杂的类型中，方便地定义工具类或结构体来使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体。

要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的{}内，而且可以根据需要定义多级嵌套。
*/
/*嵌套类型实践
下面这个例子定义了一个结构体BlackjackCard（二十一点），用来模拟BlackjackCard中的扑克牌点数。BlackjackCard结构体包含两个嵌套定义的枚举类型Suit和Rank。
在BlackjackCard中，Ace牌可以表示1或者11，Ace牌的这一特征通过一个嵌套在Rank枚举中的结构体Values来表示：*/
struct BlackjackCard {
     //嵌套的枚举
    enum Suit:Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
     // 嵌套的 Rank 枚举
    enum Rank: Int {
       case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
       case Jack = 11, Queen, King, Ace
        struct Values{
            let first:Int,second:Int?
        }
        var values:Values {
            switch self {
            case.Ace:
                return Values(first: 1, second: 11)
            case.Jack,.Queen,.King:
                return Values(first: self.rawValue, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //BlackjackCard 的属性和方法
    let rank:Rank,suit:Suit
    var description:String {
        var output = "suit is \(suit.rawValue)"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceofSpades = BlackjackCard(rank: .King, suit: .Spades)
print("theAceOfSpades: \(theAceofSpades.description)")
//尽管Rank和Suit嵌套在BlackjackCard中，但它们的类型仍可从上下文中推断出来，所以在初始化实例时能够单独通过成员名称（.Ace和.Spades）引用枚举实例。在上面的例子中，description属性正确地反映了黑桃A牌具有1和11两个值。


//引用嵌套类型
//在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
print(heartsSymbol)

