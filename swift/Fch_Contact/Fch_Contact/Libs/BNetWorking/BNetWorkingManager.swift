//
//  BNetWorkingManager.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import HandyJSON




class BNetWorkingManager: NSObject {
    
    // 单例
//    static let shareSingleOne = Single()
   
    
    static var shared: BNetWorkingManager {
        struct Static {
            static let instance: BNetWorkingManager = BNetWorkingManager()
        }
        return Static.instance
    }
    private override init() {}
       
    
   
    
    
    private lazy var sessionConfig:URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default;
        configuration.timeoutIntervalForRequest = 15;
        return configuration;
    }();
    
    
    private lazy var sessionManager:SessionManager = {
        let sessionManager = SessionManager(configuration:self.sessionConfig);
        return sessionManager;
    }();

    
    
    
    //-------------------------------实例方法----------------------------------
    

    
    func request(url:String,method:HTTPMethod,parameters:[String:Any],completionHandler:@escaping (DataResponse<Any>) -> Void) {
        
        self.sessionManager.request(url, method: method, parameters:parameters);
        
        self.sessionManager.request(BASE_URL+url, method:method, parameters: parameters).responseJSON { (response) in
            
            
            //方便调试显示
            
            print(response.request?.url ?? "requset error");
            print("statusCode:\(response.response?.statusCode ?? 0)");
            if method == .post{print(parameters);}else{print("get");}
            if let value = response.result.value as? [String: AnyObject]{
                print(value);
            }
            
            
            
            completionHandler(response);
            
            
            
        }

    }
    
    
    

    //-------------------------------类方法----------------------------------
    
    
   class func getJson(url:String, parameters:[String:Any],completionHandler:@escaping (DataResponse<Any>) -> Void){
        

    
        Alamofire.request(BASE_URL+url, method:.get, parameters: parameters).responseJSON { (response) in
           

            
            if let value = response.result.value as? [String: AnyObject]{
                print(value);
            }
            
            completionHandler(response);

            
            
        }
        
    
        
    }
    
    
    
    class func postJSON(url:String, parameters:[String:Any],completionHandler:@escaping (DataResponse<Any>) -> Void){
        
        
        
        
        
        
        Alamofire.request(BASE_URL+url, method:.post, parameters: parameters).responseJSON { (response) in
            
            
            
            if let value = response.result.value as? [String: AnyObject]{
                print(value);
            }
            
            completionHandler(response);
            
            
            
        }
        
        
        
    }


    
    
     //-------------------------------rx方法----------------------------------
    
    func RxRequset(url:String,method:HTTPMethod,parameters:[String:Any])->Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
           
           
            let request = self.sessionManager.request(BASE_URL + url, method: HTTPMethod.get, parameters: parameters).responseJSON(completionHandler: { (response) in
                let result = response.result
                switch result {
                case .success:
                    observer.onNext(result)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            });
            
            return Disposables.create() {
                request.cancel()
            }
        }).debug("Http");
    }
    
    func RxRequsetString(url:String,method:HTTPMethod,parameters:[String:Any])->Observable<String> {
        
        
        return Observable.create({ (observer) -> Disposable in
            
            
            let request = self.sessionManager.request(BASE_URL + url, method: HTTPMethod.get, parameters: parameters).responseString(completionHandler: { (response) in
                
                
                let result = response.result
                switch result {
                case let .success(result):
                    observer.onNext(result);
                    observer.onCompleted();
                case let .failure(error):
                    observer.onError(error);
                }
                
            })
            
            return Disposables.create() {
                request.cancel();
            }
        }).debug("Http");
    }
    
    
    
  
    
}
