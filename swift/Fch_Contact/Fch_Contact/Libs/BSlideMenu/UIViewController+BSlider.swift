//
//  UIViewController+BSlider.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/17.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func sliderVC() -> BSlideMenuViewController {
        
        var sliderVC = self.parent;
        while !((sliderVC?.isKind(of: BSlideMenuViewController.self))!) {
            sliderVC = sliderVC?.parent;
        }
        
        return sliderVC as! BSlideMenuViewController;
        
    }

    
}
