//
//  TelBookModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/20.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import HandyJSON

class TelBookModel : HandyJSON, NSCoding{
    required init() {
        
    }
    
    
    var bookName : String!
    var compileInfo : String!
    var compileStatus : Int!
    var deleted : Int!
    var expiredTime : Int!
    var forceUpdate : Int!
    var icon : String!
    var id : Int!
    var information : String!
    var lowestVersion : String!
    var maxValue : Int!
    var ownerId : Int!
    var password : String!
    var qrCode : String!
    var style : String!
    var url : String!
    var uuid : String!
    var version : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookName = dictionary["bookName"] as? String
        compileInfo = dictionary["compileInfo"] as? String
        compileStatus = dictionary["compileStatus"] as? Int
        deleted = dictionary["deleted"] as? Int
        expiredTime = dictionary["expiredTime"] as? Int
        forceUpdate = dictionary["forceUpdate"] as? Int
        icon = dictionary["icon"] as? String
        id = dictionary["id"] as? Int
        information = dictionary["information"] as? String
        lowestVersion = dictionary["lowestVersion"] as? String
        maxValue = dictionary["maxValue"] as? Int
        ownerId = dictionary["ownerId"] as? Int
        password = dictionary["password"] as? String
        qrCode = dictionary["qrCode"] as? String
        style = dictionary["style"] as? String
        url = dictionary["url"] as? String
        uuid = dictionary["uuid"] as? String
        version = dictionary["version"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bookName != nil{
            dictionary["bookName"] = bookName
        }
        if compileInfo != nil{
            dictionary["compileInfo"] = compileInfo
        }
        if compileStatus != nil{
            dictionary["compileStatus"] = compileStatus
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
        if lowestVersion != nil{
            dictionary["lowestVersion"] = lowestVersion
        }
        if maxValue != nil{
            dictionary["maxValue"] = maxValue
        }
        if ownerId != nil{
            dictionary["ownerId"] = ownerId
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
        if url != nil{
            dictionary["url"] = url
        }
        if uuid != nil{
            dictionary["uuid"] = uuid
        }
        if version != nil{
            dictionary["version"] = version
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookName = aDecoder.decodeObject(forKey: "bookName") as? String
        compileInfo = aDecoder.decodeObject(forKey: "compileInfo") as? String
        compileStatus = aDecoder.decodeObject(forKey: "compileStatus") as? Int
        deleted = aDecoder.decodeObject(forKey: "deleted") as? Int
        expiredTime = aDecoder.decodeObject(forKey: "expiredTime") as? Int
        forceUpdate = aDecoder.decodeObject(forKey: "forceUpdate") as? Int
        icon = aDecoder.decodeObject(forKey: "icon") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        information = aDecoder.decodeObject(forKey: "information") as? String
        lowestVersion = aDecoder.decodeObject(forKey: "lowestVersion") as? String
        maxValue = aDecoder.decodeObject(forKey: "maxValue") as? Int
        ownerId = aDecoder.decodeObject(forKey: "ownerId") as? Int
        password = aDecoder.decodeObject(forKey: "password") as? String
        qrCode = aDecoder.decodeObject(forKey: "qrCode") as? String
        style = aDecoder.decodeObject(forKey: "style") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
        version = aDecoder.decodeObject(forKey: "version") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bookName != nil{
            aCoder.encode(bookName, forKey: "bookName")
        }
        if compileInfo != nil{
            aCoder.encode(compileInfo, forKey: "compileInfo")
        }
        if compileStatus != nil{
            aCoder.encode(compileStatus, forKey: "compileStatus")
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
        if lowestVersion != nil{
            aCoder.encode(lowestVersion, forKey: "lowestVersion")
        }
        if maxValue != nil{
            aCoder.encode(maxValue, forKey: "maxValue")
        }
        if ownerId != nil{
            aCoder.encode(ownerId, forKey: "ownerId")
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
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if uuid != nil{
            aCoder.encode(uuid, forKey: "uuid")
        }
        if version != nil{
            aCoder.encode(version, forKey: "version")
        }
        
    }
    
}

