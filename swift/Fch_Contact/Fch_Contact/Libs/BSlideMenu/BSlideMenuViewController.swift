//
//  BSlideMenuViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

//侧滑菜单宽度
let menuViewExpandedOffset: CGFloat = 150;
let leftDragbleWidth:CGFloat = 150;


//弹簧动画偏移量
let springOffset:CGFloat = 5;
//动画时常
let animateTime = 0.25;


enum BSliderState {
    case Close, Sliding, Open
}


protocol BSliderMenuViewControllerProtocol {
    func showLeftMenu();
    func hideLeftMenu();
}



class BSlideMenuViewController: UIViewController,BSliderMenuViewControllerProtocol,UIGestureRecognizerDelegate {
    
    var leftVC:UIViewController?
    var mainVC:UIViewController?
    var rigthVC:UIViewController?
    
    
    let _mainContainerView = UIView(frame:UIScreen.main.bounds);
    let _leftContainerView = UIView(frame:UIScreen.main.bounds);
    let _rightContainerView = UIView(frame:UIScreen.main.bounds);
//    let _maskView = UIView(frame:UIScreen.main.bounds);
    
    
    var nowPostionX:CGFloat = 0.0;

    var state: BSliderState = BSliderState.Close{
        didSet
        {
            
            if state == BSliderState.Close
            {
               nowPostionX = 0;
            }else if state == BSliderState.Sliding
            {
                
            }else if state == BSliderState.Open
            {
                nowPostionX = menuViewExpandedOffset;
            }
        }
    }
    
    
    init(mainViewController:UIViewController?,leftViewController:UIViewController?,rightViewContoller:UIViewController?) {
        
        super.init(nibName: nil, bundle: nil);

        self.leftVC = leftViewController;
        self.mainVC = mainViewController
//        self.delegate = mainViewController as! BSliderMenuViewControllerDelegate;
        self.rigthVC = rightViewContoller;
        self.state = BSliderState.Close;
        
        prepare();

    
    }
    
    func prepare() {
        
//        _maskView.isHidden = true;
        
        _mainContainerView.layer.shadowColor = UIColor.black.cgColor;
        _mainContainerView.layer.shadowOffset = CGSize(width: -3, height: 0);
        _mainContainerView.layer.shadowOpacity = 0.5;
       

        if let left = self.leftVC {
            self.addChildViewController(left)
            _leftContainerView.addSubview((left.view)!);
            _leftContainerView.transform = CGAffineTransform(translationX: -menuViewExpandedOffset, y: 0);
            self.view.addSubview(_leftContainerView);
        }
        if let right = self.rigthVC {
            self.addChildViewController(right)
            _rightContainerView.addSubview((right.view)!);
            self.view.addSubview(_rightContainerView);
        }
        
        if let mian = self.mainVC {
            self.addChildViewController(mian)
            _mainContainerView.addSubview((mian.view)!);
            self.view.addSubview(_mainContainerView);
//            _mainContainerView.addSubview(_maskView);
        }
       
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BSlideMenuViewController.handlePanGesture))
        panGestureRecognizer.delegate = self;
        _mainContainerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    
    
    
    
    
    
    

    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        //偏移量
        let  offset = recognizer.translation(in: view).x;
        
        
        var  newPostionX =  nowPostionX + offset;
        
        if newPostionX > menuViewExpandedOffset{
            newPostionX = menuViewExpandedOffset;
        }else if newPostionX < 0{
            newPostionX = 0;
        }
        
        switch(recognizer.state) {
            
        // 刚刚开始滑动
        case .began:
            
            state = BSliderState.Sliding;
        case .changed:
            state = BSliderState.Sliding;
            moveViewToPosionX(postionX: newPostionX, animation: false);
            
        case .ended:
            if newPostionX>menuViewExpandedOffset/2{
                //超过一半，则展开
                state = BSliderState.Open;
                
                moveViewToPosionX(postionX:menuViewExpandedOffset, animation: true);
               
            }else{
                //未超过半，则关闭
                state = BSliderState.Close;
                
                moveViewToPosionX(postionX: 0, animation: true);
                
               
            }
            
            if (leftVC != nil) {
               
            }
        default:
            break
        }
    }
    
    
    
    func showLeftMenu() {
      
        if let _ = leftVC{
            moveViewToPosionX(postionX: menuViewExpandedOffset, animation: true);
        }
       
       
        
    }
    
    func hideLeftMenu() {
        if let _ = leftVC{
            moveViewToPosionX(postionX: 0, animation: true);
        }
        
    }
    
    
    //移动主试图
    func moveViewToPosionX(postionX:CGFloat, animation:Bool) {
        
        
        if animation {

            //弹簧动画
            var springx:CGFloat;
            if postionX == menuViewExpandedOffset{
                springx = menuViewExpandedOffset+5;
            }else{
                springx = -5;
            }
            UIView.animate(withDuration: animateTime, animations: {
                self._mainContainerView.transform =  CGAffineTransform(translationX:springx, y: 0);
//                self.mainVC?.view.fr
            }, completion: { (completion) in
                UIView.animate(withDuration: animateTime, animations: {
                    self._mainContainerView.transform =  CGAffineTransform(translationX:postionX, y: 0);
                })
                
            })
        }else{
            self._mainContainerView.transform =  CGAffineTransform(translationX:postionX, y: 0);
        }
        
         print("postionX:\(postionX)")
       
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        _leftContainerView.isHidden = false;
        _rightContainerView.isHidden = false;
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        _leftContainerView.isHidden = true;
        _rightContainerView.isHidden = true;
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 防止进入多级界面后依然可以呼出侧滑菜单栏
        
        if  (mainVC?.isKind(of: UINavigationController.self))!{
            if mainVC!.childViewControllers.count > 1{
                return false;
            }
        }else{
            for  contoller in (mainVC?.childViewControllers)!{
                if contoller.isKind(of: UINavigationController.self){
                    if contoller.childViewControllers.count > 1{
                        return false;
                    }
                }
            }
        }
        
        
        
        // 判断点击拖动手势是否在允许拖动范围内
        if gestureRecognizer.location(in: _mainContainerView).x < leftDragbleWidth {
            return true;
        }
       
        return false;
        
       
    }
    

}
