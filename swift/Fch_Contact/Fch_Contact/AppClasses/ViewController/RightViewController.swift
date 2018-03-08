//
//  RightViewController.swift
//  Fch_Contact
//
//  Created by bai on 2018/2/1.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit


protocol RightViewControllerDelegate {

    func shouldSearchFor(searchString:String);
}


class RightViewController: BBaseViewController {
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField();
        tf.addOffsetView(value: 5);
        tf.setTextColor(.primary);
        tf.setTextFontSize(type: .primary);
        tf.layer.borderColor = UIColor.lightGray.cgColor;
        tf.layer.borderWidth = 1;
        tf.placeholder = "姓名、部门、电话";
        tf.layer.cornerRadius =  5;
        
        return tf
    }()

    
    var viewModel:RightViewModel?;
    let diposbage = DisposeBag();
    
    
    var delegate:RightViewControllerDelegate?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setBackgroundColor(.background)

        self.view.addSubview(self.searchTextField);
        searchTextField.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-25);
            make.height.equalTo(35);
            make.width.equalTo(200);
            make.centerY.equalTo(self.view);
        }
        
        
        
        
        
        viewModel =  RightViewModel(input: self.searchTextField.rx.text.orEmpty.asObservable())
        
        
        viewModel?.searchObservable.throttle(0.5, scheduler:MainScheduler.instance ).subscribe(onNext: { (searchString) in
            if let dele = self.delegate{
                dele.shouldSearchFor(searchString: searchString);
            }
        }).disposed(by: diposbage);
        
        
//        ConcurrentDispatchQueueScheduler(qos: DispatchQoS)
        
        
        self.sliderVC().rx.observe(String.self, "kvoState").observeOn(MainScheduler.instance).subscribe(onNext: { (state) in
            if state == "close" {
                
                self.searchTextField.resignFirstResponder();
            }else if state == "rightOpen"{
                self.searchTextField.becomeFirstResponder();
            }
        }).disposed(by: diposbage);
    }

    

}
