//
//  MainViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class MainViewController: BBaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "风驰电话本";
        self.navigationController?.isNavigationBarHidden = false;
        
        let but = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        but.backgroundColor = UIColor .yellow;
        but.layer.shadowColor = UIColor.black.cgColor;
        but.layer.shadowOffset = CGSize(width: -5, height: 0);
        but.layer.shadowOpacity = 0.5;
        view.addSubview(but);
        
    }
    
    override func back() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   

}
