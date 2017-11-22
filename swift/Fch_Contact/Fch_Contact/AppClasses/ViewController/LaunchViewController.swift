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
import BAlertView


class LaunchViewController: BBaseViewController,UIScrollViewDelegate{
    
    let lanuchImages = ["launch_1.jpg","launch_2.jpg","launch_3.jpg"];
    
    var tempView:UIView?;//布局使用的临时view
    
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
        tf.isSecureTextEntry = true;
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
        
        setupRx();
        
        
        
        

        
        
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
        
        
        tempView?.isUserInteractionEnabled = true;
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LaunchViewController.loginAction));
        tempView?.addGestureRecognizer(tap)
    
        
        
    }
    
    
    func setupRx() {
       
        
        // 初始化是UI->ViewModel
        let viewModel = LaunchViewModel(input:(userName.rx.text.orEmpty.asDriver(),
                                               passWord.rx.text.orEmpty.asDriver(),
                                               userName.rx.controlEvent(.editingDidBegin).asDriver(),
                                               passWord.rx.controlEvent(.editingDidBegin).asDriver(),
                                               passWord.rx.controlEvent(.editingDidBegin).asDriver()
            )
        );
        
        
        
        
        //ViewModel->UI
        viewModel.textFieldTapDriver1?.drive(onNext: { (element) in
            self.passWord.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.centerY);
                make.centerX.equalTo(self.tempView ?? self.contentView);
                make.width.equalTo(200);
                make.height.equalTo(35);
            })
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            })
        }, onCompleted: {
            
        }).disposed(by: dispose);
        
        viewModel.textFieldTapDriver2?.drive(onNext: { (element) in
            self.passWord.snp.remakeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.centerY);
                make.centerX.equalTo(self.tempView ?? self.contentView);
                make.width.equalTo(200);
                make.height.equalTo(35);
            })
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded();
            })
        }).disposed(by: dispose);
        
        
    }
    
    
    
    @objc func loginAction(){
        
        
        
        if userName.text == "" {
            userName.b_shark();
            return;
        }
        if passWord.text == "" {
            passWord.b_shark();
            return;
        }
        userName.resignFirstResponder();
        passWord.resignFirstResponder();
        
        BHudView.showIndicator(in: self.view, indicatorViewStyle: .fchIndicatorView)
        
        
        let par = ["loginName":userName.text!,
                   "password":passWord.text!.md5];
        
        BNetWorkingManager.shared.request(url: Login_URL, method:.post, parameters: par ) { (response) in
        
            
            BHudView.hideHud(in: self.view);
            if let value = response.result.value as? NSDictionary{
                if let error = value["error"]{
                    
                    BAlertModal.sharedInstance().makeToast(error as! String);
                }else{
                    
                    if let user = value["user"] as? Dictionary<String,Any>{
                        let userModel = UserModel.deserialize(from: user)
                        if userModel != nil{
                            UserDefaults.standard.setUserModel(model: userModel!);
                            
                        }
                        
                        let mainVC = MainViewController();
                        
                        let mainNV = BBaseNavigationViewController(rootViewController: mainVC)
                        let leftMenuVC = LeftMenuViewController();
                        
                        let sliderMenuVC = BSlideMenuViewController.init(mainViewController: mainNV, leftViewController: leftMenuVC, rightViewContoller: nil);
                       
                        self.navigationController?.pushViewController(sliderMenuVC, animated: true);
                        
                    }
                    
                }
               
            }else{
                BAlertModal.sharedInstance().makeToast("网络异常");
            }
        
            
        };
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    
}
