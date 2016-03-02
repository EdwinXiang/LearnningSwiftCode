//
//  main.swift
//  可选链式调用（Optional Chaining）
//
//  Created by Edwin on 16/3/1.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/******************************可选链式调用（Optional Chaining）**************************************/
/**
使用可选链式调用代替强制展开
为可选链式调用定义模型类
通过可选链式调用访问属性
通过可选链式调用调用方法
通过可选链式调用访问下标
连接多层可选链式调用
在方法的可选返回值上进行可选链式调用

可选链式调用（Optional Chaining）是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil。
Swift 的可选链式调用和 Objective-C 中向nil发送消息有些相像，但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功。
*/


//使用可选链式调用代替强制展开
/*
通过在想调用的属性、方法、或下标的可选值（optional value）后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败，然而强制展开将会触发运行时错误。

为了反映可选链式调用可以在空值（nil）上调用的事实，不论这个调用的属性、方法及下标返回的值是不是可选值，它的返回结果都是一个可选值。你可以利用这个返回值来判断你的可选链式调用是否调用成功，如果调用有返回值则说明调用成功，返回nil则说明调用失败。

特别地，可选链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可选值。例如，使用可选链式调用访问属性，当可选链式调用成功时，如果属性原本的返回结果是Int类型，则会变为Int?类型。
*/
class Person {
    var residence:Residence?
}
class Residence {
    var numberOfRooms = 1
}
//如果创建一个新的Person实例，因为它的residence属性是可选的，john属性将初始化为nil：
let John = Person()
//如果使用叹号（!）强制展开获得这个john的residence属性中的numberOfRooms值，会触发运行时错误，因为这时residence没有可以展开的值：
//let roomCount = John.residence!.numberOfRooms //fatal error: unexpectedly found nil while unwrapping an Optional value

//可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）：
if let roomCount = John.residence?.numberOfRooms {
    print("john's residence has \(roomCount) rooms")
} else {
    print("unable to retrieve the number of rooms")
}

/*
在residence后面添加问号之后，Swift 就会在residence不为nil的情况下访问numberOfRooms。

因为访问numberOfRooms有可能失败，可选链式调用会返回Int?类型，或称为“可选的 Int”。如上例所示，当residence为nil的时候，可选的Int将会为nil，表明无法访问numberOfRooms。访问成功时，可选的Int值会通过可选绑定展开，并赋值给非可选类型的roomCount常量。

要注意的是，即使numberOfRooms是非可选的Int时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个Int?而不是Int。
*/
//可以将一个Residence的实例赋给john.residence，这样它就不再是nil了：
John.residence = Residence()
if let roomCount = John.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).") //打印这句话
} else {
    print("Unable to retrieve the number of rooms.")
}

//为可选链式调用定义模型类
//通过使用可选链式调用可以调用多层属性、方法和下标。这样可以在复杂的模型中向下访问各种子属性，并且判断能否访问子属性的属性、方法或下标。
class Persons {
    var residences:Residences?
}
class Residences {
    var rooms = [Room]()
    var numberOfRooms:Int {
        return rooms.count
    }
    subscript (i:Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("the number of rooms is \(numberOfRooms)")
    }
    var address:Address?
}
//定义房间的类
class Room {
    let name: String
    init(name: String) { self.name = name }
}
//定义地址类
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

//通过可选链式调用访问属性
print("通过可选链式调用访问属性")
let Edwin = Persons()
if let roomCount = Edwin.residences?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
print("------------------------------")
//因为john.residence为nil，所以这个可选链式调用依旧会像先前一样失败
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "七道堰街"
Edwin.residences?.address = someAddress   //通过john.residence来设定address属性也会失败，因为john.residence当前为nil。
func createAddress() -> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "1112"
    someAddress.street = "高升桥"
    return someAddress
}
Edwin.residences?.address = createAddress() //没有任何打印消息，可以看出createAddress()函数并未被执行。
//通过可选链式调用方法
print("----通过可选链式调用方法-------")
if Edwin.residences?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms")
} else {
    print("It was not possible to print the number of rooms")
}

//通过可选链式调用访问下标
//通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功。
print("-----通过可选链式调用访问下标-------")
//用下标访问john.residence属性存储的Residence实例的rooms数组中的第一个房间的名称，因为john.residence为nil，所以下标调用失败了
if let firstRoomName = Edwin.residences?[0].name {
    print("the first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

Edwin.residences?[0] = Room(name: "bathroom") //这次赋值同样会失败，因为residence目前是nil。

//如果你创建一个Residence实例，并为其rooms数组添加一些Room实例，然后将Residence实例赋值给john.residence，那就可以通过可选链和下标来访问数组中的元素：
let JohnHouse = Residences()
JohnHouse.rooms.append(Room(name: "living room"))
JohnHouse.rooms.append(Room(name:"kitchen"))
Edwin.residences = JohnHouse

if let firstRoomName = Edwin.residences?[0].name {
    print("the first room name is \(firstRoomName)")
} else {
    print("unable to retrieve the first room name ")
}


//访问可选类型的下标
var testScores = ["Dave":[87,83,90],"Bev":[79,23,45]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brain"]?[0] = 72 //testScores字典中没有"Brian"这个键，所以第三个调用失败。
print(testScores)

//连接多层可选链式调用
//可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
/*
如果你访问的值不是可选的，可选链式调用将会返回可选值。
如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
因此：

通过可选链式调用访问一个Int值，将会返回Int?，无论使用了多少层可选链式调用。
类似的，通过可选链式调用访问Int?值，依旧会返回Int?值，并不会返回Int??。
*/
if let johnStreet = Edwin.residences?.address?.street {
    print("John's street name is \(johnStreet).")
} else {
    print("Unable to retrieve the address.")
}
//john.residence现在包含一个有效的Residence实例。然而，john.residence.address的值当前为nil。因此，调用john.residence?.address?.street会失败。
//如果为john.residence.address赋值一个Address实例，并且为address中的street属性设置一个有效值，我们就能过通过可选链式调用来访问street属性：
let johnAddress = Address()
johnAddress.buildingName = "The larches"
johnAddress.street = "武侯祠"
Edwin.residences?.address = johnAddress
//因为john.residence包含一个有效的Residence实例，所以对john.residence的address属性赋值将会成功。
if let johnsStreet = Edwin.residences?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

//在方法的可选返回值上进行可选链式调用
//，通过可选链式调用来调用Address的buildingIdentifier()方法。这个方法返回String?类型的值。如上所述，通过可选链式调用来调用该方法，最终的返回值依旧会是String?类型：
if let buildingIdentifier = Edwin.residences?.address?.buildingIdentifier() {
    print("john's building identifieri is \(buildingIdentifier)")
}

//如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可：
if let beginWithThe = Edwin.residences?.address?.buildingIdentifier()?.hasPrefix("the") {
    if beginWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
//注意
//在上面的例子中，在方法的圆括号后面加上问号是因为你要在buildingIdentifier()方法的可选返回值上进行可选链式调用，而不是方法本身。