//
//  MainViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import BAlertView
import RxCocoa
import RxSwift
import RxDataSources
import MJRefresh
import WebKit

class MainViewController: BBaseViewController,UITableViewDelegate,LeftMemuViewDelegate{
    
    
    
    var webView = UIWebView();

    lazy var tableView:UITableView = {
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
        table.tableFooterView = UIView();
        table.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            //这里应该在判断一次是否过期...
            
            self.downLoadDB(telBook: UserDefaults.standard.getTelBookModel()!,showHud: false,finshedHandler: { (isSuccess) in
                
            })
            
        });
        
        
        return table;
    }();
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PersonModel>>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell;
        cell.coloumLable1?.text = item.column1;
        cell.coloumLable2?.text = item.column2;
        cell.coloumLable3?.text = item.column3;
        cell.coloumLable4?.text = item.column4;
        cell.coloumLable5?.text = item.column5;
        return cell;
    },titleForHeaderInSection: { dataSource, index in
        let section = dataSource[index];
        return section.model;
    })
    
    
//    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PersonModel>>(configureCell: { ds, tv, ip, item in
//        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell;
//        cell.coloumLable1?.text = item.column1;
//        cell.coloumLable2?.text = item.column2;
//        cell.coloumLable3?.text = item.column3;
//        cell.coloumLable4?.text = item.column4;
//        cell.coloumLable5?.text = item.column5;
//        return cell;
//    });
    
    


    
    
   
    
    
    let viewModel = MainViewModel();
    let disposeBag = DisposeBag();
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "风驰电话本";
        self.navigationController?.isNavigationBarHidden = false;
        
        self.view.addSubview(self.tableView);
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        bindViewModel();
        
        
        
        
        //已经设置电话本
        if let telBook = UserDefaults.standard.getTelBookModel() {
            
            checkTelBookDBShouldUpDate(telBookID: telBook.id, successHandler: {
                
            });
            
            
            
            
        }else{
            if let user = UserDefaults.standard.getUserModel(){
                getUserTelBooks(userId: user.id, successHandler: {
                    
                })
            }
           
        }
    
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        NotificationCenter.default.addObserver(forName: relodDataNotificationName, object: nil, queue: nil) { (notifaction) in
            self.viewModel.reloadData(depId: -1);
            self.tableView.reloadData();
            self.tableView.mj_header.endRefreshing();
        }
        
        NotificationCenter.default.addObserver(forName: showAllDataNotificationName, object: nil, queue: nil) { (notifaction) in
            self.viewModel.reloadData(depId: -1);
            self.tableView.reloadData();
            self.tableView.mj_header.endRefreshing();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        NotificationCenter.default.removeObserver(self);
    }
    
    
    // MARK: VM绑定
    func bindViewModel()  {
        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
        self.viewModel.reloadData(depId: -1);
    }
    
    
    // MARK: tableView代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personModel = dataSource[indexPath];
        let url =  URL(string: "tel:" + personModel.column3);
//        let webView = WKWebView();
//        webView.load(URLRequest(url: url!));
    
        
        webView.loadRequest(URLRequest(url: url!));
        self.view.addSubview(webView);
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25;
    }

    
    // MARK: 左侧菜单代理
    func depSelected(dept: DeptModel, idx: IndexPath) {
        self.viewModel.reloadData(depId: dept.id);
        self.tableView.reloadData();
//        self.tableView.setContentOffset(CGPoint(x:0,y:0), animated: true);
//        var offset = self.tableView.contentOffset;
//        offset.y = self.tableView.contentInset.top;
//        self.tableView.setContentOffset(offset, animated: true);
    }
    // MARK: 网络请求
    
    
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
                               
                                if self.checkTelBookExpired(expiredTime:0, timeNow: "",days: (telbooks[0]?.days)!){
                                    UserDefaults.standard.setTelBookModel(model:telBook);
                                    self.downLoadDB(telBook: telBook,showHud: true, finshedHandler: { (isSuccessful) in
                                        
                                    });
                                }else{
                                    BAlertModal.sharedInstance().makeToast("电话本已过期，请续费后使用！")
                                }
                                
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
                                        self.downLoadDB(telBook: webTelbookModel,showHud: true, finshedHandler: { (isSuccess) in
                                           
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
    func downLoadDB(telBook:TelBookModel?,showHud:Bool, finshedHandler:@escaping (_ isSuccess:Bool)->Void)  {
        print("开始下载数据库文件");
        
        if let telBookModel = telBook {
           
            if showHud {
                BHudView.showHud(in: self.view);
            }
            
            let fileName =  DBHelper.sharedInstance.getDBSaveName(telBook: telBookModel);
            let url = "\(DownLoadDB_URL)/\(telBookModel.id!)"
            
            BNetWorkingManager.shared.download(url:url, method: .get, parameters: nil, progress: { (progress) in
                print("\(progress.completedUnitCount)/\(progress.totalUnitCount)");
            }, toLocalPath: DBFileSavePath,fileName:fileName) { (response) in
                if showHud {
                    BHudView.hideHud(in: self.view);
                }
                if let data =  response.result.value {
                    print("文件下载成功:\(String(describing: DBFileSavePath))\(fileName)\\n size:\(data.count)");
                    //下载成功后重新设置本地的telBook  防止重复提示新数据
                    UserDefaults.standard.setTelBookModel(model: telBookModel);
                    //发送通知 刷新数据
                    NotificationCenter.default.post(name:relodDataNotificationName, object: nil);
                    finshedHandler(true);
                }else{
                    finshedHandler(false);
                    BAlertModal.sharedInstance().makeToast("文件下载失败");
                }
            }
        }else{
            finshedHandler(false);
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
            return days > 0;
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
