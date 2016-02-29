//
//  main.swift
//  析构过程（Deinitialization）
//
//  Created by Edwin on 16/2/29.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/*********************** 析构过程（Deinitialization）************************/
/**
析构过程原理
析构器实践
析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。
在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：

deinit {
// 执行析构过程
}
*/

//析构器实践
class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinsToVend:Int) ->Int {
        numberOfCoinsToVend = min(numberOfCoinsToVend,coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receiveCoins(coins:Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse:Int
    init(coins:Int) { //构造方法
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins:Int) {
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit {//析构方法
        Bank.receiveCoins(coinsInPurse)
    }
}
var playerOne:Player? = Player(coins: 100)
print("a new player has joined the game with \(playerOne!.coinsInPurse) coins")//!解包
print("there are now \(Bank.coinsInBank) coins left in the bank")
playerOne!.winCoins(2_000)
print("playerOne win 2_000 coins & now has \(playerOne!.coinsInPurse) coins")
playerOne = nil
print("player has left the game")
//玩家现在已经离开了游戏。这通过将可选类型的playerOne变量设置为nil来表示，意味着“没有Player实例”。当这一切发生时，playerOne变量对Player实例的引用被破坏了。没有其它属性或者变量引用Player实例，因此该实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行。
print("the bank has \(Bank.coinsInBank) bank")