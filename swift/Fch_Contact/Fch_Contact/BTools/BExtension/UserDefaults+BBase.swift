//
//  UserDefaults+BBase.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/17.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    func getUserModel() -> UserModel? {
        let jsonStr = UserDefaults.standard.string(forKey: "userModel");
        return UserModel.deserialize(from:jsonStr)!;
    }
    
    func setUserModel(model:UserModel)  {
        if let jsonStr = model.toJSONString(){
             UserDefaults.standard.set(jsonStr, forKey: "userModel")
        }
        
       
    }
    
    
    
    
    
}
