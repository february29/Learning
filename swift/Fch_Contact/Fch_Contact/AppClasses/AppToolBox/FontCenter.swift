//
//  FontCenter.swift
//  Fch_Contact
//
//  Created by bai on 2018/1/31.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON

enum FontSize:String ,HandyJSONEnum{
    case small
    case middle
    case large
}

enum FontSizeType:String{
    case navBarTitle;
    case primary
    case senondary
}

extension FontSize{
    
    var sizes:[CGFloat]{
        switch self {
        case .small:
            return [18.0,11,13];
        case .middle:
            return [19.0,13,15];
        case .large:
            return [19.0,15,17];
        }
    }
    
    var displayName:String {
        switch self {
        case .small:
            return BLocalizedString(key: "small")
        case .middle:
            return BLocalizedString(key: "middle")
        case .large:
            return BLocalizedString(key: "large")
        }
    }
}


class FontCenter {
    static let shared = FontCenter();
    
    
    
    let navBarTitle:Variable<CGFloat> = Variable(15.0)
    let primary:Variable<CGFloat> = Variable(11.0)
    let secondary:Variable<CGFloat> = Variable(13.0)
    let fontName:Variable<String> = Variable("");
    
    
    var fontSize:FontSize = .middle {
        didSet{
            navBarTitle.value = fontSize.sizes[0]
            primary.value = fontSize.sizes[1]
            secondary.value = fontSize.sizes[2]
            fontName.value = fontSize.displayName;
        }
    }
    
    func sizeVariable(type:FontSizeType) -> Variable<CGFloat> {
        switch type {
        case .navBarTitle:
            return navBarTitle;
        case .primary:
            return primary;
        case .senondary:
            return secondary;
       
        }
    }
    
}

extension UILabel{
    func setTextFontSize(type:FontSizeType){
      _ = FontCenter.shared.sizeVariable(type: type).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { (size) in
            self.font = UIFont.systemFont(ofSize: size);
        })
    }
    
    
}


extension UITextField{
    func setTextFontSize(type:FontSizeType){
        _ = FontCenter.shared.sizeVariable(type: type).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { (size) in
            self.font = UIFont.systemFont(ofSize: size);
        })
    }
}


