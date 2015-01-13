//
//  EoinClassGenerator.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 13/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa


let kDefaultTopLevelClassName = "MyClass"

public class EoinClassDescription{
    
    var className:String
    var superClassName:String
    var dictionary:NSDictionary
    
    init(className:String, superClassName:String, dictionary:NSDictionary){
        self.className = className
        self.superClassName = superClassName
        self.dictionary = dictionary
    }
    
  
}

public class EoinClassPreprocessor: NSObject {
    
    let defaultName = kDefaultTopLevelClassName
    var defaultNumber = 0
    let instanceParser = EOINInstanceVariableParser()
    let objectParser = EOINJSONParserObject()
    
    
    typealias objectType = (name:String?,dict:NSDictionary?)
    
    
    func getObjectOrGetObjectFromArray(value:AnyObject, keyStr:String)->objectType{
        
        if let array:NSArray = value as? NSArray{
            if (array.count > 0){
                var possibleDict:AnyObject = array[0]
                if let possibleValueDictionary:NSDictionary = possibleDict as? NSDictionary{
                    return getObject(possibleValueDictionary, keyStr:keyStr)
                }
            }
        }
        
        return getObject(value,keyStr:keyStr);
        
    }
    
    func getObject(value:AnyObject, keyStr:String)->objectType{
        var result:String? = nil
        var resultBool:Bool = false
        var name = keyStr
        
        //todo move into utility
        name = name.firstCharacterUpperCase()
        
        if name.hasSuffix("s"){
            name = name.substringToIndex(name.endIndex.predecessor()) // "Dolphi"
        }
        
        var generatedName = "MyClass\(name)"
        
        // JSON Objects are dicts
        let possibleValueDictionary:NSDictionary? = value as? NSDictionary
        let valueDict = possibleValueDictionary
        
        return (generatedName,valueDict)
        
    }
    
    public func generateAllClassStrings(jsonDict:NSDictionary,
        stack:EOINClassStack,
        superClassName:String,
        isTopLevel:Bool)->String{
            
            let objectParser = EOINJSONParserObject()

            
            var stack = generateClassNameStackFromDictionary(jsonDict,
                stack: stack,
                superClassName: superClassName,
                isTopLevel: isTopLevel)
            var items = stack.items.reverse()
            var resultStr = ""
            for classItem:EoinClassDescription in items{
                
                  let mainClassStr = objectParser.generateClassStrFromDictionary(classItem.dictionary, className: classItem.className,superClassName:classItem.superClassName)
                    resultStr += mainClassStr
            }
            
            
        return resultStr
    }
    
    
    internal func generateClassNameStackFromDictionary(jsonDict:NSDictionary,
        stack:EOINClassStack,
        superClassName:String,
        isTopLevel:Bool)->EOINClassStack{
        let allKeys = jsonDict.allKeys
        var stack = stack // make this mutable
            
        if (isTopLevel){
            var topClassDescriptionVar = EoinClassDescription(className: kDefaultTopLevelClassName,
                superClassName: superClassName,
                dictionary: jsonDict)
            stack.push(topClassDescriptionVar)
        }
        
        
        // generate paramaters for all keys in the dictionary
        for key in allKeys{
            let keyStr = key as String
            var possibleValue: AnyObject? = jsonDict[keyStr];
            
            if let value: AnyObject = possibleValue{
                var objectType = getObjectOrGetObjectFromArray(value, keyStr: keyStr);
                if let realDictionary = objectType.dict {
                    if let realClassName = objectType.name{
                        var classDescriptionVar = EoinClassDescription(className: realClassName,
                            superClassName: superClassName,
                            dictionary: realDictionary)
                        stack.push(classDescriptionVar)
                        stack = generateClassNameStackFromDictionary(realDictionary,
                            stack: stack,
                            superClassName:superClassName,
                            isTopLevel:false)
                        
                    }
                }
            }
        }
        return stack
    }
    
    func generateTopClassFromArray(jsonDict:NSArray,className:String,superClassName:String)-> String{
        var result = ""
        return result
    }
    
    
}
