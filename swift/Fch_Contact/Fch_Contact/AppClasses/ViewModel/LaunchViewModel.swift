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
    var textFieldTapDriver:Driver<Void>?;
//    var loginTapDriver:Driver<Void>?;
    
    
//    var resSut = <#value#>
    
    
    
    
    init(input:(username:Driver<String>,passWord:Driver<String>,usernameTFTap:Driver<Void>,passWordTFTap:Driver<Void>,loginTap:Driver<Void>)) {
        userNameDriver = input.username;
        passWordDriver = input.passWord;
//        loginTapDriver = input.loginTap;
        textFieldTapDriver = Driver.combineLatest(input.passWordTFTap, input.usernameTFTap){ (username: $0, password: $1) };
        
       

    }
    
  
    
    
}
