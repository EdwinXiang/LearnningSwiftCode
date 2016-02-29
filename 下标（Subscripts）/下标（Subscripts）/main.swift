//
//  main.swift
//  下标（Subscripts）
//
//  Created by Edwin on 16/2/26.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

import Foundation

/*****************************下标（Subscripts）*****************************/
/**
1、下标语法
2、下标用法
3、下标选项
下标 （subscripts）可以定义在类（class）、结构体（structure）和枚举（enumeration）中，是访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式。可以使用下标的索引，设置和获取值，而不需要再调用对应的存取方法。举例来说，用下标访问一个Array实例中的元素可以写作someArray[index]，访问Dictionary实例中的元素可以写作someDictionary[key]。
一个类型可以定义多个下标，通过不同索引类型进行重载。下标不限于一维，你可以定义具有多个入参的下标满足自定义类型的需求。
*/
//1、下标语法
/**
*  下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于实例方法语法和计算型属性语法的混合。与定义实例方法类似，定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
*/

struct TimesTable {
    let multiplier:Int
        subscript(index:Int) ->Int {
            return multiplier * index
    }
}

//下标用法
//下标的确切含义取决于使用场景。下标通常作为访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式。你可以针对自己特定的类或结构体的功能来自由地以最恰当的方式实现下标。
var numberOfLegs = ["spider":8,"ant":6,"cat":4]
numberOfLegs["bird"] = 2
print(numberOfLegs)

let times = TimesTable(multiplier: 5)
let some = times[2] //使用下班获取
print(some)

//下标选项
//下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
//一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载


/**
*  Matrix提供了一个接受两个入参的构造方法，入参分别是rows和columns，创建了一个足够容纳rows * columns个Double类型的值的数组。通过传入数组长度和初始值0.0到数组的构造器，将矩阵中每个位置的值初始化为0.0。关于数组的这种构造方法请参考创建一个空数组。
*/
struct Matrix {
    let rows:Int,columns:Int
    var grid:[Double]
    init(rows:Int,columns:Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count:rows * columns,repeatedValue:0.0)
    }
    func indexIsValidForRow(row:Int,column:Int) -> Bool { // 设置一个断言是否越界
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row:Int,column:Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column),"idnex out of range")//断言
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column),"index out of range")
            grid[(row * columns) + column] = newValue
        }
        
    }
}
var matrix = Matrix(rows: 3, columns: 3) // 定义一个9*9的矩阵
print(matrix)
matrix[0,1] = 1.5 //set
matrix[2,2] = 5
print(matrix)
let someValue = matrix[2,2] //get
print(someValue)