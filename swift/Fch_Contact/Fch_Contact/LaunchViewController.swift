//
//  LaunchViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift


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
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//             self.automaticallyAdjustsScrollViewInsets = NO;
//            self.navigationController.navigationBarHidden = NO;
        
        //防止scrollerview 中 contentview 出现在状态栏下方
        self.automaticallyAdjustsScrollViewInsets = false;

        
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

        
        BNetWorkingManager.shared.RxRequsetString(url: "userLogin", method:.post, parameters: par).mapModel(UserModel.self)
            .subscribe(onNext: { (model) in
                
            })
            .addDisposableTo(dispose);
        
       
        
//        BNetWorkingManager.shared.r(url: "userLogin", method:.post, parameters: par)
//            .mapModel(UserModel.self)
//            .subscribe { (event) in
//
//            }.addDisposableTo(dispose);
//
//
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
}
