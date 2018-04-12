//
//  SettingCellModel.swift
//  Fch_Contact
//
//  Created by bai on 2018/4/11.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift


class SettingCellModel: HandyJSON {

    required init() {
        
    }
    
    convenience init(labStr:String,infoStr:String,showArrow:Bool) {
        self.init();
        lab = labStr;
        info =  infoStr;
        self.showArrow = showArrow
    }
    
    var lab:String?
    var info:String?
    var showArrow:Bool?
    
    
    
    
    
    
}

////设置主题，字体，等变化时改变显示
//extension SettingCellModel{
//    
//    
//    
//    func setThemeInfo() {
//        _ = ColorCenter.shared.themeName.asObservable().subscribe(onNext: { [unowned self](name) in
//            self.info = name;
//            
//        })
//        
//    }
//    
//}

