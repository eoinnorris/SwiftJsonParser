//
//  EoinImportGenerator.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 08/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

class EoinImportGenerator: NSObject {

    private func generateComments()->String{
        return ""
    }
    
    func generateImports()->String{
        var result = generateComments()
        var imports = "import Cocoa\n\n"
        
        result = result + imports;
        return result;
    }
    
}
