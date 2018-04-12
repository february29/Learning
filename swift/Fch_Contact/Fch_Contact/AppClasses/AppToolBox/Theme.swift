//
//  Theme.swift
//  Fch_Contact
//
//  Created by bai on 2018/1/30.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
//import RxCocoa
import RxSwift
import HandyJSON


enum Theme:String,HandyJSONEnum{
    case white
    case black
    case green
    case red
    case blue
    case purple
    case pink
    
}

enum ThemeColorType {
    case navBar//导航栏背景
    case navBarTitle//导航栏标题
    case navBarBtn//导航栏按钮颜色
    case background//view背景
    case tableBackground//主列表背景
    case leftTableBackground//菜单列表背景 暂时未用
    case primary//lable buttom等
    case secondary//tablesection
    case selectedCell
}

func rgb(_ hexString: String) -> UIColor? {
    return UIColor(hexString: hexString)
}

func rgba(_ hexString: String,_ alpha: CGFloat) -> UIColor? {
    return UIColor(hexString: hexString, alpha: alpha)
}

extension Theme {
    
    
    var colors:[UIColor]{
        switch self {
        
        case .white:
            return [rgb("ffffff")!,
                    rgb("000000")!,
                    BGlobalRedColor(),
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("333333", 0.8)!,
                    rgba("222222", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        case .black:
            return [rgb("313231")!,
                    rgb("cccccc")!,
                    rgb("ffffff")!,
                    rgb("313231")!,
                    rgb("333333")!,
                    rgba("313231", 0.8)!,
                    rgba("cccccc", 0.8)!,
                    rgba("222222", 1)!]
        case .blue:
            return [rgb("0291D4")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("0291D4", 0.8)!,
                    rgba("0291D4", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        case .purple:
            return [rgb("6c16c7")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("6c16c7", 0.8)!,
                    rgba("6c16c7", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        case .red:
            return [rgb("D2373B")!,
                    rgb("ffffff")!,rgb("ffffff")!,
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("D2373B", 0.8)!,
                    rgba("D2373B", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        case .green:
            return [rgb("01BD70")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("333333", 0.8)!,
                    rgba("01BD70", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        case .pink:
            return [rgb("E52D7C")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    rgb("ffffff")!,
                    UIColor.white,
                    rgba("333333", 0.8)!,
                    rgba("E52D7C", 0.8)!,
                    BRGBColor(r: 236, g: 236, b: 236, a:1)]
        }
    }
    
    var displayName: String {
        switch self {
        case .white:
            return BLocalizedString(key: "ThemeWhite")
        case .black:
            return BLocalizedString(key: "ThemeBlack")
        case .blue:
            return BLocalizedString(key: "ThemeBlue")
        case .red:
            return BLocalizedString(key: "ThemeRed")
        case .purple:
            return BLocalizedString(key: "ThemePurple")
        case .pink:
            return BLocalizedString(key: "ThemePink")
        case .green:
            return BLocalizedString(key: "ThemeGreen")
        }
    }
    
}

class ColorCenter {
    static let shared = ColorCenter()
    
    let navBar = Variable(UIColor.clear)
    let navBarTitle = Variable(UIColor.clear)
    let navBarBtn = Variable(UIColor.clear)
    let primary = Variable(UIColor.clear)
    let secondary = Variable(UIColor.clear)
    let background = Variable(UIColor.clear)
    let tableBackground = Variable(UIColor.clear)
    let leftTableBackground = Variable(UIColor.clear)
    let selectedCell = Variable(UIColor.clear)
    let themeName = Variable("");
    
    var theme: Theme = .white {
        didSet {
            navBar.value = theme.colors[0]
            navBarTitle.value = theme.colors[1]
            navBarBtn.value = theme.colors[2]
            background.value = theme.colors[3]
            tableBackground.value = theme.colors[4]
            leftTableBackground.value = theme.colors[5]
            primary.value = theme.colors[6]
            secondary.value = theme.colors[7]
            selectedCell.value = theme == .black ? rgb("151515")! : rgb("e0e0e0")!
            themeName.value = theme.displayName;
        }
    }
    
    func colorVariable(with type: ThemeColorType) -> Variable<UIColor> {
        switch type {
        case .navBar:
            return navBar
        case .navBarTitle:
            return navBarTitle
        case .navBarBtn:
            return navBarBtn
        case .primary:
            return primary
        case .secondary:
            return secondary
        case .background:
            return background
        case .tableBackground:
            return tableBackground
        case .leftTableBackground:
            return leftTableBackground
        case .selectedCell:
            return selectedCell
        }
    }
}

extension UINavigationBar {
    func setBarTintColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.barTintColor = color

        })
    }
    
    func setContentColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.tintColor = color
            
           
            let attr: [NSAttributedStringKey:Any] = [
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),
                NSAttributedStringKey.foregroundColor: color
            ]
            self.titleTextAttributes = attr
        })
    }
}

extension UIView {
    func setBackgroundColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self] (color) in
            self.backgroundColor = color
        })
    }
    
    func setTintColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.tintColor = color
        })
    }
}

extension UILabel {
    
    func setTextColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.textColor = color
        })
    }
    
//    func setTextThemeName()  {
//        _ = ColorCenter.shared.themeName.asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](name) in
//            self.text = name;
//        })
//    }
}

extension UIButton {
    
    func setTitleColor(_ color: ThemeColorType, forState: UIControlState = .normal) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.setTitleColor(color, for: forState)
        })
    }
}

extension UIBarButtonItem {
    
    func setTintColor(_ color: ThemeColorType, forState: UIControlState = .normal) {
        
        
       _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.tintColor = color;
        })
    }
    
    
    
    
}

extension UITableView {
    func setSeparatorColor(_ color: ThemeColorType) {
        
        
       _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
       
        
        self.separatorColor = color.withAlphaComponent(0.25);
        })
        
    }
    
    func setSectionIndexColor(_ color: ThemeColorType) {
        
        
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            
            
            self.sectionIndexColor = color;
        })
        
    }
}

extension UITextField {
    func setTextColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.textColor = color
        })
    }
    
    
   
}

extension UIActivityIndicatorView {
    func setColor(_ color: ThemeColorType) {
        _ = ColorCenter.shared.colorVariable(with: color).asObservable().takeUntil(rx.deallocated).subscribe(onNext: { [unowned self](color) in
            self.color = color
        })
    }
}


