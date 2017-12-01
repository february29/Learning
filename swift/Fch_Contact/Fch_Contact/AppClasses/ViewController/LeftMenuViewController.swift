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

class LeftMenuViewController: BBaseViewController,UITableViewDelegate {
    
    
    let viewModel = LeftMemuViewModel();
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, DeptModel>>(configureCell: { ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "LeftDeptTableViewCell") as! LeftDeptTableViewCell;
        cell.coloumLable1?.text = item.name;
        return cell;
    });
    
    let disposeBag = DisposeBag();
    
    
    
    lazy var tableView:UITableView = {
        let table = UITableView();
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.register(LeftDeptTableViewCell.self, forCellReuseIdentifier: "LeftDeptTableViewCell")
        table.rowHeight = UITableViewAutomaticDimension;
        table.tableFooterView = UIView();
        return table;
    }();
    
    // MARK: tableview 代理
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView);
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
    
        self.bindViewModel();
        
    }
    
    func bindViewModel()  {
        viewModel.result?.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
