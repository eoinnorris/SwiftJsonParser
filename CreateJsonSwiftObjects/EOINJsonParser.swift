//
//  EOINJsonParser.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 05/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

let kDefaultJSON = "JSONTEST"
let kDefaultJSONSuperClass = "JSONObject"

public class EOINJsonParser: NSObject {

    var data = NSMutableData()
    let kDefaultEntryClassName = "MyClass"
    
    let superClassGenerator = EOINGenerateDefaultSuperClassGenerator()
    let importsGenerator = EoinImportGenerator()
    let protocolsGenerator = EOINProtocolsGenerator()

    
    func startConnection(){
        
        let possiblePath = NSBundle.mainBundle().pathForResource(kDefaultJSON, ofType: "txt")
        if let path = possiblePath{
            var jsonString = NSString(contentsOfFile:path, encoding: NSUTF8StringEncoding, error: nil)
            if let jsonStr = jsonString{
                let jsonData:NSData? = jsonStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                if let data = jsonData{
                    self.data = NSMutableData(data: data)
                    connectionDidFinishLoading(nil)
                }
            }
        }

    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func buttonAction(sender: NSButton!){
        startConnection()
    }
    
    let stack = EOINClassStack()

    
    func preprocessClassStack(JSONDictionary:NSDictionary,superClass:String)->String{
        var classPreprocessor = EoinClassPreprocessor()
        var resultStr = classPreprocessor.generateAllClassStrings(JSONDictionary,
            stack:stack,
            superClassName:superClass,
            isTopLevel:true)
        return resultStr
    }
    
    func generateSwiftCode(jsonDictionary:NSDictionary){
        var resultStr = ""
        let importStr = importsGenerator.generateImports()
        let protocolStr = protocolsGenerator.generateProtocols()
        let (superClassStr,superClassName) = superClassGenerator.generateSuperClass()
        let className = kDefaultEntryClassName
        var classesStr = preprocessClassStack(jsonDictionary,superClass:kDefaultJSONSuperClass)
        
        resultStr += importStr
        resultStr += protocolStr
        resultStr += superClassStr
        resultStr += classesStr
        
        println(resultStr)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var jsonError: NSError?
   
        var jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError)
        
        if jsonError != nil{
            let jsonErrorUnwrapped = jsonError!
            NSLog("error is %@", jsonErrorUnwrapped.localizedDescription);
        } else {
            // to do -- do this properly
            var jsonResultArray = jsonResult as NSArray
            var jsonResultObject: AnyObject = jsonResultArray[0]
            var jsonResultDictionary = jsonResultObject as NSDictionary
            generateSwiftCode(jsonResultDictionary)
        }
    }
    
}



