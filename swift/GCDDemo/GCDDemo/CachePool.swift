//
//  CachePool.swift
//  GCDDemo
//
//  Created by bai on 2019/5/31.
//  Copyright © 2019 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit

class CachePool: NSObject {
    
    
    var cache = [Product]();
    let maxSize = 20;
    
    
    
    let semaphore = DispatchSemaphore.init(value: 1) // 创建信号量，控制同时访问资源的线程数为1
    
    func add(p:Product)  {
        
        semaphore.wait()
        cache.append(p);
        print("++++++now cache has \(cache.count) poducts")
        semaphore.signal();
    }
    
    func removeFist() {
        semaphore.wait()
        
        if cache.count>0 {
            cache.remove(at: 0);
            print("------now cache has \(cache.count) poducts")
        }else{
            print("no products to custome")
        }
       
        semaphore.signal();
        
    }

}
