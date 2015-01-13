//
//  EOINInitMethodCreator.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 07/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

public class EOINInitMethodCreator: EoinJSONSuper {

    var paramaterArray:Array<EOINParamaterType> = []
    
    override init() {
        super.init()
    }
    
    let defaultInit = "\toverride init() {\n\t\tsuper.init()\n\t}";
    let firstLine = ""
    let standardSetting = "var /(variableStr) as? /(TypeStr)"
    let objectSetting = "var /(variableStr) as? /(TypeStr).initWithDicrionary(dictiomaryStr)"
    
    func createDefaultInit()->String{
        return defaultInit
    }
    
    func clear(){
        paramaterArray.removeAll(keepCapacity: false)
    }
    
    func appendParam(param:EOINParamaterType){
        paramaterArray.append(param)
    }
    
    func orderArray(paramaterArray:Array<EOINParamaterType>)->Array<EOINParamaterType>{
        var result:Array<EOINParamaterType> = [EOINParamaterType]()
        var simpleObjects = paramaterArray.filter{(param:EOINParamaterType ) in
            param.paramType == .Simple  }
        var complexObjects = paramaterArray.filter{(param:EOINParamaterType ) in
            param.paramType == .Object  }
        var arrayOfInBuilts = paramaterArray.filter{(param:EOINParamaterType ) in
            param.paramType == .ArrayOfInBuilts  }
        var arrayOfCustoms = paramaterArray.filter{(param:EOINParamaterType ) in
            param.paramType == .ArrayOfCustomItems  }
        
        result.extend(simpleObjects)
        result.extend(complexObjects)
        result.extend(arrayOfInBuilts)
        result.extend(arrayOfCustoms)
        
        return result
    }
    
    func createDictionaryInit()->String{
        let entry = "\tinit(jsonDictionary:NSDictionary) {\n\t\tsuper.init()\n\n\t";
        var line2 = ""
        let closeBrackets = "\n\t}"
        
        paramaterArray = orderArray(paramaterArray)

        for paramaterType in paramaterArray{
            line2 += tab(1)
            line2 += paramaterType.generateAssignmentLine()
            line2 += tabNL(1)
        }
        
        var result = entry+line2+closeBrackets
        
        return result;

    }
    
    
}
