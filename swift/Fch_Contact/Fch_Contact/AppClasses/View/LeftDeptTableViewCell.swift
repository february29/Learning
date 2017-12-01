//
//  LeftDeptTableViewCell.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/1.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class LeftDeptTableViewCell: BBaseTableViewCell {

    
    var coloumLable1:UILabel?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        
        coloumLable1 = UILabel();
        coloumLable1?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        coloumLable1?.textColor = UIColor.black;
//        coloumLable1?.numberOfLines = 0;
//
//        coloumLable1?.lineBreakMode = .byCharWrapping;
//        coloumLable1?.sizeToFit();
        self.contentView.addSubview(coloumLable1!);
        coloumLable1?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(20);
        });
        
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

        // Configure the view for the selected state
    }

}
