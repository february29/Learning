//
//  MainViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import BAlertView

class MainViewController: BBaseViewController{
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "风驰电话本";
        self.navigationController?.isNavigationBarHidden = false;
        
        let but = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        but.backgroundColor = UIColor .yellow;
        but.layer.shadowColor = UIColor.black.cgColor;
        but.layer.shadowOffset = CGSize(width: -5, height: 0);
        but.layer.shadowOpacity = 0.5;
        view.addSubview(but);
        //已经设置电话本
        if false {
            
            checkTelBookDBHadUpDate(telBookID: 0, successHandler: {
                
            })
        }else{
            if let user = UserDefaults.standard.getUserModel(){
                getUserTelBooks(userId: user.id, successHandler: {
                    
                })
            }
           
        }
    
        
        
    }
    
    
    /// 获取用户电话本列表
    ///
    /// - Parameters:
    ///   - userId: 用户ID
    ///   - successHandler: 成功回掉
    func getUserTelBooks(userId:Int,successHandler:@escaping ()->Void)  {
        
        let par = ["userId":userId];
        BNetWorkingManager.shared.request(url: TelBooksList_URL, method: .post,parameters:par,  completionHandler: { (response) in
            
            if let value = response.result.value as? Dictionary<String, Any> {
                if let error = value["error"] {
                    let errorStr = error as! String;
                    if errorStr.components(separatedBy: "登录超时").count>1{
                        AppLoginHelper.loginForTimeOut(successHandler: {
                            self.getUserTelBooks(userId: userId, successHandler: successHandler);
                        })
                    }else{
                        print("登录失败")
                    }
                }else{
                    
                    
                    let list = [TelBookModel].deserialize(from:value["list"]as? NSArray)
                    
                    if list.count>1{
                        //多个电话本
                    }else{
                        //一个电话本呢
                        BAlertModal.sharedInstance().makeToast("数据异常");
                    }
                }
                
            }else{
                BAlertModal.sharedInstance().makeToast("网络异常");
            }
            
        });
    }
    
    
    /// 检查电话本是否有新数据更新
    ///
    /// - Parameters:
    ///   - telBookID: 电话本ID
    ///   - successHandler: 需要更新回掉
    func checkTelBookDBHadUpDate(telBookID:Int,successHandler:()->Void) {
        
        BNetWorkingManager.shared.request(url: "\(TelBook_Detail_URL)/\(telBookID)", method: .get, completionHandler: { (response) in
            
            if let value = response.result.value as? NSDictionary{
                print(value);
                if let error = value["error"]{
                    let errorStr = "登录失败：\(error)，请退出重新登录。"
                    BAlertModal.sharedInstance().makeToast(errorStr);
                }else{
                    if let user = value.object(forKey: "user") as? NSDictionary{
                        let userModel = UserModel.deserialize(from: user)
                        if userModel != nil{
                            UserDefaults.standard.setUserModel(model: userModel!);
                        }
                    }else{
                        BAlertModal.sharedInstance().makeToast("数据异常");
                    }
                }
                
            }else{
                BAlertModal.sharedInstance().makeToast("网络异常");
            }
            
        });
            
            
        
    }
    
    
    
    //返回按钮打开侧滑菜单
    override func back() {
        let sliderVC = self.sliderVC();
        
        if  sliderVC.state == .Open{
            self.sliderVC().hideLeftMenu();
        }else if sliderVC.state == .Close{
            self.sliderVC().showLeftMenu();
        }
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
   

}
