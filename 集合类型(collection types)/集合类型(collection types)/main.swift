//
//  main.swift
//  集合类型(collection types)
//
//  Created by Edwin on 16/2/22.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

print("Hello, World!")

//集合的可变性（Mutability of Collections）
//数组（Arrays）
//集合（Sets）
//字典（Dictionaries）
//Swift 语言提供A
//rrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集。
//Swift 语言中的Arrays、Sets和Dictionaries中存储的数据值类型必须明确。这意味着我们不能把不正确的数据类型插入其中。同时这也说明我们完全可以对取回值的类型非常自信。

//1. 集合的可变性
//如果创建一个Arrays、Sets或Dictionaries并且把它分配成一个变量，这个集合将会是可变的。这意味着我们可以在创建之后添加更多或移除已存在的数据项，或者改变集合中的数据项。如果我们把Arrays、Sets或Dictionaries分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
//2. 数组
//2.1 创建数组
var someInts = [Int]()
someInts = [] //空数组
//2.2 Swift 中的Array类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeatedValue）传入数组构造函数
var threeDoubles = [Double](count: 3, repeatedValue: 0) // threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]
//2.3 通过两个数组相加创建一个数组
var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)// anotherThreeDoubles 被推断为 [Double]，等价于 [2.5, 2.5, 2.5]
print(anotherThreeDoubles)

var sixDoubles = threeDoubles+anotherThreeDoubles // sixDoubles 被推断为 [Double]，等价于 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
print(sixDoubles)
//2.3 用字面量构造数组

//我们可以使用字面量来进行数组构造，这是一种用一个或者多个数值构造数组的简单方法。字面量是一系列由逗号分割并由方括号包含的数值：
var shoppingList:[String] = ["edwin","abby","miki"]
print(shoppingList)
//注意：
//Shoppinglist数组被声明为变量（var关键字创建）而不是常量（let创建）是因为以后可能会有更多的数据项被插入其中
//由于 Swift 的类型推断机制，当我们用字面量构造只拥有相同类型值数组的时候，我们不必把数组的类型定义清楚。 shoppinglist的构造也可以这样写：
//var shoppingList = ["edwin","abby","miki"]

//3.访问和修改数组

//我们可以通过数组的方法和属性来访问和修改数组，或者使用下标语法。
//
//可以使用数组的只读属性count来获取数组中的数据项数量：
print("the shopping list contains\(shoppingList.count)items")

//使用布尔值属性来检查count属性值是否为0
if shoppingList.isEmpty{
    print("the shopping list is empty")
}else{
    print("the shopping list is not empty")
}
//3.1 添加新的数据
shoppingList.append("jack")
print("add new items after array is \(shoppingList)")
//3.2 除此之外，使用加法赋值运算符（+=）也可以直接在数组后面添加一个或多个拥有相同类型的数据项：
shoppingList += ["baking powder"]
shoppingList += ["chocolate spread","cheese","butter"]
print(shoppingList)
//3.3 可以直接使用下标语法来获取数组中的数据项，把我们需要的数据项的索引值放在直接放在数组名称的方括号中：
var firstItem = shoppingList[0]
print("the first item is \(firstItem)")
//3.4 使用下标修改某个索引值
shoppingList[0] = "brance"
//还可以利用下标来一次改变一系列数据值，即使新数据和原有数据的数量是不一样的。下面的例子把"Chocolate Spread"，"Cheese"，和"Butter"替换为"Bananas"和 "Apples"：

shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 现在有6项
print(shoppingList)
//3.5 调用数组的insert(_:atIndex:)方法来在某个具体索引值之前添加数据项：
shoppingList.insert("maple", atIndex: 0)
print("---------------\(shoppingList)")
//3.6 类似的我们可以使用removeAtIndex(_:)方法来移除数组中的某一项。这个方法把数组在特定索引值中存储的数据项移除并且返回这个被移除的数据项（我们不需要的时候就可以无视它）：
let maple = shoppingList.removeAtIndex(0)
print(maple)
/**
*注意：
*/
//如果我们试着对索引越界的数据进行检索或者设置新值的操作，会引发一个运行期错误。我们可以使用索引值和数组的count属性进行比较来在使用某个索引之前先检验是否有效。除了当count等于 0 时（说明这是个空数组），最大索引值一直是count - 1，因为数组都是零起索引
//数据项被移除后数组中的空出项会被自动填补
//3.7 移除数组的最后一项
let lastItem = shoppingList.removeLast()
print("last item is \(lastItem)")

//4. 数组的遍历 
//4.1 for in
for item in shoppingList {
    print("item is \(item)")
}
//4.2 枚举遍历 enumerate()
for(index,value) in shoppingList.enumerate(){
    print("item\(String(index+1)): \(value)")
}

/***********集合（Sets）**************/
/*集合(Set)用来存储相同类型并且没有确定顺序的值。当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组
集合类型的哈希值

一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是Int类型的，相等的对象哈希值必须相同，比如a==b,因此必须a.hashValue == b.hashValue。

Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
注意：
你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型符合 Swift 标准库中的Hashable协议。符合Hashable协议的类型需要提供一个类型为Int的可读属性hashValue。由类型的hashValue属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。

因为Hashable协议符合Equatable协议，所以符合该协议的类型也必须提供一个"是否相等"运算符(==)的实现。这个Equatable协议要求任何符合==实现的实例间都是一种相等的关系。也就是说，对于a,b,c三个值来说，==的实现必须满足下面三种情况：

a == a(自反性)
a == b意味着b == a(对称性)
a == b && b == c意味着a == c(传递性)
*/
//1. 集合类型语法

//Swift 中的Set类型被写为Set<Element>，这里的Element表示Set中允许存储的类型，和数组不同的是，集合没有等价的简化形式
// 1.1创建和构造一个空的集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
// letters 现在含有1个 Character 类型的值
letters = []
// letters 现在是一个空的 Set, 但是它依然是 Set<Character> 类型
//1.2 使用数组字面量创建集合 你可以使用数组字面量来构造集合，并且可以使用简化形式写一个或者多个值作为集合元素。
var facoriteGeners:Set<String> = ["rock","edwin","jack","abby"]  //这个favoriteGenres变量被声明为“一个String值的集合”，写为Set<String>。由于这个特定的集合含有指定String类型的值，所以它只允许存储String类型值。
print(facoriteGeners)

//一个Set类型不能从数组字面量中被单独推断出来，因此Set类型必须显式声明。然而，由于 Swift 的类型推断功能，如果你想使用一个数组字面量构造一个Set并且该数组字面量中的所有元素类型相同，那么你无须写出Set的具体类型。favoriteGenres的构造形式可以采用简化的方式代替：

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
//由于数组字面量中的所有元素类型相同，Swift 可以推断出Set<String>作为favoriteGenres变量的正确类型。
//2. 访问和修改一个集合
//2.1 为了找出一个Set中元素的数量，可以使用其只读属性count：
print("I have \(favoriteGenres.count) favorite music genres")
//2.2  使用布尔属性isEmpty作为一个缩写形式去检查count属性是否为0：
if facoriteGeners.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
//2.3 添加一个新的元素
favoriteGenres.insert("Jazz")
print(favoriteGenres)
//2.4 你可以通过调用Set的remove(_:)方法去删除一个元素，如果该值是该Set的一个元素则删除该元素并且返回被删除的元素值，否则如果该Set不包含该值，则返回nil。另外，Set中的所有元素可以通过它的removeAll()方法删除。
if let removeGenre = favoriteGenres.remove("Rock") {
    print("\(removeGenre)? I'm over it.")
}else{
    print("I never much cared for that.")
}

//2.5 使用contains(_:)方法去检查Set中是否包含一个特定的值：
if favoriteGenres.contains("Jazz") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

// 3 遍历一个集合
// 3.1 for in
for genre in favoriteGenres {
    print("\(genre)")
}
//3.2 Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sort()方法，它将根据提供的序列返回一个有序集合.
for genre in facoriteGeners.sort() {
    print( "sort items \(genre)")
}

//4 集合操作
/*你可以高效地完成Set的一些基本操作，比如把两个集合组合到一起，判断两个集合共有元素，或者判断两个集合是否全包含，部分包含或者不相交
使用intersect(_:)方法根据两个集合中都包含的值创建的一个新的集合。
使用exclusiveOr(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
使用union(_:)方法根据两个集合的值创建一个新的集合。
使用subtract(_:)方法根据不在该集合中的值创建一个新的集合。
*/

let addDigits:Set = [1,3,5,7,9]
let evenDigits:Set = [0,2,4,6,8]
let singleDigitPrimeNumbers:Set = [2,3,5,7]
var newSet =  addDigits.union(evenDigits).sort()
print("first \(newSet)")
newSet = addDigits.intersect(evenDigits).sort()
print("second \(newSet)")
newSet = addDigits.subtract(singleDigitPrimeNumbers).sort()
print("thirld \(newSet)")
// [1, 9]
newSet = addDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
print("four \(newSet)")

//集合成员关系和相等
/*下面的插图描述了三个集合-a,b和c,以及通过重叠区域表述集合间共享的元素。集合a是集合b的父集合，因为a包含了b中所有的元素，相反的，集合b是集合a的子集合，因为属于b的元素也被a包含。集合b和集合c彼此不关联，因为它们之间没有共同的元素。
使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
使用isSubsetOf(_:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
使用isSupersetOf(_:)方法来判断一个集合中包含另一个集合中所有的值。
使用isStrictSubsetOf(_:)或者isStrictSupersetOf(_:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
使用isDisjointWith(_:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
*/
let houseAnimals:Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
var isTrue = houseAnimals.isSubsetOf(farmAnimals)
// true
isTrue = farmAnimals.isSupersetOf(houseAnimals)
// true
isTrue = farmAnimals.isDisjointWith(cityAnimals)
// true


/*****************字典********************/
/**
*  字典是一种存储多个相同类型的值的容器。每个值（value）都关联唯一的键（key），键作为字典中的这个值数据的标识符。和数组中的数据项不同，字典中的数据项并没有具体顺序。我们在需要通过标识符（键）访问数据的时候使用字典，这种方法很大程度上和我们在现实世界中使用字典查字义的方法一样。
Swift 的字典使用Dictionary<Key, Value>定义，其中Key是字典中键的数据类型，Value是字典中对应于这些键所存储值的数据类型。
*/

//1.创建字典
var namesOfIntegers = [Int:String]() //空字典
namesOfIntegers[16] = "sixteen" //包含一个键值对
//如果上下文已经提供了类型信息，我们可以使用空字典字面量来创建一个空字典，记作[:]（中括号中放一个冒号）：
namesOfIntegers = [:]  //空字典
//2. 用字典字面量创建字典
//我们可以使用字典字面量来构造字典，这和我们刚才介绍过的数组字面量拥有相似语法。字典字面量是一种将一个或多个键值对写作Dictionary集合的快捷途径。
//
//一个键值对是一个key和一个value的结合体。在字典字面量中，每一个键值对的键和值都由冒号分割。这些键值对构成一个列表，其中这些键值对由方括号包含、由逗号分割：
//
//[key 1: value 1, key 2: value 2, key 3: value 3]
var airports:[String:String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//和数组一样，我们在用字典字面量构造字典时，如果它的键和值都有各自一致的类型，那么就不必写出字典的类型。 airports字典也可以用这种简短方式定义：
var airport = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//3. 访问和修改字典

//我们可以通过字典的方法和属性来访问和修改字典，或者通过使用下标语法。
//和数组一样，我们可以通过字典的只读属性count来获取某个字典的数据项数量：
print("The dictionary of airports contains \(airports.count) items.")

//3.1 使用bool值来检查是否为空
if airports.isEmpty{
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
//3.2 使用下标语法来添加新的数据项
airports["HXL"] = "Abby"
//作为另一种下标方法，字典的updateValue(_:forKey:)方法可以设置或者更新特定键对应的值。就像上面所示的下标示例，updateValue(_:forKey:)方法在这个键不存在对应值的时候会设置新值或者在存在时更新已存在的值。和上面的下标方法不同的，updateValue(_:forKey:)这个方法返回更新值之前的原值。这样使得我们可以检查更新是否成功。
if let oldValue = airports.updateValue("xiaowei", forKey: "HXL"){
    print("the old value for hxl was \(oldValue)")
}

//3.3 我们也可以使用下标语法来在字典中检索特定键对应的值。因为有可能请求的键没有对应的值存在，字典的下标访问会返回对应值的类型的可选值。如果这个字典包含请求键所对应的值，下标会返回一个包含这个存在值的可选值，否则将返回nil：

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
// 打印 "The name of the airport is Dublin Airport."

//3.4 我们还可以使用下标语法来通过给某个键的对应值赋值为nil来从字典里移除一个键值对：
airports["APL"] = "apple internation"
airports["APL"] = nil
//3.5 removeValueForKey(_:)方法也可以用来在字典中移除键值对。这个方法在键值对存在的情况下会移除该键值对并且返回被移除的值或者在没有值的情况下返回nil：
if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//4 字典遍历
// 4.1 for in 
for(airportCode,airportName) in airports {
    print("\(airportCode): \(airportName)")
}
//4.2 通过访问keys或者values属性，我们也可以遍历字典的键或者值
for airportCode in airports.keys.sort(){
    print("airport code:\(airportCode)")
}

for airportName in airports.values.sort(){
    print("airport name :\(airportName)")
}

// 4.3 如果我们只是需要使用某个字典的键集合或者值集合来作为某个接受Array实例的 API 的参数，可以直接使用keys或者values属性构造一个新数组：
let airportCodes = [String](airports.keys)
print("airportcode array \(airportCodes)")
let airportName = [String](airports.values)
print("airport name \(airportName)")
/*Swift 的字典类型是无序集合类型。为了以特定的顺序遍历字典的键或值，可以对字典的keys或values属性使用sort()方法。*/