//
//  RightMenuView.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit


class TriangleView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect);
       
        let ctx = UIGraphicsGetCurrentContext();
        // 2.画三角形
        ctx?.move(to: CGPoint(x: self.frame.size.width/2, y: 0));
        ctx?.addLine(to: CGPoint(x: 0, y: self.frame.size.height));
        ctx?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height));
        ctx?.closePath();
        //颜色
        UIColor.white.setFill();
        UIColor.white.setStroke();

        ctx?.drawPath(using: CGPathDrawingMode.fillStroke);
        
    }
}

typealias  SelectedRowHandle = (_ index:Int)->Void;

class RightMenuView: UIView,UITableViewDelegate,UITableViewDataSource {

    
    var arroww:CGFloat = 10.0;
    var arrowh:CGFloat = 7.0;
    var arrowPaddingRight:CGFloat = 10.0;
    var contentCornerRadius:CGFloat = 5;
    
    var seletedHandle:SelectedRowHandle?;
    
    lazy var tableView:UITableView = {
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 20;
        table.delegate = self;
        table.dataSource = self;
        table.layer.cornerRadius = 5;
        table.separatorStyle = .none;
        table.backgroundColor = UIColor.clear;
        table.layer.masksToBounds = true;
        table.register(RightMenuViewTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
        table.tableFooterView = UIView();
        
        return table;
    }();

    

    
    
    
    let menuArray = [
                     ["icon":"icon_menu_refresh","name":BLocalizedString(key: "Refresh")],
                     ["icon":"icon_menu_share","name":BLocalizedString(key: "Share")],
                     ["icon":"icon_menu_setting","name":BLocalizedString(key: "Setting")]
                    ];
    


    
    
    let arrowView = TriangleView();
    let  contentView = UIView();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        arrowView.backgroundColor = UIColor.clear;

        contentView.layer.cornerRadius = contentCornerRadius;
        contentView.backgroundColor = UIColor.white;
//        contentView.setTintColor(.background);
//        arrowView.setTintColor(.background);
        self.addSubview(arrowView);
        self.addSubview(contentView);
//
        contentView .addSubview(tableView);
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        arrowView.frame = CGRect(x: self.frame.size.width - arrowPaddingRight - arroww, y: 0, width: arroww, height: arrowh);
        contentView.frame = CGRect(x: 0, y: arrowh, width: self.frame.size.width, height: self.frame.size.height - arrowh);
        tableView.frame = contentView.bounds;
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: tableview代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:RightMenuViewTableViewCell?
        
        cell = RightMenuViewTableViewCell(style: .default, reuseIdentifier:"cell");
        
        cell?.iconImageView?.image = UIImage.init(named: menuArray[indexPath.row]["icon"]!)?.withRenderingMode(.alwaysTemplate);
        cell?.iconImageView?.setTintColor(.primary);
        cell?.nameLable?.text = menuArray[indexPath.row]["name"];
        //        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13);
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if seletedHandle != nil {
            seletedHandle!(indexPath.row);
        }
    }
    
    

    

}
