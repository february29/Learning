//
//  BBaseConstant.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

/// 屏幕的宽
let BSCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let BSCREENH = UIScreen.main.bounds.size.height


/// RGBA的颜色设置
func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func BGlobalColor() -> UIColor {
    return YMColor(r: 240, g: 240, b: 240, a: 1)
}

/// 红色
func BGlobalRedColor() -> UIColor {
    return YMColor(r: 245, g: 80, b: 83, a: 1.0)
}
