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
    
//    var  isEditing:Driver<Bool>?;
    
    var loginTapDriver:Driver<Void>?;
    var textFieldTapDriver1:Driver<Void>?;
    var textFieldTapDriver2:Driver<Void>?;

    
    
//    var resSut = <#value#>
    
    
    
    
    init(input:(username:Driver<String>,passWord:Driver<String>,usernameTFTap:Driver<Void>,passWordTFTap:Driver<Void>,loginTap:Driver<Void>)) {
        userNameDriver = input.username;
        passWordDriver = input.passWord;
        loginTapDriver = input.loginTap;
        
//        isEditing = Driver.combineLatest(input.usernameTFTap, input.passWordTFTap, resultSelector: { _,_ in
//           return true;
//
//        });
        textFieldTapDriver1 = input.usernameTFTap;
        textFieldTapDriver2 = input.passWordTFTap;
        
//        textFieldTapDriver = Driver.combineLatest(input.usernameTFTap, input.passWordTFTap, resultSelector: { (_: $0, _: $1)
//            
//        })
//       

    }
    
  
    
    
}
