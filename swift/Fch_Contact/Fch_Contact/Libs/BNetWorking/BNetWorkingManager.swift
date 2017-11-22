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
    

    
    func request(url:String,method:HTTPMethod = .get,
                 parameters:[String:Any]? = nil,
                 completionHandler:@escaping (DataResponse<Any>) -> Void) {
        
        
        self.sessionManager.request(url, method:method, parameters: parameters).responseJSON { (response) in
            
            
            //方便调试显示
            print("😊😊😊😊😊😊😊😊😊😊😊😊😊");
            print(response.request?.url ?? "requset error");
            print("statusCode:\(response.response?.statusCode ?? 0)");
            if method == .post{print("POST parameters:\(parameters)");}else{print("GET parameters:\(parameters)")}
    
            if let value = response.result.value as? NSDictionary{
//                print(value);
                
                let data : NSData! = try? JSONSerialization.data(withJSONObject: value, options: []) as NSData!
                let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)

                print(JSONString ?? "");
            }
            
            
            completionHandler(response);
        }

    }

    
    func download(url:String,
                  method:HTTPMethod,
                  parameters:[String:Any]?,
                  progress:@escaping Request.ProgressHandler,
                  toLocalPath:URL! = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0],
                  fileName:String? = nil,
                  completionHandler:@escaping (DownloadResponse<Data>) -> Void) {
        
        var downloadRequest: DownloadRequest!
        downloadRequest = self.sessionManager.download(url, method: method, parameters: parameters,  to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            
            
            var fileURL:URL!;
            
            if let name = fileName{
                 fileURL = toLocalPath.appendingPathComponent(name)
            }else{
                fileURL = toLocalPath.appendingPathComponent(response.suggestedFilename!)
            }
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            
            
        })
        //设置进度条
        downloadRequest.downloadProgress(queue: DispatchQueue.main, closure: progress)
        //开始请求数据
        downloadRequest.responseData(completionHandler: completionHandler);
        
       
    }
    
    
    
    
   
    
     //-------------------------------rx方法----------------------------------
    
    func RxRequset(url:String,method:HTTPMethod,parameters:[String:Any])->Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
           
           
            let request = self.sessionManager.request( url, method: HTTPMethod.get, parameters: parameters).responseJSON(completionHandler: { (response) in
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
            
            
            let request = self.sessionManager.request( url, method: HTTPMethod.get, parameters: parameters).responseString(completionHandler: { (response) in
                
                
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
