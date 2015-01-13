//
//  EOINProtocolsGenerator.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 09/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

class EOINProtocolsGenerator: EoinJSONSuper {
    
    let kSwiftDefaultProtocolTemplate = "TEMPLATE_SWIFT_PROTOCOLS"
    
    func generateProtocols()->String{
        var result = ""
        let possiblePath = NSBundle.mainBundle().pathForResource(kSwiftDefaultProtocolTemplate, ofType: "txt")
        if let path = possiblePath{
            var protocolStrPoss = NSString(contentsOfFile:path, encoding: NSUTF8StringEncoding, error: nil)
            if let protocolStr = protocolStrPoss{
                result += newLine(2)
                result += protocolStr
                result += newLine(2)
            }
            
        }
        return result
    }
}
