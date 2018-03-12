//
//  UserDefaults+BBase.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/17.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    
    /// 获取用户信息
    ///
    /// - Returns: 用户信息
    func getUserModel() -> UserModel? {
        let jsonStr = UserDefaults.standard.string(forKey: "userModel");
        if jsonStr != nil{
            return UserModel.deserialize(from:jsonStr);
            
            
        }
        if  let userDic = UserDefaults.standard.dictionary(forKey: "LUNCHEDUSER"){

            let model = UserModel.deserialize(from: userDic);
            self.setUserModel(model: model!);
            return model;
        }
        
        return nil;
        
    }
    
    func setUserModel(model:UserModel)  {
        if let jsonStr = model.toJSONString(){
             UserDefaults.standard.set(jsonStr, forKey: "userModel")
        }
        
       
    }
    
    
    func getUserSettingModel() ->UserSettingModel  {
        
        let jsonStr = UserDefaults.standard.string(forKey: "UserSettingModel");
        return UserSettingModel.deserialize(from:jsonStr) ?? UserSettingModel() ;
    }
    
    
    func setUserSettingModel(model:UserSettingModel)  {
        
        if let jsonStr = model.toJSONString(){
            UserDefaults.standard.set(jsonStr, forKey: "UserSettingModel")
        }
        
        
    }
    
    
    func getTelBookModel() -> TelBookModel? {
        let jsonStr = UserDefaults.standard.string(forKey: "TelBookModel")
        return TelBookModel.deserialize(from:jsonStr);
        
        
    }
    
    func setTelBookModel(model:TelBookModel)  {
        if let jsonStr = model.toJSONString(){
            UserDefaults.standard.set(jsonStr, forKey: "TelBookModel")
        }
        
        
    }
    
    
    
    
    
    
}
