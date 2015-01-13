//
//  EOINClassPreprocessor.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 13/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

public class EOINClassStack: NSObject{

    var items = [EoinClassDescription]()
    
     func push(item: EoinClassDescription) {
        items.append(item)
    }
    
     func pop() -> EoinClassDescription {
        return items.removeLast()
    }
    
    func isEmpty()->Bool{
        return (items.count == 0)
    }
    
}
