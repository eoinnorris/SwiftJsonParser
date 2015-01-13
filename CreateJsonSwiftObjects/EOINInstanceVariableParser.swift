//
//  EOINInstanceVariableParser.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 06/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

public class myObject:NSObject {
    
    override init(){
        super.init()
    }
    
    init(jsonDictionary:NSDictionary) {
        super.init()

    }
}


public class JSONParser{
    
    
    func convertNSArrayToArrayOfType<T>(inArray:NSArray)->[T]{
        var array = [T]()
        for potentialStr in inArray{
            if let str = potentialStr as? T{
                array.append(str)
            }
        }
        return array
    }
    
     func convertNSArrayOfDictionariesToArraysOfObjects(inArray:NSArray)->[myObject]{
        var objectArray:[myObject] = []
        for probableDict in inArray{
            if let dict: NSDictionary = probableDict as? NSDictionary{
                var thisFriend = myObject(jsonDictionary: dict)
                objectArray.append(thisFriend)
            }
        }
        return objectArray
    }
    
}


class EOINInstanceVariableParser: EoinJSONSuper {
    
    let initCreator:EOINInitMethodCreator = EOINInitMethodCreator()
    
    func isString(value:AnyObject, keyStr:String)->(name:String?,isString:Bool){
        var result:String? = nil
        var resultBool:Bool = false
        
        let possibleValueStr:NSString? = value as? NSString
        if let valueStr = possibleValueStr{
            result = "\tvar " + keyStr + ":  String?\n"
            resultBool = true
        }
        
        return (result,resultBool)
    }
    
    func nsNumber2Type(number:NSNumber)->String{
        var result:String = ""
        let charStr:UnsafePointer<Int8>  = number.objCType
        let typeStrPossible = String(UTF8String: charStr);
        if let typeStr = typeStrPossible{
            switch (typeStr){
                case "i":
                    result = "Int?"
                case "f":
                    result = "Float?"
                case "c":
                    result = "Bool?"
                case "d":
                    result = "Double?"
                default:
                    result = "Int?"
            }
        }
        return result
    }
    
    func isNumber(value:AnyObject, keyStr:String)->(name:String?,isNumber:Bool){
        var result:String? = nil
        var resultBool:Bool = false
        
        let possibleValueInt:NSNumber? = value as? NSNumber
        if let valueInt = possibleValueInt{
            let realType = nsNumber2Type(valueInt)
            result = "\tvar " + keyStr + ":  \(realType)\n"
            resultBool = true
        }
        
        return (result,resultBool)
    }
    

    
    func isArray(value:AnyObject, keyStr:String)->(name:String?,isArray:Bool,elementType:EOINParamaterType){
        var result:String? = nil
        var resultBool:Bool = false
        var (varStr,type) = ("",EOINParamaterType())
        let possibleValueArray:NSArray? = value as? NSArray
        if let valueArray = possibleValueArray{
            var count = valueArray.count
            var arrayType = ""
            if count>0 {
                var item:AnyObject = valueArray[0]
                (varStr,type) = getInstanceVariableType(item, keyStr: keyStr)
                arrayType = varStr
                arrayType = cleanUpTypeForParamaterization(arrayType)
            }
            if (arrayType.isEmpty==false){
                result = "\tvar " + keyStr + ":  Array<" + arrayType + ">?\n"
            } else {
                result = "\tvar " + keyStr + ":  Array?\n"
            }
            resultBool = true
        }
        
        return (result,resultBool,type)
    }
    
    let prefix = "MyClass"
    
    func getObjectName(value:AnyObject, keyStr:String)->(name:String?,isDict:Bool){
        var result:String? = nil
        var resultBool:Bool = false
        var name = keyStr
   
        //todo move into utility
        name = name.firstCharacterUpperCase()
        
        if name.hasSuffix("s"){
            name = name.substringToIndex(name.endIndex.predecessor()) // "Dolphi"
        }
        

        var typeStr = "\(prefix)\(name)"

        // JSON Objects are dicts
        let possibleValueDictionary:NSDictionary? = value as? NSDictionary
        if let valueDict = possibleValueDictionary{

            resultBool = true
            result = "\tvar " + name + ":  \(typeStr)\n"
        }
        
        return (result,resultBool)

    }
    
    typealias instanceResultType = (name:String, type:EOINParamaterType)
    

    func getInstanceVariableType(value:AnyObject, keyStr:String)->(instanceResultType) {
        
        var paramType = EOINParamaterType()
        var elementType = EOINParamaterType()
        
        var (valueStr, isValidStr) = isString(value, keyStr: keyStr)
        if isValidStr{
            paramType.paramaterName = keyStr;
            paramType.paramaterTypeStr = cleanUpTypeForParamaterization(valueStr!)
            paramType.paramType = ParamamterType.Simple
            return (valueStr!,paramType)
        }
        
        (valueStr, isValidStr) = isNumber(value, keyStr: keyStr)
        if isValidStr{
            paramType.paramaterName = keyStr;
            paramType.paramaterTypeStr = cleanUpTypeForParamaterization(valueStr!);
            paramType.paramType = ParamamterType.Simple
            return (valueStr!,paramType)
        }
        

        (valueStr, isValidStr,elementType) = isArray(value, keyStr: keyStr)
        if isValidStr{
            paramType.paramaterName = keyStr;
            paramType.paramaterTypeStr = cleanUpTypeForParamaterization(valueStr!);
            switch(elementType.paramType){
                case .Simple:
                    paramType.paramType = ParamamterType.ArrayOfInBuilts
                case .Object:
                    paramType.paramType = ParamamterType.ArrayOfCustomItems
                default:
                    paramType.paramType = ParamamterType.ArrayOfInBuilts
            }
            return (valueStr!,paramType)
        }
        
        (valueStr, isValidStr) = getObjectName(value, keyStr: keyStr)
        if isValidStr{
            paramType.paramaterName = keyStr;
            paramType.paramaterTypeStr = cleanUpTypeForParamaterization(valueStr!);
            paramType.paramType = ParamamterType.Object
            return (valueStr!,paramType)
        }
        
        return ("\n",paramType)
    }
}
