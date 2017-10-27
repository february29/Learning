//
//  MainViewController.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/27.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: BBaseViewController {

    let userNameTextField = UITextField();
    var passWordTextfield = UITextField();
    
//    var tableView: UITableView! {
//        didSet {
//            tableView.rowHeight = 48
//            
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "hellow";
        
        userNameTextField.placeholder = "userName";
        userNameTextField.layer.cornerRadius = 5;
        userNameTextField.layer.borderColor = UIColor.darkGray.cgColor;
        userNameTextField.layer.borderWidth = 1.0;
        userNameTextField.textAlignment = NSTextAlignment.center;
        self.view.addSubview(userNameTextField);
        userNameTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view);
            make.width.equalTo(200);
            make.height.equalTo(45);
            make.top.equalTo(self.view).offset(100);
            
        }
        
        passWordTextfield.placeholder = "passWord";
        passWordTextfield.layer.cornerRadius = 5;
        passWordTextfield.layer.borderColor = UIColor.darkGray.cgColor;
        passWordTextfield.layer.borderWidth = 1.0;
        passWordTextfield.textAlignment = NSTextAlignment.center;
        self.view.addSubview(userNameTextField);
        userNameTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view);
            make.width.equalTo(200);
            make.height.equalTo(45);
            make.top.equalTo(userNameTextField.snp.bottom).offset(100);
            
        }
        
        let disposeBag = DisposeBag()
        
        Observable<Int>.empty()
            .subscribe { event in
                print(event)
            }
            .addDisposableTo(disposeBag)
        
        
//        let neverSequence = Observable<String>.never()

        
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
