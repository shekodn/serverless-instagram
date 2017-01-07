////
////  User.swift
////  Instagram
////
////  Created by Sergio Díaz Navarro on 1/7/17.
////  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
////
//
//import Foundation
//
//class User : AWSDynamoDBObjectModel, AWSDynamoDBModeling {
//    
//    var id  : String = ""
//    var name   : String = ""
//    
//    override init!() {
//        super.init()
//    }
//    
//     init(dictionary dictionaryValue: [NSObject : AnyObject]!, error: ()) throws {
//        super.init()
//        id = dictionaryValue["id"] as! String
//        
//        
//            name = dictionaryValue["name"] as! String
//    }
//    
//    
//    required init!(coder: NSCoder!) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    class func dynamoDBTableName() -> String {
//        return "Users"
//    }
//    
//    class func hashKeyAttribute() -> String {
//        return "id"
//    }
//}
