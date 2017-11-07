//
//  LaunchViewModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/6.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LaunchViewModel: NSObject {
    

    var userNameDriver:Driver<String>?;
    var passWordDriver:Driver<String>?;
    var loginTapDriver:Driver<Void>?;
    
    
    
    init(input:(username:Driver<String>,passWord:Driver<String>,loginTap:Driver<Void>)) {
        userNameDriver = input.username;
        passWordDriver = input.passWord;
        loginTapDriver = input.loginTap;
//        bind();
    }
    
    func bind(){
        
//        let userNameAndPasswordDriver = Driver.com
        
    }
    
    
}
