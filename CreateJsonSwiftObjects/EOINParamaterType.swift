//
//  EOINParamaterType.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 07/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

public enum ParamamterType: Int {
    case Simple
    case Object
    case ArrayOfInBuilts
    case ArrayOfCustomItems

}

public class EOINParamaterType: EoinJSONSuper {
    
    
    var paramaterName:String = ""
    var objectName:String?
    var paramaterTypeStr:String = ""
    var paramType:ParamamterType = ParamamterType.Simple
    var array:Array<EOINParamaterType>?
    
    
    override init(){
        super.init()
    }
    
    init(paramaterName:String,paramaterTypeStr:String,paramType:ParamamterType){
        super.init()
        self.paramaterName = paramaterName
        self.paramaterTypeStr = paramaterTypeStr
        self.paramType = paramType
    }
    
    // to do make non-optional
    func generateSimpleAssignmentLine()->String{
        return "self.\(paramaterName) = jsonDictionary[\"\(paramaterName)\"] as \(paramaterTypeStr)!"
    }
    
    func generateObjectAssignmentLine()->String{
        
        let camelCaseParamName = paramaterName.firstCharacterUpperCase();
        let localVar = "this\(camelCaseParamName)"
        let line1 = "let possibleDict:NSDictionary? = dict[\"\(paramaterName)\"] as? NSDictionary"
        let line2 = " if let dict = possibleDict{"
        let line3 = "let \(localVar):\(paramaterTypeStr) =  \(paramaterTypeStr)(jsonDictionary: dict)"
        let line4 = "self.\(paramaterName) = \(localVar)"
        let line5 = "}"

        return tabNL(1) + line1 + tabNL(1) + line2 + tabNL(2) + line3 + tabNL(2)+line4 + tabNL(1)+line5 + newLine(1)
        
    }
    
    func generateObjectArrayAssignmentLine()->String{
        let oldArrayStr = "\(paramaterName)PossibleNSArray"
        let arrayType = cleanUpArrayType(paramaterTypeStr)
        var lineStr = [String]()
        
        lineStr.append(tabNL(1));
        lineStr.append("var \(oldArrayStr): AnyObject? = jsonDictionary[\"\(paramaterName)\"]");
        lineStr.append(tabNL(1));
        lineStr.append("if let thisArray = \(oldArrayStr) as? NSArray{");
        lineStr.append(tabNL(2));
        lineStr.append("var array:[\(arrayType)] = convertNSArrayToArrayOfObjectType(thisArray)");
        lineStr.append(tabNL(1));
        lineStr.append("}");
        lineStr.append(newLine(1));
        
        var result = ""
        
        for line in lineStr{
            result += line
        }
        
        return result
    }
    
    
    func generateSimpleArrayAssignmentLine()->String{
        let oldArrayStr = "\(paramaterName)PossibleNSArray"
        let arrayType = cleanUpArrayType(paramaterTypeStr)
        var lineStr = [String]()
        
        lineStr.append(tabNL(1));
        lineStr.append("var \(oldArrayStr): AnyObject? = jsonDictionary[\"\(paramaterName)\"]");
        lineStr.append(tabNL(1));
        lineStr.append("if let thisArray = \(oldArrayStr) as? NSArray{");
        lineStr.append(tabNL(2));
        lineStr.append("var array:[\(arrayType)] = convertNSArrayToArrayOfType(thisArray)");
        lineStr.append(tabNL(1));
        lineStr.append("}");
        lineStr.append(newLine(1));
        
        var result = ""
        
        for line in lineStr{
            result += line
        }

        return result
    }

    func generateAssignmentLine()->String{
        var result = ""
        switch paramType{
            case .Simple:
                result = generateSimpleAssignmentLine()
            case .Object:
                result = generateObjectAssignmentLine()
            case .ArrayOfInBuilts:
                result = generateSimpleArrayAssignmentLine()
            case .ArrayOfCustomItems:
                result = generateObjectArrayAssignmentLine()

            default:
                result = ""
        }
        
        return result
    }
    
}
