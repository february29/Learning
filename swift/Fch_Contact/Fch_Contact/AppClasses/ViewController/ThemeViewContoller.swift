//
//  ThemeViewContoller.swift
//  Fch_Contact
//
//  Created by bai on 2018/1/30.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

import SnapKit

class ThemeViewContoller: BBaseViewController ,UITableViewDelegate,UITableViewDataSource{
//    case white
//    case black
//    case green
//    case red
//    case blue
//    case purple
//    case pink
    
    
    let dataArray =
        [Theme.white,
         Theme.black,
         Theme.green,
        Theme.red,
        Theme.blue,
        Theme.purple,
        Theme.pink]
    
    
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
        table.tableFooterView = UIView();
        
        
        
        return table;
    }();
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = BLocalizedString(key: "Theme");

        
        self.view.addSubview(self.tableView);
        
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview();
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FontTableViewCell.init(style: .default, reuseIdentifier: "cell");
        
        cell.coloumLable1?.text = dataArray[indexPath.row].displayName;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        ColorCenter.shared.theme = dataArray[indexPath.row] ;
        
       
        let setting =  UserDefaults.standard.getUserSettingModel()
        setting.theme = dataArray[indexPath.row];
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

