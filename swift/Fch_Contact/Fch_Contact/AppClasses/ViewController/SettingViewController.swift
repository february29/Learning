//
//  SettingViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/22.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import BAlertView
import CallKit
import FMDB



class SettingViewController: BBaseViewController,UITableViewDelegate {
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped);
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;

        table.setSeparatorColor(.primary);
        table.setBackgroundColor(.tableBackground);
        table.tableFooterView = UIView();
//        table.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//
//
//
//
//
//        });
        
        
        return table;
    }();
    
    
    
    
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,SettingCellModel >>(configureCell: { ds, tv, idx, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! SettingTableViewCell;
        
        cell.coloumLable1?.text = item.lab;
        cell.infoLable?.text = item.info; //后期修改这里能显示但是不会根据字体颜色变化而变化
        cell.arrowImageView?.isHidden = !item.showArrow!;
        return cell;
    },titleForHeaderInSection: { dataSource, index in
        let section = dataSource[index];
        
        return section.model;
    })
    
    
    let viewModel = SettingViewModel();
    let disposeBag = DisposeBag();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = BLocalizedString(key: "Setting");
        
        
        self.view.addSubview(self.tableView);
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        bindViewModel();
        
        
    }
    
    // MARK: VM绑定
    func bindViewModel()  {
//        tableView.rx.items(dataSource: dataSource)
//        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource))
        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
        self.viewModel.reloadData();
    }
    
    // MARK: tableview 代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if indexPath.section == 0 {
            if indexPath.row == 0{

                let  vc  = FontViewController();
                self.navigationController!.pushViewController(vc, animated: true);
                
            }else if indexPath.row == 1{
                let  vc  = ThemeViewContoller();
                self.navigationController!.pushViewController(vc, animated: true);
            }
        } else if indexPath.section == 1{
            if indexPath.row == 0 {
            
                //打开来电提示
                CallDirectoryExtensionHelper.sharedInstance.checkCallKitOpen(finishedHandler: { (support,isOpen) in
                    
                    if support {
                        if isOpen{
                            BAlertModal.sharedInstance().makeToast("已开启");
                        }else{
                           
                            self.showAlert(title: "授权", message: "请在设置->电话->来电阻止与身份识别开启相关权限", okTitle: "去设置", OkHandler: {
                                let url = URL(string: "prefs:root=Phone");
                                if UIApplication.shared.canOpenURL(url!){
                                    UIApplication.shared.openURL(url!);
                                }
                                
                            })
                            
                        }
                        
                       
                    }else{
                        BAlertModal.sharedInstance().makeToast("该功能适用于iOS10及以上版本系统");
                    }
                })
                
            }else if indexPath.row == 1{
                //更新来电提示
                
                CallDirectoryExtensionHelper.sharedInstance.checkCallKitOpen(finishedHandler: { (support,isOpen) in
                    
                    if support {//支持
                        if isOpen{//已打开
                            //更新数据
                            CallDirectoryExtensionHelper.sharedInstance.reloadExtension(completeHandler: { (support, error) in
                                    if error == nil{
                                        BAlertModal.sharedInstance().makeToast("数据更新成功");
                                    }else{
                                        BAlertModal.sharedInstance().makeToast("数据更新失败");
                                    }
                            })
                        }else{//未打开
                            
                            self.showAlert(title: "授权", message: "请在设置->电话->来电阻止与身份识别开启相关权限", okTitle: "去设置", OkHandler: {
                                let url = URL(string: "prefs:root=Phone");
                                if UIApplication.shared.canOpenURL(url!){
                                    UIApplication.shared.openURL(url!);
                                }
                                
                            })
                            
                        }
                    }else{//不支持
                        
                        BAlertModal.sharedInstance().makeToast("该功能适用于iOS10及以上版本系统");
                    }
                })
                
               
            }
        }else if indexPath.section == 3{
            if indexPath.row == 0{
                
                
                let loginView = LoginView(frame: CGRect(x: 0, y: 0, width:BSCREENW*0.8 , height: 175))
                
                loginView.loginCompleteHandler = { (loginIn) in
                    
                    if(loginIn){
                        UIApplication.shared.keyWindow?.endEditing(true);
//                        BAlertModal.sharedInstance().hide(animated: true, withCompletionBlock: {
//                            BAlertModal.sharedInstance().makeToast("登录成功", disPlayStyle: .top)
//
//
//                        })
                        BAlert.sharedInstance.hide(view: loginView,  finishedHandle: {
                            BAlertModal.sharedInstance().makeToast("登录成功", disPlayStyle: .top)
                        })
                    }else{
                        
                        
                        BAlertModal.sharedInstance().makeToast("登录失败", disPlayStyle: .top)
                    }
                    
                    
                };
                
                BAlert.sharedInstance.normalShow(view: loginView);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = dataSource[section];
        let sectionHead = UILabel();
        sectionHead.setBackgroundColor(.secondary);
        sectionHead.setTextColor(.primary);
        sectionHead.setTextFontSize(type: .senondary);
        sectionHead.text = data.model;
        return sectionHead;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView();
        
    }
    
    
    // MARK: call directoryextension
    
   
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
    
    

}
