//
//  EOINCleanUpString.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 06/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa


public class EOINCleanupString: NSObject{
    
    func cleanStringForString(className:NSString?)->String?{
        var result = className
        var classNameStr:NSString! = className
        
        switch(classNameStr){
        case "NSTaggedPointerString":
            result = "NSString"
            
        default:
            result = className
            
        }
        return result
    }
    
}