//
//  BBaseViewController.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/27.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit



class BBaseViewController: UIViewController {

    
//    var leftBtn:UIButton?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //导航条颜色
        self.view.backgroundColor = UIColor.white;
//        self.navigationController?.navigationBar.barTintColor = UIColor.white;
//        self.navigationController?.navigationBar.isTranslucent = true;
        
        //左侧按钮

        let leftBtnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_top_back"), style: .plain, target: self, action: #selector(BBaseViewController.back));
        leftBtnItem.setTintColor(.navBarBtn);
        self.navigationItem.leftBarButtonItem = leftBtnItem;
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @objc func back() {
        if let nv = self.navigationController {
            nv.popViewController(animated: true);
        }
    }
    

   
}
