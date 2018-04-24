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
import Alamofire
// 枚举
enum LoginResult {
    
    case loginSuccess(message: String)
    case empty
    case failed(message: String)
    case ok
    
    
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}


enum NetWorkingStatus {
    
    case start
    case end
    case requseting
    
}



class LoginViewModel {
    
    let validatedUsername: Driver<LoginResult>
    let validatedPassword: Driver<LoginResult>
    // Is signup button enabled
    let signupEnabled: Driver<Bool>
    
    // Has user signed in
//    let signedIn: Driver<NetWorkingStatus>
    let signedIn: Driver<Bool>
    
    // Is signing process in progress
//    let signingIn: Driver<Bool>
   

    init(
        
        usernameDriver: Driver<String>,
        passwordDriver: Driver<String>,
        loginTaps: Driver<Void>
        
        ) {
       
        
        
        validatedUsername = usernameDriver
            .flatMapLatest { username in
                
                if username.count == 0{
                    return .just(.empty)
                }
                return .just(.ok)
                
        }
        
        validatedPassword = passwordDriver
            .flatMapLatest { password in
                if password.count == 0{
                    return .just(.empty)
                }
                return .just(.ok)
        }
        
        
        
       
        let usernameAndPassword = Driver.combineLatest(usernameDriver,passwordDriver) { (username: $0, password: $1) }

        signedIn = loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
               
                
                let par = ["loginName":pair.username,
                           "password":pair.password.md5];
                
                return BNetWorkingManager.shared.RxRequset(url: Login_URL, method: .post, parameters: par).flatMapLatest({ (result) -> Observable<Bool> in
                    
                    if let value = result.value as? NSDictionary{
                        if let user = value["user"] as? Dictionary<String,Any>{
                            let userModel = UserModel.deserialize(from: user)
                            if userModel != nil{
                                UserDefaults.standard.setUserModel(model: userModel!);
                            }
                          return Observable.just(true)
                        }else{
                            return Observable.just(false)
                        }
                    }else{
                        return Observable.just(false)
                    }
                }).asDriver(onErrorJustReturn: false);
            }
//            .flatMapLatest { loggedIn -> Driver<Bool> in
//                let message = loggedIn ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
//                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
//                    // propagate original value
//                    .map { _ in
//                        loggedIn
//                    }
//                    .asDriver(onErrorJustReturn: false)
//        }
        
        
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword
            
        )   { username, password  in
            username.isValid &&
                password.isValid
            
            }
            .distinctUntilChanged()
    
}

    
}
