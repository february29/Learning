//
//  LoginView.swift
//  Fch_Contact
//
//  Created by bai on 2018/4/20.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit
class LoginView: UIView {
    
    lazy var  userName: UITextField  = {
        let tf = UITextField();
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.placeholder = "用户名";
        tf.layer.cornerRadius = 3;
        tf.layer.borderWidth = 0.8;
        tf.layer.borderColor = BRGBColor(r: 237, g: 237, b: 237, a: 1).cgColor;
        tf.textAlignment = .center;
        //        tf.layer.cornerRadius = 5;
        tf.background = UIImage.init(named: "bg_guide_text");
        
        
        return tf;
    }();
    lazy var  passWord: UITextField  = {
        let tf = UITextField();
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.placeholder = "密码";
        tf.layer.cornerRadius = 3;
        tf.layer.borderWidth = 0.8;
        tf.layer.borderColor = BRGBColor(r: 237, g: 237, b: 237, a: 1).cgColor;
        tf.isSecureTextEntry = true;
        tf.textAlignment = .center;
        //        tf.layer.cornerRadius = 5;
        tf.background = UIImage.init(named: "bg_guide_text");
        return tf;
    }();
    
    
    lazy var  loginBtn: UIButton  = {
        let btn = UIButton();
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(.primary);
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.8;
        btn.layer.borderColor = BRGBColor(r: 237, g: 237, b: 237, a: 1).cgColor;
        btn.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        return btn;
    }();
    
    
    

    override init(frame: CGRect) {
        super .init(frame: frame);
        self.backgroundColor = UIColor.white;
        self.layer.cornerRadius = 5;
        
        self.addSubview(self.userName);
        self.addSubview(self.passWord)
        self.addSubview(self.loginBtn);
        
        
        self.userName.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(25);
            make.centerX.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.75);
            make.height.equalTo(35);
            
        }
        
       
        
        self.passWord.snp.makeConstraints { (make) in
            make.top.equalTo(self.userName.snp.bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.equalTo(self.userName);
            make.height.equalTo(self.userName);
            
        }
        
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.passWord.snp.bottom).offset(10);
            make.centerX.equalTo(self);
            make.width.equalTo(self.userName);
            make.height.equalTo(self.userName);
            
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
