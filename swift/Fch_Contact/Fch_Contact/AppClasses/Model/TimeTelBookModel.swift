//
//  TimeTelBookModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/21.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import HandyJSON
class TimeTelBookModel: HandyJSON,NSCoding {
    required init() {
        
    }
    
    var days : Int!
    var telBook : TelBookModel!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        days = dictionary["days"] as? Int
        if let telBookData = dictionary["telBook"] as? [String:Any]{
            telBook = TelBookModel(fromDictionary: telBookData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if days != nil{
            dictionary["days"] = days
        }
        if telBook != nil{
            dictionary["telBook"] = telBook.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        days = aDecoder.decodeObject(forKey: "days") as? Int
        telBook = aDecoder.decodeObject(forKey: "telBook") as? TelBookModel
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if days != nil{
            aCoder.encode(days, forKey: "days")
        }
        if telBook != nil{
            aCoder.encode(telBook, forKey: "telBook")
        }
        
    }

}
