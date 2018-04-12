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
    var infoLable:UILabel?;
    var arrowImageView: UIImageView?
//    let lineView = UIView();
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.selectionStyle = .default;
//        self.accessoryType = .disclosureIndicator;
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
        coloumLable1?.setTextFontSize(type: .primary);
        coloumLable1?.setTextColor(.primary);
        self.contentView.addSubview(coloumLable1!);
        coloumLable1?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView);
            
        });
        
       
        
        arrowImageView = UIImageView(image: #imageLiteral(resourceName: "bg_list_item"));
        self.contentView.addSubview(arrowImageView!)
        arrowImageView?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(10);
            make.width.equalTo(7);
        })
        
        infoLable = UILabel();
        infoLable?.setTextFontSize(type: .primary);
        infoLable?.setTextColor(.primary);
//        infoLable?.setTextThemeName();
        infoLable?.textAlignment = .right;
        self.contentView.addSubview(infoLable!);
        infoLable?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo((arrowImageView?.snp.left)!).offset(-10);
            make.bottom.equalTo(self.contentView);
            
        });
        
//        self.contentView.backgroundColor = UIColor.white;
        
        
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
