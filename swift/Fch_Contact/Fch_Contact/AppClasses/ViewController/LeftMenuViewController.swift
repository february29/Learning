//
//  LeftMenuViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


protocol LeftMemuViewDelegate {
    func depSelected(dept:DeptModel ,idx:IndexPath);
    
}

class LeftMenuViewController: BBaseViewController,UITableViewDelegate {
    
    
    var menuSelectedDelegate:LeftMemuViewDelegate?
    
    
    let viewModel = LeftMemuViewModel();
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, DeptModel>>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "LeftDeptTableViewCell") as! LeftDeptTableViewCell;
        cell.coloumLable1?.text = item.name;
        return cell;
    });
    
    let disposeBag = DisposeBag();
    
    
    lazy var topbgImageView:UIImageView = {
        let bg = UIImageView();
        bg.image = UIImage.init(named: "bg_menu_head");
        return bg;
    }();
    
    lazy var topBtn:UIButton = {
        let btn = UIButton();
        btn.setTitle("公司架构", for: .normal);
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18);
        btn.setTitleColor(UIColor.white, for: .normal);
        let selector = #selector(self.cancelSelected);
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn;
    }();
    @objc func cancelSelected() {
        self.tableView.reloadData();
        self.sliderVC().hideLeftMenu();
        NotificationCenter.default.post(name: showAllDataNotificationName, object: nil);
    }
    
    lazy var bgImageView:UIImageView = {
        let bg = UIImageView(image:UIImage(named:"bg_memu"));
        return bg;
    }();
    lazy var tableView:UITableView = {
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.separatorStyle = .none;
        table.backgroundColor = UIColor.clear;
        table.register(LeftDeptTableViewCell.self, forCellReuseIdentifier: "LeftDeptTableViewCell")
        table.rowHeight = UITableViewAutomaticDimension;
        table.tableFooterView = UIView();
        return table;
    }();
    
    
    
    // MARK: tableview 代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = menuSelectedDelegate {
            delegate.depSelected(dept: dataSource[indexPath],idx: indexPath)
        }
        self.sliderVC().hideLeftMenu();
        
    }

    override func viewDidLoad() {
        super.viewDidLoad();
       
        self.view.addSubview(self.bgImageView);
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        self.view.addSubview(self.topbgImageView);
        topbgImageView.snp.makeConstraints { (make) in
            if UIDevice.isIPhoneX(){
                make.top.equalTo(self.view).offset(44);
            }else{
                make.top.equalTo(self.view).offset(20);
            }
            
            make.left.equalTo(self.view);
            make.height.equalTo(44);
            make.width.equalTo(120);
            
        }
        
        self.view.addSubview(self.topBtn);
        topBtn.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(self.topbgImageView);
            make.width.equalTo(110);
        }
        
        self.view.addSubview(tableView);
        tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view);
            make.top.equalTo(topbgImageView.snp.bottom);
        }
        
        
    
        
        
        self.bindViewModel();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        NotificationCenter.default.addObserver(forName: relodDataNotificationName, object: nil, queue: nil) { (notifaction) in
            self.viewModel.reloadData();
            self.tableView.reloadData();
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        NotificationCenter.default.removeObserver(self);
    }
    
    func bindViewModel()  {
        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
        self.viewModel.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
