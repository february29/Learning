//
//  FontViewController.swift
//  Fch_Contact
//
//  Created by bai on 2018/1/15.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import SnapKit

class FontViewController: BBaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let dataArray = [FontSize.small,FontSize.middle,FontSize.large]
    
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped);
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
//        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.dataSource = self;
        table.setBackgroundColor(.tableBackground);
        table.setSeparatorColor(.primary);
        table.register(FontTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
        //        table.separatorStyle = .none;
        
        table.tableFooterView = UIView();
        
        
        
        return table;
    }();
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = BLocalizedString(key: "Font Size");

        self.view.addSubview(self.tableView);
        

        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview();
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FontTableViewCell.init(style: .default, reuseIdentifier: "cell");
        
        cell.coloumLable1?.text = dataArray[indexPath.row].displayName;
        
        if indexPath.row == 0 {
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 11);
        }else if indexPath.row == 1{
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 13);
        }else{
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 15);
        }
        
//        cell.setSelected(true, animated: false);
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        FontCenter.shared.fontSize = dataArray[indexPath.row] ;
        let setting =  UserDefaults.standard.getUserSettingModel()
        setting.fontSize = dataArray[indexPath.row];
        UserDefaults.standard.setUserSettingModel(model: setting);
       
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45;
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  

}
