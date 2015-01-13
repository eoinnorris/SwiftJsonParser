import Cocoa

protocol JSONDictionaryConstructible {
    init(jsonDictionary:NSDictionary)
}


public class JSONObject:JSONDictionaryConstructible{
    
    required public init(jsonDictionary:NSDictionary) {
    }
    
    public func convertNSArrayToArrayOfType<T>(inArray:NSArray)->[T]{
        var array = [T]()
        for potentialStr in inArray{
            if let str = potentialStr as? T{
                array.append(str)
            }
        }
        return array
    }
    
    internal func convertNSArrayToArrayOfObjectType<T : JSONDictionaryConstructible>(inArray:NSArray)->[T]{
        var itemArray:[T] = []
        for probableDict in inArray{
            if let dict: NSDictionary = probableDict as? NSDictionary{
                var thisItem =  T(jsonDictionary: dict)
                itemArray.append(thisItem)
            }
        }
        return  itemArray
        
    }
    
}


public class MyClassFriend:JSONObject{
    
    
    required public init(jsonDictionary: NSDictionary) {
        super.init(jsonDictionary:jsonDictionary)
        //...
    }
    
}

class MyClass: JSONObject {
    
    var guid:  String?
    var company:  String?
    var tags:  Array<String>?
    var index:  Int?
    var picture:  String?
    var friends:  Array<MyClassFriend>?
    var _id:  String?
    var isActive:  Bool?
    var latitude:  Double?
    var greeting:  String?
    var registered:  String?
    var favoriteFruit:  String?
    var balance:  String?
    var name:  String?
    var eyeColor:  String?
    var gender:  String?
    var email:  String?
    var longitude:  Double?
    var phone:  String?
    var about:  String?
    var age:  Int?
    var address:  String?
    
    
    
    
    required init(jsonDictionary:NSDictionary) {
        super.init(jsonDictionary: jsonDictionary)
        self.address = jsonDictionary["address"] as String!
        self.age = jsonDictionary["age"] as Int!
        self.about = jsonDictionary["about"] as String!
        self.phone = jsonDictionary["phone"] as String!
        self.longitude = jsonDictionary["longitude"] as Double!
        self.email = jsonDictionary["email"] as String!
        self.gender = jsonDictionary["gender"] as String!
        self.eyeColor = jsonDictionary["eyeColor"] as String!
        self.name = jsonDictionary["name"] as String!
        self.balance = jsonDictionary["balance"] as String!
        self.favoriteFruit = jsonDictionary["favoriteFruit"] as String!
        self.registered = jsonDictionary["registered"] as String!
        self.greeting = jsonDictionary["greeting"] as String!
        self.latitude = jsonDictionary["latitude"] as Double!
        self.isActive = jsonDictionary["isActive"] as Bool!
        self._id = jsonDictionary["_id"] as String!
        self.company = jsonDictionary["company"] as String!
        self.picture = jsonDictionary["picture"] as String!
        self.index = jsonDictionary["index"] as Int!
        self.guid = jsonDictionary["guid"] as String!
        
        
        
        // convert the array of Dictionaries to an Array<MyClassFriend>
        var friendsNSArray: AnyObject? = jsonDictionary["friends"]
        if let thisArrayReal = friendsNSArray as? NSArray{
            var array:[MyClassFriend] = convertNSArrayToArrayOfObjectType(thisArrayReal)
        }
        
        // convert the array of String to an Array<String>
        var tagsNSArray: AnyObject? = jsonDictionary["tags"]
        if let thisArrayReal = tagsNSArray as? NSArray{
            var array:[String] = convertNSArrayToArrayOfType(thisArrayReal)
        }
        
        
    }
    
}


