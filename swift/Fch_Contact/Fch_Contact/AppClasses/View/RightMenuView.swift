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

class RightMenuView: UIView {

    
    var arroww:CGFloat = 10.0;
    var arrowh:CGFloat = 7.0;
    var arrowPaddingRight:CGFloat = 10.0;
    var contentCornerRadius:CGFloat = 5;
    
    
    
    
    
    let arrowView = TriangleView();
    let  contentView = UIView();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        arrowView.backgroundColor = UIColor.clear;

        contentView.layer.cornerRadius = contentCornerRadius;
        contentView.backgroundColor = UIColor.white;
        self.addSubview(arrowView);
        self.addSubview(contentView);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        arrowView.frame = CGRect(x: self.frame.size.width - arrowPaddingRight - arroww, y: 0, width: arroww, height: arrowh);
        contentView.frame = CGRect(x: 0, y: arrowh, width: self.frame.size.width, height: self.frame.size.height - arrowh);
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
