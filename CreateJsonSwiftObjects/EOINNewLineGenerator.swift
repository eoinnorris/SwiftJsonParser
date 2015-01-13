//
//  EOINNewLineGenerator.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 07/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

let kDefaultTabs = 1
let kDefaultNewLines = 2
let kOneNewLine = 1

struct EoinJSONDefaults{
    var tabs = kDefaultTabs
    var newLines = kDefaultNewLines
    var oneLine = kOneNewLine
}



public class EOINNewLineGenerator: NSObject {
    
    
    let defaults = EoinJSONDefaults()
    
    func generateNewLines(number:Int)->String{
        var result = ""
        for index in 0..<number{
            result = result + "\n"
        }
        return result
    }
    
    func generateNewTabs(number:Int)->String{
        var result = ""
        for index in 0..<number{
            result = result + "\t"
        }
        return result
    }
    
    func generateDefaultTabs(indentBy:Int)->String{
        return generateNewTabs(defaults.tabs * indentBy)
    }
    
    func generateDefaultNewLines()->String{
        return generateNewLines(defaults.newLines)
    }
    
    func generateNewLine()->String{
        return generateNewLines(defaults.oneLine)
    }
    
    func generateNewLineAndTab(indentBy:Int)->String{
        let result =  generateNewLines(defaults.oneLine) + generateDefaultTabs(indentBy)
        return result
    }
    
    
}
