//
//  DeptModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/1.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import HandyJSON

class DeptModel:HandyJSON {

    
    required init() {
        
    }
    
    
    var id : Int!
    var book_id : Int!
    var name : String!
    var sort : Int!
    var deleted : Int!
}
