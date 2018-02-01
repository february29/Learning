//
//  AppDelegate.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/30.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift
import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        let  keyboardManager = IQKeyboardManager.sharedManager();
//        keyboardManager.enable = true
//        keyboardManager.shouldResignOnTouchOutside = true;
//        keyboardManager.enableAutoToolbar = false;
        
        

//        if #available(iOS 11.0, *) {
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
//        } else {
//            // Fallback on earlier versions
//        };

        
        
        
    
        window = UIWindow(frame: UIScreen.main.bounds);
        let rootVc = LaunchViewController();
        
        
        
        
        
        //如果登陆
        if  UserDefaults.standard.getUserModel() != nil  {
            let mainVC = MainViewController();
            
            let mainNV = BBaseNavigationViewController(rootViewController: mainVC)
            let leftMenuVC = LeftMenuViewController();
            leftMenuVC.menuSelectedDelegate = mainVC;
            let rightVC = RightViewController();
            let sliderMenuVC = BSlideMenuViewController.init(mainViewController: mainNV, leftViewController: leftMenuVC, rightViewContoller: rightVC);
            window?.rootViewController = sliderMenuVC;
        }else{
            let nv = BBaseNavigationViewController(rootViewController: rootVc);
            window?.rootViewController = nv;
        }
        
        self.setup();
       
        window?.makeKeyAndVisible();
        return true
    }

    
    func setup() {
        
        let setting =  UserDefaults.standard.getUserSettingModel()
        ColorCenter.shared.theme = setting.theme;
        FontCenter.shared.fontSize = setting.fontSize;
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

