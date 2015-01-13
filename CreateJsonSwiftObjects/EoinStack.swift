//
//  EoinClassStack.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 13/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

struct EoinStack<T> {
    
    var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
}