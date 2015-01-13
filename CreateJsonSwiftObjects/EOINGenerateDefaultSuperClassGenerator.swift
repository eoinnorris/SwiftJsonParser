//
//  EOINGenerateDefaultSuperClass.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 08/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa


class EOINGenerateDefaultSuperClassGenerator: EoinJSONSuper {

    let defaultName = "JSONObject"
    let kSwiftDefaultSuperTemplate = "TEMPLATE_SWIFT_SUPERCLASS"
    
    func generateSuperClass()->(fullClass:String,name:String){
        var result = ""
        let possiblePath = NSBundle.mainBundle().pathForResource(kSwiftDefaultSuperTemplate, ofType: "txt")
        if let path = possiblePath{
            var protocolStrPoss = NSString(contentsOfFile:path, encoding: NSUTF8StringEncoding, error: nil)
            if let protocolStr = protocolStrPoss{
                result += newLine(2)
                result += protocolStr
                result += newLine(2)
            }
            
        }
        return (result,defaultName)
    }
    
}
