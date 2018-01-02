//
//  SettingTableViewCell.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/26.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class SettingTableViewCell: BBaseTableViewCell {

    var coloumLable1:UILabel?;
//    let lineView = UIView();
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.selectionStyle = .default;
        self.backgroundColor = UIColor.clear;
        //        self.contentView.backgroundColor = UIColor.clear;
        
//        lineView.image = UIImage.init(named: "bg_menu_item");
//        self.contentView.addSubview(lineView);
//        lineView.snp.makeConstraints { (make) in
//            make.bottom.left.right.equalTo(self.contentView);
//            make.height.equalTo(0.5);
//        }
        
//        self.selectedBackgroundView = UIImageView(image: UIImage.init(named: "bg_menu_head"));
        
        
        coloumLable1 = UILabel();
        coloumLable1?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable1?.textColor = UIColor.black;
        //        coloumLable1?.numberOfLines = 0;
        //
        //        coloumLable1?.lineBreakMode = .byCharWrapping;
        //        coloumLable1?.sizeToFit();
        self.contentView.addSubview(coloumLable1!);
        coloumLable1?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView);
            
        });
        
        self.contentView.backgroundColor = UIColor.white;
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        self.selectedBackgroundView = UIImageView(image: UIImage.init(named: "bg_menu_head"));
        // Configure the view for the selected state
    }


}
