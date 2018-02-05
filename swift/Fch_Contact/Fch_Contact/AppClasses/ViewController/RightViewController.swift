//
//  RightViewController.swift
//  Fch_Contact
//
//  Created by bai on 2018/2/1.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit


class RightViewController: BBaseViewController {
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField();
        tf.setTextColor(.primary);
        tf.setTextFontSize(type: .primary);
        tf.layer.borderColor = UIColor.lightGray.cgColor;
        tf.layer.borderWidth = 1;
        tf.placeholder = "姓名、部门";
        tf.layer.cornerRadius =  5;
        
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.searchTextField);
        searchTextField.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-25);
            make.height.equalTo(35);
            make.width.equalTo(200);
            make.centerY.equalTo(self.view);
        }
        
    }

    

}
