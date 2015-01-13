//
//  EoinJSONSuper.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 08/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

public class EoinJSONSuper {
    let newLineCreator = EOINNewLineGenerator()
    
    func tab(tabs:Int)->String{
        return newLineCreator.generateDefaultTabs(tabs)
    }
    
    func tabNL(tabs:Int)->String{
        return newLineCreator.generateNewLineAndTab(tabs)
    }

    func newLine(lines:Int)->String{
        return newLineCreator.generateNewLines(lines)
    }
    
    func cleanUpArrayType(arrayType:String)->String{
        var components = arrayType.componentsSeparatedByString("<");
        var result:String = arrayType
        if (components.count == 2){
            result = components[1];
            result = result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if result.hasSuffix(">"){
                result = result.substringToIndex(result.endIndex.predecessor())
            }
        }
        return result
    }
    
    func cleanUpTypeForParamaterization(arrayType:String)->String{
        var components = arrayType.componentsSeparatedByString(":");
        var result:String = arrayType
        if (components.count == 2){
            result = components[1];
            result = result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if result.hasSuffix("?"){
                result = result.substringToIndex(result.endIndex.predecessor())
            }
        }
        return result
    }
    
    func cleanUpType(arrayType:String)->String{
        var components = arrayType.componentsSeparatedByString(":");
        var result:String = arrayType
        if (components.count == 2){
            result = components[1];
            result = result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
        }
        return result
    }
    
}
