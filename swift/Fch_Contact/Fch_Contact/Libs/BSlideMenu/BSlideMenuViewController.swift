//
//  BSlideMenuViewController.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/15.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

//侧滑菜单宽度
let leftExpandedOffset: CGFloat = 110;
let rightExpandedOffset: CGFloat = 250;
let leftDragbleWidth:CGFloat = 200;
let rightDragbleWidth:CGFloat = 200;


//弹簧动画偏移量
let springOffset:CGFloat = 5;
//动画时常
let animateTime = 0.25;


enum BSliderState {
    case Close, Sliding, OpenLeft,OpenRight
}


protocol BSliderMenuViewControllerProtocol {
    func showLeftMenu();
    func hideLeftMenu();
    func showRightMenu();
    func hideRightMenu();
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
    
    @objc dynamic var  kvoState:String = "close";

    var state: BSliderState = BSliderState.Close{
        didSet
        {
            
            if state == BSliderState.Close
            {
                nowPostionX = 0;
                kvoState = "close"
            }else if state == BSliderState.Sliding
            {
//                kvoStare = ""
            }else if state == BSliderState.OpenLeft
            {
                nowPostionX = leftExpandedOffset;
                kvoState = "leftOpen"
            }else if state == BSliderState.OpenRight
            {
                nowPostionX = -rightExpandedOffset;
                kvoState = "rightOpen"
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
        _mainContainerView.layer.shadowOffset = CGSize(width: 0, height: 0);
        _mainContainerView.layer.shadowOpacity = 0.5;
       

        if let left = self.leftVC {
            self.addChildViewController(left)
            _leftContainerView.addSubview((left.view)!);
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
        }
       
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BSlideMenuViewController.handlePanGesture))
        panGestureRecognizer.delegate = self;
        _mainContainerView.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: GestureRecognizer
    
    @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        //偏移量
        let  offset = recognizer.translation(in: view).x;
        

       
        
        var newPostionX =  nowPostionX + offset;
        if newPostionX > leftExpandedOffset{
            newPostionX = leftExpandedOffset;
        }else if newPostionX < -rightExpandedOffset{
            newPostionX = -rightExpandedOffset;
        }
        
        switch(recognizer.state) {
        // 刚刚开始滑动
        case .began:
            state = BSliderState.Sliding;
            
        case .changed:
            state = BSliderState.Sliding;
            moveViewToPosionX(postionX: newPostionX, animation: false);
        case .ended:
            if newPostionX  > leftExpandedOffset/2 || newPostionX < -rightExpandedOffset/2{
                //超过一半，则展开
                
                if newPostionX > 0 {
                    //右滑，左侧展开
                    
                    if  abs(newPostionX) < leftExpandedOffset{
                        // 结束时未超过展开值 做动画
                        moveViewToPosionX(postionX:leftExpandedOffset, animation: true);
                    }else{
                        // 结束时超过或等于展开值 不做动画
                        moveViewToPosionX(postionX:leftExpandedOffset, animation: false);
                    }
                    state = BSliderState.OpenLeft;
                    
                }else{
                    //左滑，右侧展开
                    nowPostionX = -rightExpandedOffset;
                    if  abs(newPostionX)  < rightExpandedOffset{
                        moveViewToPosionX(postionX:-rightExpandedOffset, animation: true);
                    }else{
                        moveViewToPosionX(postionX:-rightExpandedOffset, animation: false);
                    }
                    state = BSliderState.OpenRight;
                    
                }
               
               
            }else{
                //未超过半，则关闭
                moveViewToPosionX(postionX: 0, animation: true);
                state = BSliderState.Close;
            }
        default:
            break
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        
        //        print("gestureRecognizerShouldBegin");
        
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
            if leftVC != nil{
                return true;
            }else{
                return false;
            }
            
        }
        if gestureRecognizer.location(in: _mainContainerView).x > UIScreen.main.bounds.width - rightDragbleWidth {
            if rigthVC != nil{
                return true;
            }else{
                return false;
            }
            
        }
        
        return false;
        
        
    }

    
    // MARK: BSliderMenuViewControllerProtocol
    
    func showLeftMenu() {
        if let _ = leftVC{
            moveViewToPosionX(postionX: leftExpandedOffset, animation: true);
            self.state = .OpenLeft;
        }
    }
    
    func hideLeftMenu() {
        if let _ = leftVC{
            moveViewToPosionX(postionX: 0, animation: true);
            self.state = .Close;
        }
    }
    
    
    func showRightMenu() {
        if let _ = rigthVC{
            moveViewToPosionX(postionX:-rightExpandedOffset, animation: true);
            self.state = .OpenRight;
        }
    }
    
    func hideRightMenu() {
        if let _ = rigthVC{
            moveViewToPosionX(postionX: 0, animation: true);
            self.state = .Close;
        }
    }
    
    
    
    //移动主试图
    func moveViewToPosionX(postionX:CGFloat, animation:Bool) {
        
        if postionX > 0{
            //右滑，左侧展开
            self._leftContainerView.isHidden = false;
            self._rightContainerView.isHidden = true;
            
            
           
        }else if postionX < 0{
            //左滑，右侧展开
            self._leftContainerView.isHidden = true;
            self._rightContainerView.isHidden = false;
            
          
           
        }else{
            
            
            
        }
        
        if animation {
            
           var springx:CGFloat;
            if postionX == leftExpandedOffset{
                springx = leftExpandedOffset + 5
            }else if postionX == -rightExpandedOffset{
                springx = -rightExpandedOffset - 5
            }else{
                springx = 0
            }
            //弹簧动画
            UIView.animate(withDuration: animateTime, animations: {
                self._mainContainerView.transform =  CGAffineTransform(translationX:springx, y: 0);
            }, completion: { (completion) in
                UIView.animate(withDuration: animateTime, animations: {
                    self._mainContainerView.transform =  CGAffineTransform(translationX:postionX, y: 0);
                })
                
            })
        }else{
            self._mainContainerView.transform =  CGAffineTransform(translationX:postionX, y: 0);
        }
        
        
//        if postionX == leftExpandedOffset || postionX == -rightExpandedOffset {
//            self.state = .Close;
//        }
        
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

    

}
