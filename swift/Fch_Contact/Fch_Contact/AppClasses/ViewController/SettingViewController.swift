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


class SettingViewController: BBaseViewController,UITableViewDelegate {
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped);
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
//        table.separatorStyle = .none;
        table.backgroundColor  = BGlobalGrayColor();
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
    
    
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String >>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell") as! SettingTableViewCell;
        cell.coloumLable1?.text = item;
        return cell;
    },titleForHeaderInSection: { dataSource, index in
        let section = dataSource[index];
        
        return section.model;
    })
    
    
    let viewModel = SettingViewModel();
    let disposeBag = DisposeBag();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置";
        leftBtn?.setImage(UIImage.init(named: "btn_top_back"), for: .normal);
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
                let userSettingModel = UserDefaults.standard.getUserSettingModel();
                userSettingModel.fontSize = userSettingModel.fontSize + 2;
                UserDefaults.standard.setUserSettingModel(model: userSettingModel);
                NotificationCenter.default.post(name: changeFontNotificationName, object: nil);
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
        sectionHead.backgroundColor = BGlobalGrayColor();
        sectionHead.textColor = BGlobalRedColor();
        sectionHead.text = data.model;
        return sectionHead;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}
