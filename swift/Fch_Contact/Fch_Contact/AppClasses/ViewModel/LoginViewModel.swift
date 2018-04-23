//
//  LoginViewModel.swift
//  Fch_Contact
//
//  Created by bai on 2018/4/23.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
// 枚举
enum LoginResult {
    
    case LoginSuccess(message: String)
    case empty
    case failed(message: String)
    case ok(message:String)
}


class LoginViewModel {
    
//    let usernameUsable: Driver<LoginResult>
//    let loginButtonEnabled: Driver<Bool>
//    let loginResult: Driver<LoginResult>
//
//    init(input: (username: Driver<String>, password: Driver<String>, loginTaps: Driver<Void>)) {
//
//        usernameUsable = input.username
//            .flatMapLatest { username in
//
//                if username.count == 0 {
//                    return .just(.empty)
//                }
//
//                return .just(.ok(message: "用户名可用"))
//
//        }
//
//
//
//        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
//            ($0, $1)
//        }
//
//        loginResult = input.loginTaps.withLatestFrom(usernameAndPassword)
//            .flatMapLatest { (username, password) in
//                let par = ["loginName":username,
//                           "password":password.md5];
//
//                return  BNetWorkingManager.shared.RxRequset(url: Login_URL, method: .post, parameters: par).map({ (result) -> Driver<LoginResult> in
//                    if let value = result.value as? NSDictionary{
//                        if value["error"] != nil{
//
//                            return .just(.failed(message:value["error"]as!String))
//                        }else{
//
//
//                            if let user = value["user"] as? Dictionary<String,Any>{
//                                let userModel = UserModel.deserialize(from: user)
//                                if userModel != nil{
//                                    UserDefaults.standard.setUserModel(model: userModel!);
//
//                                }
//
//                            }
//                             return .just(.LoginSuccess(message:"登录成功"));
//
//                        }
//
//                    }else{
//                        return .just(.empty)
//                    }
//
//                })
//
//
//        }
//        
//        loginButtonEnabled = input.password
//            .map { $0.count > 0 }
//            .asDriver()
//
//
//    }
//
//
    
}
