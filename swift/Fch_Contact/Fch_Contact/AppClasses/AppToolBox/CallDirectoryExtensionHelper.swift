//
//  CallDirectoryExtensionHelper.swift
//  Fch_Contact
//
//  Created by bai on 2018/4/11.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import CallKit

let callDirectoryExtenionBundleIdentifier = "com.xianzhi.contact.Fch-contact-CallDirectoryExtension"

class CallDirectoryExtensionHelper {
    static let sharedInstance = CallDirectoryExtensionHelper();
    private init() { };
    
    func reloadExtension(completeHandler:@escaping (_ isSupport:Bool,  _ error:Error?)->Void){
        if #available(iOS 10.0, *) {
            let manager = CXCallDirectoryManager.sharedInstance;
            manager.reloadExtension(withIdentifier: callDirectoryExtenionBundleIdentifier) { (error) in
                completeHandler(true,error);
            }
        } else {
            // Fallback on earlier versions
            completeHandler(false,nil);
        };
        
       
    }
    
    func checkCallKitOpen(finishedHandler:@escaping (_ isSupport:Bool,_ isOpen:Bool)->Void)  {
        
        
        if #available(iOS 10.0, *) {
            let callManager = CXCallDirectoryManager.sharedInstance;
            callManager.getEnabledStatusForExtension(withIdentifier: callDirectoryExtenionBundleIdentifier, completionHandler: { (status, error) in
                
                if status == .enabled{
                    finishedHandler(true,true);
                }else if status == .disabled{
                    
//                    self.showAlert(title: "授权", message: "请在设置->电话->来电组阻止与身份识别授权相关权限")
                    finishedHandler(true,false);
                }else {
//                    BAlertModal.sharedInstance().makeToast("未知错误");
                    finishedHandler(true,false);
                }
                
                
                
                
            })
            
            
            
        } else {
            // Fallback on earlier versions
//            BAlertModal.sharedInstance().makeToast("该功能适用于iOS10及以上版本系统");
            finishedHandler(false,false);
            
        };
        
        
    }
    
    
    
}
