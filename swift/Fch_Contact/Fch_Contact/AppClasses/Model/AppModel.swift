//
//  AppModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/21.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import HandyJSON


class App : HandyJSON, NSCoding{
    required init() {
        
    }
    
    
    var appName : String!
    var deleted : Int!
    var expiredTime : Int!
    var forceUpdate : Int!
    var icon : String!
    var id : Int!
    var information : String!
    var iosLowestVersion : String!
    var iosUrl : String!
    var iosVersion : String!
    var lastPayingTime : Int!
    var maxValue : Int!
    var password : String!
    var qrCode : String!
    var style : String!
    var uuid : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        appName = dictionary["appName"] as? String
        deleted = dictionary["deleted"] as? Int
        expiredTime = dictionary["expiredTime"] as? Int
        forceUpdate = dictionary["forceUpdate"] as? Int
        icon = dictionary["icon"] as? String
        id = dictionary["id"] as? Int
        information = dictionary["information"] as? String
        iosLowestVersion = dictionary["iosLowestVersion"] as? String
        iosUrl = dictionary["iosUrl"] as? String
        iosVersion = dictionary["iosVersion"] as? String
        lastPayingTime = dictionary["lastPayingTime"] as? Int
        maxValue = dictionary["maxValue"] as? Int
        password = dictionary["password"] as? String
        qrCode = dictionary["qrCode"] as? String
        style = dictionary["style"] as? String
        uuid = dictionary["uuid"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appName != nil{
            dictionary["appName"] = appName
        }
        if deleted != nil{
            dictionary["deleted"] = deleted
        }
        if expiredTime != nil{
            dictionary["expiredTime"] = expiredTime
        }
        if forceUpdate != nil{
            dictionary["forceUpdate"] = forceUpdate
        }
        if icon != nil{
            dictionary["icon"] = icon
        }
        if id != nil{
            dictionary["id"] = id
        }
        if information != nil{
            dictionary["information"] = information
        }
        if iosLowestVersion != nil{
            dictionary["iosLowestVersion"] = iosLowestVersion
        }
        if iosUrl != nil{
            dictionary["iosUrl"] = iosUrl
        }
        if iosVersion != nil{
            dictionary["iosVersion"] = iosVersion
        }
        if lastPayingTime != nil{
            dictionary["lastPayingTime"] = lastPayingTime
        }
        if maxValue != nil{
            dictionary["maxValue"] = maxValue
        }
        if password != nil{
            dictionary["password"] = password
        }
        if qrCode != nil{
            dictionary["qrCode"] = qrCode
        }
        if style != nil{
            dictionary["style"] = style
        }
        if uuid != nil{
            dictionary["uuid"] = uuid
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        appName = aDecoder.decodeObject(forKey: "appName") as? String
        deleted = aDecoder.decodeObject(forKey: "deleted") as? Int
        expiredTime = aDecoder.decodeObject(forKey: "expiredTime") as? Int
        forceUpdate = aDecoder.decodeObject(forKey: "forceUpdate") as? Int
        icon = aDecoder.decodeObject(forKey: "icon") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        information = aDecoder.decodeObject(forKey: "information") as? String
        iosLowestVersion = aDecoder.decodeObject(forKey: "iosLowestVersion") as? String
        iosUrl = aDecoder.decodeObject(forKey: "iosUrl") as? String
        iosVersion = aDecoder.decodeObject(forKey: "iosVersion") as? String
        lastPayingTime = aDecoder.decodeObject(forKey: "lastPayingTime") as? Int
        maxValue = aDecoder.decodeObject(forKey: "maxValue") as? Int
        password = aDecoder.decodeObject(forKey: "password") as? String
        qrCode = aDecoder.decodeObject(forKey: "qrCode") as? String
        style = aDecoder.decodeObject(forKey: "style") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if appName != nil{
            aCoder.encode(appName, forKey: "appName")
        }
        if deleted != nil{
            aCoder.encode(deleted, forKey: "deleted")
        }
        if expiredTime != nil{
            aCoder.encode(expiredTime, forKey: "expiredTime")
        }
        if forceUpdate != nil{
            aCoder.encode(forceUpdate, forKey: "forceUpdate")
        }
        if icon != nil{
            aCoder.encode(icon, forKey: "icon")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if information != nil{
            aCoder.encode(information, forKey: "information")
        }
        if iosLowestVersion != nil{
            aCoder.encode(iosLowestVersion, forKey: "iosLowestVersion")
        }
        if iosUrl != nil{
            aCoder.encode(iosUrl, forKey: "iosUrl")
        }
        if iosVersion != nil{
            aCoder.encode(iosVersion, forKey: "iosVersion")
        }
        if lastPayingTime != nil{
            aCoder.encode(lastPayingTime, forKey: "lastPayingTime")
        }
        if maxValue != nil{
            aCoder.encode(maxValue, forKey: "maxValue")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if qrCode != nil{
            aCoder.encode(qrCode, forKey: "qrCode")
        }
        if style != nil{
            aCoder.encode(style, forKey: "style")
        }
        if uuid != nil{
            aCoder.encode(uuid, forKey: "uuid")
        }
        
    }
    
}
