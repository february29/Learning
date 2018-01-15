//
//  AppLoginHelper.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/20.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation

class AppLoginHelper{
    //超时重新登录，（客户端登录一段时间无操作，服务端将剔除客户端，需要重新调用登录接口才能请求其它接口）
    class func loginForTimeOut(successHandler:@escaping ()->Void) {
        
        if let user = UserDefaults.standard.getUserModel(){
            
            let par = ["loginName":user.loginName!,
                       "password":user.password!];
            
            BNetWorkingManager.shared.request(url: Login_URL, method: .post, parameters: par, completionHandler: { (response) in
                
                if let value = response.result.value as? NSDictionary{
                    print(value);
                    if let error = value["error"]{
                        print(error);
                    }else{
                        successHandler();
                    }
                    
                }else{
                    print("网络异常");
                }
            })
        }
        
    }
}




