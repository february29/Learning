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
import FMDB
import Alamofire

class MainViewController: BBaseViewController,UITableViewDelegate,LeftMemuViewDelegate,RightViewControllerDelegate{
   
    
    
    
    
    var webView = UIWebView();

    lazy var tableView:UITableView = {
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.rowHeight = UITableViewAutomaticDimension;
        table.delegate = self;
        table.setBackgroundColor(.tableBackground);
        table.setSeparatorColor(.primary);
        table.setSectionIndexColor(.primary);
//        table.sectionIndexMinimumDisplayRowCount = 2;
        table.sectionIndexBackgroundColor = UIColor.clear;
        table.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        table.tableFooterView = UIView();
        table.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            
            //这里应该在判断一次是否过期...
            //验证imei
            self.viewModel.fchCheckImeiVerify(successHandler: { (isVerify) in
                
                if isVerify {
                    self.viewModel.downLoadDB(telBook: UserDefaults.standard.getTelBookModel()!,finshedHandler: { (isSuccess) in
                        self.tableView.mj_header .endRefreshing();
                    })
                }else{
                    self.tableView.reloadData();
                    self.tableView.mj_header.endRefreshing();
                    BAlertModal.sharedInstance().makeToast("客户端验证imei失败");
                }
                
            })
            
           
            
        });
//        table.rx.modelSelected(PersonModel.self).subscribe(onNext: { (model) in
//            print("dfsdfasd")
//        }).disposed(by: disposeBag);
//
        
        return table;
    }();
    
    lazy var menuView: RightMenuView = {
        let menuView =  RightMenuView();
        if UIDevice.isIPhoneX() {
            menuView.frame = CGRect(x: BSCREENW-95, y: 88, width: 85, height: 100)
        }else{
            menuView.frame = CGRect(x: BSCREENW-95, y: 64, width: 85, height: 100);
        }
        
        
        menuView.seletedHandle = {(idx) in
            if idx == 0 {
                
                BAlert.sharedInstance.hide(view: menuView);
                self.viewModel.fchCheckImeiVerify(successHandler: { (isVerify) in
                    
                    if isVerify {
                        BHudView.showHud(in: self.navigationController?.view);
                        self.viewModel.downLoadDB(telBook: UserDefaults.standard.getTelBookModel()!,finshedHandler: { (isSuccess) in
                            BHudView.hideHud(in: self.navigationController?.view);
                        })
                    }else{
                        
                        BAlertModal.sharedInstance().makeToast("客户端验证imei失败");
                    }
                    
                })
                
                
                
            }else if idx == 1 {
                
                BAlert.sharedInstance.hide(view: menuView, finishedHandle: {
                    let settingVC = ShareViewController();
                    self.navigationController?.pushViewController(settingVC, animated: true);
                })
            }else if idx == 2 {
                BAlert.sharedInstance.hide(view: menuView, finishedHandle: {
                    let settingVC = SettingViewController();
                    self.navigationController?.pushViewController(settingVC, animated: true);
                })
               
            }
        };
        return menuView;
    }()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PersonModel>>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell;
        cell.coloumLable1?.text = item.column1;
        cell.coloumLable2?.text = item.column2;
        cell.coloumLable3?.text = item.column3;
        cell.coloumLable4?.text = item.column4;
        cell.coloumLable5?.text = item.column5;
        return cell;
    },titleForHeaderInSection: { dataSource, section in
        let section = dataSource[section];
        return section.model;
    },sectionIndexTitles:{ds in
        //索引
        if ds.sectionModels.count<2 {
            return nil;
        }
        
        return ds.sectionModels.map({ (model) -> String in
            model.model;
        });
    },sectionForSectionIndexTitle:{ds,title,index in
        //索引点击
        return index;
    })
    
   
    
    
    let viewModel = MainViewModel();
    let disposeBag = DisposeBag();
    
    
    // MARK: 周期函数

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = BLocalizedString(key: "FCHContact")
        self.navigationController?.isNavigationBarHidden = false;
        
        let leftBtnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_top_menu"), style: .plain, target: self, action: #selector(BBaseViewController.back));
        leftBtnItem.setTintColor(.navBarBtn);
        self.navigationItem.leftBarButtonItem = leftBtnItem;
        
        //右侧按钮

        let rightBtnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "btn_top_add"), style: .plain, target: self, action: #selector(MainViewController.showRightMenu))
        rightBtnItem.setTintColor(.navBarBtn);
        self.navigationItem.rightBarButtonItem = rightBtnItem;
        
        
        self.view.addSubview(self.tableView);
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        bindViewModel();
        
        
        
    
        //注册通知
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
        
//        self.getDataFromDB();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
//    //状态栏黑色
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return UIStatusBarStyle.default;
//    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        NotificationCenter.default.removeObserver(self);
    }
    
    
    // MARK: VM绑定
    func bindViewModel()  {
        // 列表数据绑定
        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
        self.viewModel.reloadData(depId: -1);
       
        
        //app更新数据绑定
        viewModel.checkAppShouldUpdateResult?.subscribe(onNext: { (result) in
            
            let value =  result.value as! NSDictionary
            if let error = value ["error"]  {
                let errorStr = error as! String;
                if errorStr.components(separatedBy: "登录超时").count>1{
                    AppLoginHelper.loginForTimeOut(successHandler: {
                        self.viewModel.checkAppShouldUpdateSubject.onNext(true);
                    })
                }else{
                    BAlertModal.sharedInstance().makeToast("登录失败：\(error)，请退出重新登录。");
                }
            }else{
                if let app = value["app"]as? Dictionary<String,Any>  {
                    let webVersion =  app["iosVersion"] as! String;
                    let iosUrl = app["iosUrl"] as! String;
                    let localVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String;
                    if  webVersion.compare(localVersion) == .orderedDescending{
                        self.showAlert(title: nil, message: "客户端有新版本，是否现在更新?",  cancleTitle: "下次再说", okTitle: "更新", cancleHandler: nil, OkHandler: {
                             UIApplication.shared.openURL(URL.init(string: iosUrl)!);
                        });
                    }else{
                        print("不需要更新");
                    }
                }
            }
        }, onError: { (error) in
            BAlertModal.sharedInstance().makeToast("网络异常");
        }).disposed(by: disposeBag);
        
        self.viewModel.checkAppShouldUpdateSubject.onNext(true);
        
        
        if (UserDefaults.standard.getTelBookModel() == nil){
            print("未设置电话本");
            self.bingdingTelBookListResult();
            return
        }else{
            self.bindingTelBookUpdateResult();
        }
        
    }
    
   
    
    /// 获取电话本列表（首次登录未设置本地电话本时调用） 数据绑定
    func bingdingTelBookListResult()  {
        guard let userId = UserDefaults.standard.getUserModel()?.id else { return  }
        
        viewModel.telBookListResult?.subscribe(onNext: { (result) in
            let value = result.value as! NSDictionary
            if let error = value["error"] {
                let errorStr = error as! String;
                if errorStr.components(separatedBy: "登录超时").count>1{
                    AppLoginHelper.loginForTimeOut(successHandler: {
                        self.viewModel.telBookListSubject.onNext(userId)
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
                            
                            if self.viewModel.checkTelBookExpired(expiredTime:0, timeNow: "",days: (telbooks[0]?.days)!){
                                UserDefaults.standard.setTelBookModel(model:telBook);
                                self.viewModel.fchCheckImeiVerify(successHandler: { (isVerify) in
                                    
                                    if isVerify {
                                        BHudView.showHud(in: self.navigationController?.view);
                                        self.viewModel.downLoadDB(telBook: telBook,finshedHandler: { (isSuccessful) in
                                            
                                            BHudView.hideHud(in: self.navigationController?.view);
                                            
                                        });
                                    }else{
                                        BAlertModal.sharedInstance().makeToast("客户端验证imei失败");
                                    }
                                })
                                
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
            
        }, onError: { (error) in
            
            BAlertModal.sharedInstance().makeToast("网络异常");
        }).disposed(by: disposeBag);
        
        self.viewModel.telBookListSubject.onNext(userId);
    }
    
    
    /// 判断是否需要数据更新结果绑定，设置本地电话本后掉用。
    func bindingTelBookUpdateResult()  {
        
        guard let telBookId = UserDefaults.standard.getTelBookModel()?.id else {
            print("未设置电话本");
            return
        }
        
        //电话本db文件是否更新数据绑定
        viewModel.telBookDBShouldUpDateResult?.subscribe(onNext: { (result) in
            let value = result.value as! NSDictionary
            if let error = value["error"]{
                
                let errorStr = error as! String;
                if errorStr.components(separatedBy: "登录超时").count>1{
                    AppLoginHelper.loginForTimeOut(successHandler: {
                        self.viewModel.telBookDBShouldUpDateSubject.onNext(telBookId)
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
                            self.showAlert(title: "提示", message: "电话本数据已变更，是否现在更新?",  cancleTitle: "下次再说", okTitle: "更新数据", OkHandler: {
                                //验证imei
                                self.viewModel.fchCheckImeiVerify(successHandler: { (isVerify) in
                                    if isVerify {
                                        BHudView.showHud(in: self.navigationController?.view);
                                        self.viewModel.downLoadDB(telBook: webTelbookModel, finshedHandler: { (isSuccess) in
                                            BHudView.hideHud(in: self.navigationController?.view);
                                        })
                                    }else{
                                        BAlertModal.sharedInstance().makeToast("客户端验证imei失败");
                                    }
                                    
                                })
                            })
                        }
                    }
                    
                }else{
                    BAlertModal.sharedInstance().makeToast("数据异常");
                }
            }
        }, onError: { (error) in
            BAlertModal.sharedInstance().makeToast("网络异常");
        }).disposed(by: disposeBag);
        self.viewModel.telBookDBShouldUpDateSubject.onNext(telBookId)
        
    }
    
    
    
    
    // MARK: tableView代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personModel = dataSource[indexPath];
        let url =  URL(string: "tel:" + personModel.column3);
        
        
        let alertVC = UIAlertController(title:BLocalizedString(key: "Call phone?") , message: nil, preferredStyle: .actionSheet)
        var phoneArray = [String]();
        
        
        
       
        
        if personModel.column3 != nil && personModel.column3.isFchPhone {
            phoneArray.append(personModel.column3)
        }
        if personModel.column4 != nil && personModel.column4.isFchPhone {
            phoneArray.append(personModel.column4)
        }
        if personModel.column5 != nil && personModel.column5.isFchPhone {
            phoneArray.append(personModel.column5)
        }

        
        if phoneArray.count == 1 {
            webView.loadRequest(URLRequest(url: url!));
            self.view.addSubview(webView);
            
        }else{
            for phoneString in phoneArray {
                let action = UIAlertAction(title: phoneString, style: .default, handler: { (action) in
                    self.webView.loadRequest(URLRequest(url: url!));
                    self.view.addSubview(self.webView);
                    
                })
                alertVC.addAction(action);
                
            }
            alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            self.present(alertVC, animated: true, completion: nil);
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataSource.sectionModels.count<2 {
            return 0;
        }
        
        return 25;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = dataSource[section];
        let sectionHead = UILabel();
        sectionHead.setBackgroundColor(.secondary);
        sectionHead.setTextColor(.primary);
        sectionHead.setTextFontSize(type: .senondary);
        sectionHead.text = "   \(data.model)";
        return sectionHead;
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
    
    // MARK: 右侧搜索代理
    func shouldSearchFor(searchString: String) {
        
        if searchString.toNSString.length>0 {
            viewModel.reloadData(searchString: searchString);
        }else{
            viewModel.reloadData(depId: -1);
        }
        
        self.tableView.reloadData();
    }
    // MARK: 显示右侧菜单
    @objc func showRightMenu() {
        
//        let config = BAlertConfig()
//        config.b_AnimationTime = 5;
        
        BAlert.sharedInstance.show(view: menuView, config: nil, showHandler: { (view, config) in
            // 显示动画
            let animation1 = CABasicAnimation(keyPath: "position.y");
            animation1.fromValue = view.frame.origin.y;
            animation1.toValue = view.centerY;
            animation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            let animation2 = CABasicAnimation(keyPath: "position.x");
            animation2.fromValue = view.frame.origin.x+view.frame.width;
            animation2.toValue = view.centerX;
            animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            
            let animation3 = CABasicAnimation(keyPath: "transform.scale");
            animation3.fromValue = 0;
            animation3.toValue = 1;
            animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            let animations = CAAnimationGroup();
            animations.duration = config.b_AnimationTime!;
            animation2.fillMode = kCAFillModeForwards;
            animation2.isRemovedOnCompletion = false;
            animations.animations = [animation1,animation2,animation3];
            view.layer.add(animations, forKey: "startAn");
        }) { (view, config) in
            // 隐藏动画
            let animation1 = CABasicAnimation(keyPath: "position.y");
            animation1.fromValue = view.centerY;
            animation1.toValue = view.frame.origin.y;
            animation1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            let animation2 = CABasicAnimation(keyPath: "position.x");
            animation2.fromValue = view.centerX;
            animation2.toValue = view.frame.origin.x+view.frame.width ;
            animation2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            let animation3 = CABasicAnimation(keyPath: "transform.scale");
            animation3.fromValue = 1;
            animation3.toValue = 0;
            animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
            
            let animations = CAAnimationGroup();
            animations.duration = config.b_AnimationTime!;
            animation2.fillMode = kCAFillModeForwards;
            animation2.isRemovedOnCompletion = false;
            animations.animations = [animation1,animation2,animation3];
            
            view.layer.add(animations, forKey: "hideAn");
        };
       
    }
    
    // MARK: 网络请求
    
    
    
   
    
    /// 获取用户电话本列表
    ///风驰电话本
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
                               
                                if self.viewModel.checkTelBookExpired(expiredTime:0, timeNow: "",days: (telbooks[0]?.days)!){
                                    UserDefaults.standard.setTelBookModel(model:telBook);
                                    
                                    
                                    self.viewModel.fchCheckImeiVerify(successHandler: { (isVerify) in
                                        
                                        if isVerify {
                                            BHudView.showHud(in: self.navigationController?.view);
                                            self.viewModel.downLoadDB(telBook: telBook,finshedHandler: { (isSuccessful) in
                                                
                                                BHudView.hideHud(in: self.navigationController?.view);
                                                
                                            });
                                        }else{
                                            BAlertModal.sharedInstance().makeToast("客户端验证imei失败");
                                        }
                                    })

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
    
    
    //返回按钮打开侧滑菜单
    override func back() {
        let sliderVC = self.sliderVC();
        if  sliderVC.state == .OpenLeft{
            self.sliderVC().hideLeftMenu();
        }else if sliderVC.state == .Close{
            self.sliderVC().showLeftMenu();
        }
        
    }

}
