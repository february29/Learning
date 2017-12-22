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

    
    var leftBtn:UIButton?;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //导航条颜色
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = UIColor.white;
        self.navigationController?.navigationBar.isTranslucent = true;
        
        //左侧按钮
        let leftImage = UIImage(named: "btn_top_menu")
        leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44));
        leftBtn!.addTarget(self, action: #selector(BBaseViewController.back), for:.touchUpInside)
        leftBtn!.setImage(leftImage, for: .normal);
        leftBtn!.contentHorizontalAlignment = .left;
//        leftBtn.contentMode = .left;
//        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        let leftBtnItem = UIBarButtonItem.init(customView: leftBtn!);
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
