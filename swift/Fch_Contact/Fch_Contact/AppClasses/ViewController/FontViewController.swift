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
    
    let dataArray = ["小","中","大"]
    
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped);
        table.showsVerticalScrollIndicator = false;
        table.showsHorizontalScrollIndicator = false;
//        table.estimatedRowHeight = 30;
        table.delegate = self;
        table.dataSource = self;
        table.register(FontTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = UITableViewAutomaticDimension;
        //        table.separatorStyle = .none;
        table.backgroundColor  = BGlobalGrayColor();
        table.tableFooterView = UIView();
        
        
        
        return table;
    }();
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "字体大小";
        
        
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
        
        cell.coloumLable1?.text = dataArray[indexPath.row];
        if indexPath.row == 0 {
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 11);
        }else if indexPath.row == 1{
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 13);
        }else{
            cell.coloumLable1?.font = UIFont.systemFont(ofSize: 15);
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var fontSize:CGFloat = 13.0;
        if indexPath.row == 0 {
            fontSize = 11;
        }else if indexPath.row == 1{
             fontSize = 13;
        }else{
             fontSize = 15;
        }
        let userSettingModel = UserDefaults.standard.getUserSettingModel();
        userSettingModel.fontSize = fontSize;
        UserDefaults.standard.setUserSettingModel(model: userSettingModel);
        NotificationCenter.default.post(name: changeFontNotificationName, object: nil);
        
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
