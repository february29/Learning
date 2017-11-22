//
//  UserModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/2.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel : HandyJSON,NSCoding{
    required init() {
        
    }
    
    
    var deleted : Int!
    var id : Int!
    var lastLoginTime : TimeInterval!
    var loginCount : Int!
    var loginName : String!
    var mobile : String!
    var password : String!
    var userType : Int!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        deleted = dictionary["deleted"] as? Int
        id = dictionary["id"] as? Int
        lastLoginTime = dictionary["lastLoginTime"] as? TimeInterval
        loginCount = dictionary["loginCount"] as? Int
        loginName = dictionary["loginName"] as? String
        mobile = dictionary["mobile"] as? String
        password = dictionary["password"] as? String
        userType = dictionary["userType"] as? Int
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if deleted != nil{
            dictionary["deleted"] = deleted
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastLoginTime != nil{
            dictionary["lastLoginTime"] = lastLoginTime
        }
        if loginCount != nil{
            dictionary["loginCount"] = loginCount
        }
        if loginName != nil{
            dictionary["loginName"] = loginName
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if password != nil{
            dictionary["password"] = password
        }
        if userType != nil{
            dictionary["userType"] = userType
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        deleted = aDecoder.decodeObject(forKey: "deleted") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        lastLoginTime = aDecoder.decodeObject(forKey: "lastLoginTime") as? TimeInterval
        loginCount = aDecoder.decodeObject(forKey: "loginCount") as? Int
        loginName = aDecoder.decodeObject(forKey: "loginName") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        userType = aDecoder.decodeObject(forKey: "userType") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if deleted != nil{
            aCoder.encode(deleted, forKey: "deleted")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastLoginTime != nil{
            aCoder.encode(lastLoginTime, forKey: "lastLoginTime")
        }
        if loginCount != nil{
            aCoder.encode(loginCount, forKey: "loginCount")
        }
        if loginName != nil{
            aCoder.encode(loginName, forKey: "loginName")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if userType != nil{
            aCoder.encode(userType, forKey: "userType")
        }
        
    }
   
    
    
}
