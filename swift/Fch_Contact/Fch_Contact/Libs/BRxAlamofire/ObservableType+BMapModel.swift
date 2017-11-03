//
//  ObservableType+BMapModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/2.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Alamofire



//扩展ObservableType  用户解析
extension ObservableType where E == Any {
    
    
    public func mapModel<T:HandyJSON>(_ type: T.Type) -> Observable<T> {
        
        return flatMap { response -> Observable<T> in
            
            
            if let dic = response as? [String:Any]{
                
                return Observable.just(JSONDeserializer<T>.deserializeFrom(dict: <#T##NSDictionary?#>, designatedPath: <#T##String?#>));
                
            }else{
                
            }
            
            
            
            
        }
        
        
        
        
    }
}
    



