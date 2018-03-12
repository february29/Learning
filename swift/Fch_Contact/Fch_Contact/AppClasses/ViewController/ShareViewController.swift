//
//  ShareViewController.swift
//  Fch_Contact
//
//  Created by bai on 2018/3/9.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class ShareViewController: BBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分享";
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "img_share"));
        self.view.addSubview(imageView);
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.width.height.equalTo(self.view.snp.width).multipliedBy(0.75);
        };
        
        let lable = UILabel();
        lable .setTextFontSize(type: .primary);
        lable.setTextColor(.primary);
        lable.text = "扫描二维码下载风驰电话本";
        lable.textAlignment = .center;
        self.view.addSubview(lable);
        
        lable.snp.makeConstraints { (make) in
            make.bottom.equalTo(imageView.snp.top);
            make.centerX.equalTo(imageView);
            make.left.right.equalTo(self.view);
            make.height.equalTo(40);
        }
        

       
    }

    

}
