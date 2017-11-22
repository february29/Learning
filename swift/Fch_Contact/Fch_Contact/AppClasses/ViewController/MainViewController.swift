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
        
        //已经设置电话本
        if let telBook = UserDefaults.standard.getTelBookModel() {
            
            checkTelBookDBShouldUpDate(telBookID: telBook.id, successHandler: {
                
            });
           let allPersons =  DBHelper.sharedInstance.getPersonsFromDB(deptId: -1);
            print(allPersons);
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
        print("获取用户电话本列表");
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
                        BAlertModal.sharedInstance().makeToast("登录失败：\(error)，请退出重新登录。");
                    }
                }else{
                    let telbookArray = [TimeTelBookModel].deserialize(from:value["list"]as? NSArray);
                    if let telbooks = telbookArray  {
                        if telbooks.count > 1{
                            //多个电话本
                            print("多个电话本 个数：\(telbooks.count)");
                        }else if telbooks.count == 1{
                            //一个电话本
                            if let telBook = telbooks[0]!.telBook{
                                UserDefaults.standard.setTelBookModel(model:telBook);
                                self.downLoadDB(telBook: telBook, finshedHandler: { (isSuccessful) in
                                    
                                });
                            }
                            
                        }else{
                            BAlertModal.sharedInstance().makeToast("您尚未创建电话本，请登录后台创建");
                        }
                        
                    }else{
                        print("数据异常");
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
    func checkTelBookDBShouldUpDate(telBookID:Int,successHandler:@escaping ()->Void) {
        print("检查电话本是否有新数据更新");
        BNetWorkingManager.shared.request(url: "\(TelBook_Detail_URL)/\(telBookID)", method: .get, completionHandler: { (response) in
            if let value = response.result.value as? NSDictionary{

                if let error = value["error"]{
                    
                    let errorStr = error as! String;
                    if errorStr.components(separatedBy: "登录超时").count>1{
                        AppLoginHelper.loginForTimeOut(successHandler: {
                            self.checkTelBookDBShouldUpDate(telBookID: telBookID, successHandler: successHandler)
                        })
                    }else{
                        BAlertModal.sharedInstance().makeToast("登录失败：\(error)，请退出重新登录。");
                    }
                    
                }else{
                    if let telbook = value["telBook"] as? Dictionary<String,Any>{
                        if let webTelbookModel = TelBookModel.deserialize(from: telbook){
                            
                            let webInfomation = Int(webTelbookModel.information);
                            let localInfomation = Int(UserDefaults.standard.getTelBookModel()!.information);
                            
                            
                            if webInfomation! > localInfomation!{
                                
                                //需要更新数据库
                                let alert = UIAlertController(title: "提示", message: "电话本数据已变更，是否现在更新?", preferredStyle: .alert);
                                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                                    
                                    if self.checkTelBookExpired(expiredTime: webTelbookModel.expiredTime, timeNow: response.response?.allHeaderFields["Date"] as! String, days: 0){
                                        BAlertModal.sharedInstance().makeToast("电话本已过期,数据无法更新");
                                    }else{
                                        self.downLoadDB(telBook: webTelbookModel, finshedHandler: { (isSuccess) in
                                            
                                        })
                                        
                                    }
                                    
                                })
                                let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (action) in
                                })
                                alert.addAction(action);
                                alert.addAction(cancle);
                                self.present(alert, animated: true, completion: {
                                    
                                });
                            }
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
    
    
    /// 下载telBook对应的db文件
    ///
    /// - Parameter telBook: telBook
    func downLoadDB(telBook:TelBookModel, finshedHandler:@escaping (_ isSuccess:Bool)->Void)  {
        print("开始下载数据库文件");
        BHudView.showHud(in: self.view);
        
        let fileName =  DBHelper.sharedInstance.getDBSaveName(telBook: telBook);
        let url = "\(DownLoadDB_URL)/\(telBook.id!)"
       
        BNetWorkingManager.shared.download(url:url, method: .get, parameters: nil, progress: { (progress) in
            print("\(progress.completedUnitCount)/\(progress.totalUnitCount)");
        }, toLocalPath: DBFileSavePath,fileName:fileName) { (response) in
            BHudView.hideHud(in: self.view);
             if let data =  response.result.value {
                print("文件下载成功:\(data.count)");
                //下载成功后重新设置本地的telBook
                UserDefaults.standard.setTelBookModel(model: telBook);
                finshedHandler(true);
            }else{
                finshedHandler(false);
                BAlertModal.sharedInstance().makeToast("文件下载失败");
            }
        }
    }
    
    
    /// 判断电话本是否过期，如果timeNow == ""则根据 days判断
    ///
    /// - Parameters:
    ///   - expiredTime: 过期时间
    ///   - timeNow: 现在时间
    ///   - days: 剩余天数
    /// - Returns: 是否过期
    func checkTelBookExpired(expiredTime:TimeInterval,timeNow:String,days:Int) -> Bool {
        
        if timeNow == "" {
            
            if days <= 3{
                BAlertModal.sharedInstance().makeToast("电话本使用即将到期，请您尽快续费!");
            }
            return days == 0;
        }else{
            let now = BDateTool.sharedInstance.dateFromGMTTimeString(timeString: timeNow);
            let timeNowTimeInterval = BDateTool.sharedInstance.timeIntervalSince1970FromDate(date: now);
            
            if expiredTime - timeNowTimeInterval < 3*24*60*60*1000 {
                BAlertModal.sharedInstance().makeToast("电话本使用即将到期，请您尽快续费!");
            }
            
            
            return expiredTime - timeNowTimeInterval < 0;
        }
        
        
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

    
//    func getDBSaveName(telBook:TelBookModel) -> String {
//        return "\(telBook.bookName!)_\(telBook.id!).db";
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
   

}
