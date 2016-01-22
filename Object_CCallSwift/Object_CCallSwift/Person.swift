//
//  Person.swift
//  Object_CCallSwift
//
//  Created by baijiawei on 15/5/17.
//  Copyright (c) 2015年 GarveyCalvin. All rights reserved.
//

import Cocoa

@objc class Person: NSObject {
    var name: String!
    
    func print() {
        Swift.print("person name is \(name)")
    }
}
