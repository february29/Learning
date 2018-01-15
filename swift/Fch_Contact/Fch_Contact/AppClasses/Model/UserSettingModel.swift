//
//  UserSettingModel.swift
//  Fch_Contact
//
//  Created by bai on 2018/1/15.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import HandyJSON
class UserSettingModel: HandyJSON {

    required init() {
        
        fontSize = 13.0
    }
    
    var fontSize : CGFloat!
    var fontName : NSString!
    
    
}
