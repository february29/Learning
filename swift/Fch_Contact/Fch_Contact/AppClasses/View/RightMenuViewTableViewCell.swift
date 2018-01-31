//
//  RightMenuViewTableViewCell.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/22.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

class RightMenuViewTableViewCell: BBaseTableViewCell {
    
    var iconImageView:UIImageView?
    var nameLable:UILabel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.backgroundColor = UIColor.clear;
        
        iconImageView = UIImageView();
        self.contentView.addSubview(iconImageView!);
        iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.height.equalTo(17);
        })
        
        nameLable = UILabel();
        nameLable?.setTextFontSize(type: .primary);
        nameLable?.setTextColor(.primary);
//        nameLable?.font = UIFont.systemFont(ofSize: 13);
        self.contentView.addSubview(nameLable!);
//        nameLable?.textAlignment = .center;
        nameLable?.snp.makeConstraints({ (make) in
            make.left.equalTo(iconImageView!.snp.right).offset(10);
            make.right.equalTo(self.contentView).offset(-5);
            make.top.bottom.equalTo(self.contentView);
            make.height.greaterThanOrEqualTo(30);
        })
        
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
