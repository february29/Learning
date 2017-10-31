//
//  MainViewController.swift
//  ReactiveCocoaDemo
//
//  Created by bai on 2017/10/27.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import SnapKit
import BAlertView


class MainViewController: BBaseViewController ,UITableViewDelegate,UITableViewDataSource{

  
    var mTableView: UITableView {
        let tableView = UITableView();
        tableView.showsHorizontalScrollIndicator = false;
        tableView.showsVerticalScrollIndicator = false;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .none;
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            sleep(2);
            tableView.mj_header.endRefreshing();
        });
        view.addSubview(tableView);
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        
        return tableView;
    }
    
    let dataArray = ["12","2"];
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "hellow";
        
        mTableView.isHidden = false;
        
        mTableView.rx
        
        
        
//        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 45));
////        view.layer.borderWidth = 1;
//        view.backgroundColor = UIColor.green;
//        view.layer.borderColor = UIColor.black.cgColor;
//        view.layer.borderWidth = 1.0;
//        view.b_clipRectCorner(direction:.topLeft , cornerRadius: 10);
//        self.view.addSubview(view);
//        
//        
//        
//        userNameTextField.placeholder = "userName";
//        userNameTextField.layer.cornerRadius = 5;
//        userNameTextField.layer.borderColor = UIColor.darkGray.cgColor;
//        userNameTextField.layer.borderWidth = 1.0;
//        userNameTextField.textAlignment = NSTextAlignment.center;
//        self.view.addSubview(userNameTextField);
//        userNameTextField.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view);
//            make.width.equalTo(200);
//            make.height.equalTo(45);
//            make.top.equalTo(self.view).offset(100);
//            
//        }
//        
//        passWordTextfield.placeholder = "passWord";
//        passWordTextfield.layer.cornerRadius = 5;
//        passWordTextfield.layer.borderColor = UIColor.darkGray.cgColor;
//        passWordTextfield.layer.borderWidth = 1.0;
//        passWordTextfield.textAlignment = NSTextAlignment.center;
//        self.view.addSubview(userNameTextField);
//        userNameTextField.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view);
//            make.width.equalTo(200);
//            make.height.equalTo(45);
//            make.top.equalTo(userNameTextField.snp.bottom).offset(100);
//            
//        }
//        
//        let disposeBag = DisposeBag()
//
//        Observable<Int>.empty()
//            .subscribe { event in
//                print(event)
//            }
//            .addDisposableTo(disposeBag)
//        
//        
//        let neverSequence = Observable<String>.never()
        
        
//        Observable.just("2","3","3").subscribe { (event) in
//            print(event);
//        }.addDisposableTo(dis)
        
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
            .subscribe { event in
                print(event)
        }
        
        Thread.sleep(forTimeInterval: 2.0)
        
        subscription.dispose()

        
//        Observable
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell(style:.default, reuseIdentifier: "cell");
        }
        cell?.textLabel?.text = dataArray[indexPath.row];
        return cell!;
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("selected%d", indexPath.row);
    
        BAlertModal.sharedInstance().makeToast("selected index= \(indexPath.row)")
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
