//
//  LaunchViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class LaunchViewController: BBaseViewController,UIScrollViewDelegate{
    
    let lanuchImages = ["launch_1.jpg","launch_2.jpg","launch_3.jpg"];
    
    let dispose = DisposeBag();
    
    
    
    
    /// 懒加载创建
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.isPagingEnabled = true;
        scrollView.bounces = false
        scrollView.delegate = self;
        return scrollView
    }();

    
   
     lazy var  contentView: UIView  = {
        let tempContentView = UIView();
        return tempContentView;
     }();
    
    
    lazy var  userName: UITextField  = {
        let tf = UITextField();
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.placeholder = "用户名";
        tf.textAlignment = .center;
//        tf.layer.cornerRadius = 5;
        tf.background = UIImage.init(named: "bg_guide_text");
        
        return tf;
    }();
    lazy var  passWord: UITextField  = {
        let tf = UITextField();
        tf.font = UIFont.systemFont(ofSize: UIFont.systemFontSize);
        tf.placeholder = "密码";
        tf.textAlignment = .center;
//        tf.layer.cornerRadius = 5;
        tf.background = UIImage.init(named: "bg_guide_text");
        return tf;
    }();
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//             self.automaticallyAdjustsScrollViewInsets = NO;
//            self.navigationController.navigationBarHidden = NO;
        
        //防止scrollerview 中 contentview 出现在状态栏下方
        self.automaticallyAdjustsScrollViewInsets = false;

        
        setUpUI();
        
        
        
        
        
        let par = ["loginName":"风驰电话本",
                   "password":"jjy1117".md5];
        
        
//        BNetWorkingManager.shared.request(url: "userLogin", method:.post, parameters: par) { (response) in
//            
//            
//            
//            
//            
//        };
        
       
        
       
//        BNetWorkingManager.shared.RxRequset(url: "userLogin", method:.post, parameters: par)
//            .subscribe { (event) in
//                let userModel = UserModel();
//
////                userModel.mj_keyValues();
//
//            }.addDisposableTo(dispose);
        
        
        
//        BNetWorkingManager.get(url: "userLogin", parameters: par) { (response) in
//            
//        }

        
//        BNetWorkingManager.shared.RxRequsetString(url: "userLogin", method:.post, parameters: par).mapModel(UserModel.self)
//            .subscribe(onNext: { (model) in
//
//
//
//
//
//            })
//            .addDisposableTo(dispose);
        
        

       
        
//        BNetWorkingManager.shared.r(url: "userLogin", method:.post, parameters: par)
//            .mapModel(UserModel.self)
//            .subscribe { (event) in
//
//            }.addDisposableTo(dispose);
//
//
        
        
    }
    
    //布局
    func setUpUI() {
        //布局
        view.addSubview(scrollView);
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view);
        }
        
        let totlew = BSCREENW * CGFloat(lanuchImages.count);
        scrollView.addSubview(contentView);
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
            make.width.equalTo(totlew);
        }
        
        var tempView:UIView?;
        
        for imageStr in lanuchImages {
            let image = UIImage(named: imageStr);
            let imageView = UIImageView(image: image);
            contentView.addSubview(imageView);
            imageView.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(contentView);
                if tempView == nil{
                    make.left.equalTo(contentView);
                }else{
                    make.left.equalTo(tempView!.snp.right);
                }
                make.width.equalTo(BSCREENW);
                
            });
            tempView = imageView;
            
        }
        
        contentView .addSubview(userName);
        contentView.addSubview(passWord);
        
        passWord.snp.makeConstraints { (make) in
            make.bottom.equalTo((tempView ?? contentView).snp.bottom).offset(-20);
            make.centerX.equalTo(tempView ?? contentView);
            make.width.equalTo(200);
            make.height.equalTo(35);
        }
      
        userName.snp.makeConstraints { (make) in
            make.centerX.equalTo(passWord);
            make.bottom.equalTo(passWord.snp.top).offset(-10)
            make.width.equalTo(200);
            make.height.equalTo(35);
        }
       
        
        
        //
        
        


        userName.rx.controlEvent(.editingDidBegin) //状态可以组合
            .asObservable()
            .subscribe(onNext: { _ in
                self.passWord.snp.remakeConstraints({ (make) in
                    make.bottom.equalTo(self.contentView);
                    make.centerX.equalTo(tempView ?? self.contentView);
                    make.width.equalTo(200);
                    make.height.equalTo(35);
                })
            }).disposed(by: dispose)
        
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
}
