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
//弹簧动画偏移量
let springOffset:CGFloat = 5;
//动画时常
let animateTime = 0.25;


enum BSliderState {
    case Close, Sliding, Open
}


protocol BSliderMenuViewControllerProtocol {
    func showLeftMenu();
    
    func hide();
    
}


class BSlideMenuViewController: UIViewController,BSliderMenuViewControllerProtocol {
    
    
    var leftVC:UIViewController?
    var mainVC:UIViewController?
   
    
    
    var nowPostionX:CGFloat = 0.0;

    var state: BSliderState = BSliderState.Close{
        didSet
        {
            
            if state == BSliderState.Close
            {
               nowPostionX = 0;
            }else if state == BSliderState.Open
            {
                nowPostionX = menuViewExpandedOffset;
            }
        }
    }
    
    
    
    
    
    convenience init(mainViewController:UIViewController,leftMenuViewController:UIViewController) {
        self.init();
        
        
        leftVC = leftMenuViewController;
        mainVC = mainViewController
        state = BSliderState.Close;
        self.addViewController(VC: leftVC!);
        self.addViewController(VC: mainVC!);
        
        
       
        
        
    }
    
    
    
    
    
    
    func setupGes(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(BSlideMenuViewController.handlePanGesture))
        mainVC?.view.addGestureRecognizer(panGestureRecognizer)
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
    
    func addViewController(VC:UIViewController) {
        addChildViewController(VC);
        self.view.addSubview(VC.view);
        VC.view.frame = CGRect(x: 0, y: 0, width:BSCREENW, height: BSCREENH);
        VC.didMove(toParentViewController: self);
    }
    
    func showLeftMenu() {
      
        guard let left = leftVC else { return }
       
        view.window?.endEditing(true)
        left.view.isHidden = false
        
      
        
        UIView.animate(withDuration: animateTime, animations: {
            
        }) { (completion) in
            
        }
    
    
        
    }
    
    func hide() {
        
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
                self.mainVC?.view!.transform =  CGAffineTransform(translationX:springx, y: 0);
//                self.mainVC?.view.fr
            }, completion: { (completion) in
                UIView.animate(withDuration: animateTime, animations: {
                    self.mainVC?.view!.transform =  CGAffineTransform(translationX:postionX, y: 0);
                })
                
            })
        }else{
            self.mainVC?.view!.transform =  CGAffineTransform(translationX:postionX, y: 0);
        }
        
         print("postionX:\(postionX)")
       
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue;
        self .setupGes();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
