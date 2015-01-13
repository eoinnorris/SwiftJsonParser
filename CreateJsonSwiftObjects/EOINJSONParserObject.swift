//
//  EOINJSONParserObject.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 05/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

// to do generate random quotes

class EOINJSONParserObject: EoinJSONSuper {
    
    let cleaner = EOINCleanupString()
    let instanceParser = EOINInstanceVariableParser()
    let initsGenerator = EOINInitMethodCreator()
    let superClassGenerator = EOINGenerateDefaultSuperClassGenerator()
    

    
    func generateClassDescription(name:String, superClassName:String)->String{
        var result = ""
        var className = "class " + name + ": \(superClassName) { \n\n"
        
        return result + className;
    }
    
    func endClass()->String{
        return "}\n\n";
    }
    
    func generateStringTypeForType(object:NSString? )->String?{
        var typeCharStr:UnsafePointer<Int8> = object_getClassName(object);
        var className = NSString(UTF8String: typeCharStr)
        var result = cleaner.cleanStringForString(className)
        return result
    }
    
    
    func parseTopLevelArray(jsonArray:NSArray,className:String)-> String{
        return ""
    }
    
    func generateDefaultInit()->String{
        var result = ""
        result += newLine(2)
        result += initsGenerator.createDefaultInit()
        result += newLine(2)
        
        return result
        
    }
    
    func generateDictionaryInit()->String{
        var result = ""
        result += newLine(2)
        result += initsGenerator.createDictionaryInit()
        result += newLine(2)
        
        return result
    }
    
    func generateInits()->String{
        var result = ""
        result += generateDefaultInit()
        result += generateDictionaryInit()
        return result
    }

    func generateClassStrFromDictionary(jsonDict:NSDictionary,className:String,superClassName:String)-> String{
        var result = generateClassDescription(className,superClassName: superClassName)
        let allKeys = jsonDict.allKeys
        initsGenerator.clear()

        // generate paramaters for all keys in the dictionary
        for key in allKeys{
            let keyStr = key as String
            var possibleValue: AnyObject? = jsonDict[keyStr];
            
            if let value: AnyObject = possibleValue{
                var (varStr,paramType) = instanceParser.getInstanceVariableType(value, keyStr: keyStr);
                initsGenerator.appendParam(paramType)
                result = result + varStr
            }
        }
        result += generateInits()
        result += endClass()
        
        return result
    }

}
