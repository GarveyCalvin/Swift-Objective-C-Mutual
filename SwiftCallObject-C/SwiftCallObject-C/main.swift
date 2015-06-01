//
//  main.swift
//  SwiftCallObject-C
//
//  Created by baijiawei on 15/5/14.
//  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
//

import Foundation

println("Hello, World!")

var person = Person() // 实例化对象
person.name = "Garvey" // 访问对象属性
person.print() // 调用对象方法

var personC = Person.personWithName("Calvin") as! Person // 调用 Person 的类方法，返回一个它的实例
personC.print() // 调用对象方法

