//
//  MainTableViewCell.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/30.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: BBaseTableViewCell {

    
    var coloumLable1:UILabel?;
    var coloumLable2:UILabel?;
    var coloumLable3:UILabel?;
    var coloumLable4:UILabel?;
    var coloumLable5:UILabel?;
    var coloumLable6:UILabel?;
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        coloumLable1 = UILabel();
        coloumLable1?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable1?.numberOfLines = 0;
        coloumLable1?.lineBreakMode = .byCharWrapping;
        coloumLable1?.sizeToFit();
        self.contentView.addSubview(coloumLable1!);
        coloumLable1?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(35);
            make.width.equalTo(BSCREENW/5);
        });
        
        coloumLable2 = UILabel();
        coloumLable2?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable2?.numberOfLines = 0;
        coloumLable2?.lineBreakMode = .byCharWrapping;
        coloumLable2?.sizeToFit();
        self.contentView.addSubview(coloumLable2!);
        coloumLable2?.snp.makeConstraints({ (make) in
            make.left.equalTo(coloumLable1!.snp.right);
            make.centerY.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(35);
            make.width.equalTo(BSCREENW/5);
        });
        
        coloumLable3 = UILabel();
        coloumLable3?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable3?.numberOfLines = 0;
        coloumLable3?.lineBreakMode = .byCharWrapping;
        coloumLable3?.sizeToFit();
        self.contentView.addSubview(coloumLable3!);
        coloumLable3?.snp.makeConstraints({ (make) in
            make.left.equalTo(coloumLable2!.snp.right);
            make.centerY.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(35);
            make.width.equalTo(BSCREENW/5);
        });
        
        coloumLable4 = UILabel();
        coloumLable4?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable4?.numberOfLines = 0;
        coloumLable4?.lineBreakMode = .byCharWrapping;
        coloumLable4?.sizeToFit();
        self.contentView.addSubview(coloumLable4!);
        coloumLable4?.snp.makeConstraints({ (make) in
            make.left.equalTo(coloumLable3!.snp.right);
            make.centerY.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(35);
            make.width.equalTo(BSCREENW/5);
        });
        
        coloumLable5 = UILabel();
        coloumLable5?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable5?.numberOfLines = 0;
        coloumLable5?.lineBreakMode = .byCharWrapping;
        coloumLable5?.sizeToFit();
        self.contentView.addSubview(coloumLable5!);
        coloumLable5?.snp.makeConstraints({ (make) in
            make.left.equalTo(coloumLable4!.snp.right)
            make.centerY.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(35);
            make.width.equalTo(BSCREENW/5);
        });
        
        coloumLable1?.textAlignment = .center;
        coloumLable2?.textAlignment = .center;
        coloumLable3?.textAlignment = .center;
        coloumLable4?.textAlignment = .center;
        coloumLable5?.textAlignment = .center;
   
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
