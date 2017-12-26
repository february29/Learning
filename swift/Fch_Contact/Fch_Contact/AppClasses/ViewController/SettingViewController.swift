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
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
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
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    

}
