//
//  BAlert.swift
//  BAlertDemo
//
//  Created by bai on 2017/12/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

let b_alertBackGroundColor = UIColor.init(white: 0, alpha: 0.3);






typealias AnimationOverHandle = ()->Void;

class BAlert {
//    UIWindow *window;
//    BAlerterViewController *viewController;
//    UIView *contentView;
    
    //动画时间
    var b_AnimationTime = 0.20;
    
    let alertWindow = UIWindow(frame:UIScreen.main.bounds);
    let alertVC = BAlertViewController();
    
    
//    var _view:UIView!
//    var _showHandler:Handler?;
//    var _hideHandler:Handler?;
    

    var viewArrays = Array<UIView>();
    
    
//    let arr = Array<Any>()
    
    //单例
    static let sharedInstance = BAlert();
    private init() {
        self.config();
    }
    
    func config()  {
        alertVC.backBtn.backgroundColor = b_alertBackGroundColor;
        alertWindow.rootViewController = alertVC;
        
    }
    //
    
    
    
 
    func show(view:UIView! ,showHandler:BAlertHandler? = nil,hideHandler:BAlertHandler? = nil) {


       
        alertWindow.makeKeyAndVisible();
        alertVC.view.addSubview(view);
        viewArrays.append(view);
    

        view.b_showHandler = showHandler;
        view.b_hideHandler = hideHandler;
        

        //背景显示按钮动画
        alertVC.backBtn.alpha = 0;
        UIView.animate(withDuration: b_AnimationTime, animations: {
            self.alertVC.backBtn.alpha = 1;
        }) { (over) in
            
        }
       
        
        if let show = view.b_showHandler {
            show(view);
        }
        

    }
    
    
    /// 全部隐藏
    func hideAllView(finishedHandle:AnimationOverHandle? = nil) {
        
        for (_, view) in viewArrays.enumerated(){
            view.b_hideHandler?(view);
        }
       
        
        alertVC.backBtn.alpha = 1;
        UIView.animate(withDuration: b_AnimationTime, animations: {
            self.alertVC.backBtn.alpha = 0;
        }) { (over) in
            for (_, view) in self.viewArrays.enumerated(){
                view .removeFromSuperview();
            }
            self.viewArrays.removeAll();
            
            UIApplication.shared.delegate?.window??.makeKeyAndVisible();
            
            if finishedHandle != nil{
                finishedHandle!();
            }
        }
    }
    
    
    
    /// 隐藏特定view
    ///
    /// - Parameter view: view
    func hide(view:UIView,finishedHandle:AnimationOverHandle? = nil){
        
        view.b_hideHandler?(view);
        
        alertVC.backBtn.alpha = 1;
        UIView.animate(withDuration: b_AnimationTime, animations: {
            self.alertVC.backBtn.alpha = 0;
        }) { (over) in
            view.removeFromSuperview();
            UIApplication.shared.delegate?.window??.makeKeyAndVisible();
            if finishedHandle != nil{
                finishedHandle!();
            }
        }
        
        if let index = viewArrays.index(of: view) {
             viewArrays.remove(at: index);
        }
       
       
    }
    
    
    
}
