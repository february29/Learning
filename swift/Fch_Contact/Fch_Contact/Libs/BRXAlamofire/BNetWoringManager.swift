//
//  BNetWoringManager.swift
//  Fch_Contact
//
//  Created by bai on 2017/10/31.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import MJExtension



/// 服务器地址
let BASE_URL = "http://telbook.fchsoft.com:8099"



public protocol Request {
    
    var path:String{get}
    
    var method:HTTPMethod{get}
    
    var parameters: [String:Any]? {get}
    
    var hud:Bool{get}
    
}


extension Request{
    
    var hud:Bool{
        
        return false
        
    }
    
    var method:HTTPMethod{
        
        return HTTPMethod.get
        
    }
    
    
    
}




 

class BNetWoringManager: NSObject {
    
    
    var host: String {
        return BASE_URL;
    }
    
//    func send(_ r:Request) -> Observable<[String : Any]> {
//        if r.hud {
//            
//        }
//        return Observable<[String : Any]>.create({ (observer) -> Disposable  in
//            Alamofire.request(URL.init(string: "\(self.host)\(r.path)")!, method: r.method, parameters: r.parameters).responseJSON { (response) in
//                switch response.result {
//                case .success(_):
//                    if let json = response.result.value as? [String : Any] {
//                        if let code = json[RESULT_CODE] as? Int {
//                            if code == SUCCESSCODE {
//                                observer.onNext(json[RESULT_DATA] as! [String : Any])
//                                observer.onCompleted()
//                            } else {
//                                let message = json[RESULT_MESSAGE] as! String
////                                observer.onError(CZSError.CustomError(msg: message, code: code).show())
//                                observer.onError(<#T##error: Error##Error#>)
//                            }
//                        } else {
//                            observer.onError(CZSError.MapperError.show())
//                        }
//                    }else{
//                        observer.onError(CZSError.MapperError.show())
//                    }
//                case .failure(_):
//                    observer.onError(CZSError.HTTPFailed.show())
//                }
//            }
//            return Disposables.create {
//                
//            }
//        })
//    }

//    public func request(
//        _ url: URLConvertible,
//        method: HTTPMethod = .get,
//        parameters: Parameters? = nil)
//    {
//
//        
//        
//    
//        Alamofire.request(url, method:method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//           
//            
//        
//            
//        }
//
//    
//    }
    
    
  
    
}
