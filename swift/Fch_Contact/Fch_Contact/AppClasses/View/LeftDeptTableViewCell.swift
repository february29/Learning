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
//    let lineView = UIImageView();
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.selectionStyle = .default;
        self.backgroundColor = UIColor.clear;
//        self.contentView.backgroundColor = UIColor.clear;
       
//        lineView.image = UIImage.init(named: "bg_menu_item")!.withRenderingMode(.alwaysTemplate);
//        lineView.setTintColor(.primary);
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
            make.bottom.equalTo(self.contentView.snp.bottom);
            make.height.greaterThanOrEqualTo(35);
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
 
        
        let view = UIImageView();
        view.image =  UIImage.init(named: "bg_menu_head")?.withRenderingMode(.alwaysTemplate);
        view.setTintColor(.selectedCell)
        self.selectedBackgroundView = view;
        // Configure the view for the selected state
    }

}
