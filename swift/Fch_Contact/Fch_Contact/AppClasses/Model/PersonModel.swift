//
//  PersonModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/22.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import HandyJSON

class PersonModel: HandyJSON {
    
    required init() {
        
    }
    
    
    var id : Int!
    var book_id : Int!
    var dept_id : Int!
    var column1 : String!
    var column2 : String!
    var column3 : String!
    var column4 : String!
    var column5 : String!
    var column6 : String!
    var deleted : Int!
    var is_title : Int!
    
    
    
}
