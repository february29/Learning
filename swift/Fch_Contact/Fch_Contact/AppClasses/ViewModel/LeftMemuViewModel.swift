//
//  LeftMemuViewModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/1.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class LeftMemuViewModel: NSObject {

    
    public var result:Observable<[SectionModel<String, DeptModel>]>?
    
    override init() {
        super.init();
        prepare();
        
    }
    
    func prepare(){
        if let telBook = UserDefaults.standard.getTelBookModel() {
            print("显示telbook\(telBook.bookName)")
            reloadData();
        }
        
    }
    
    func getDepts()->Observable<[DeptModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            let depts = DBHelper.sharedInstance.getDepsFromDB();
            observer.onNext(depts);
            observer.onCompleted();
            return Disposables.create {
            }
        })
    }
    
    func getDepts2() -> Observable<[SectionModel<String, DeptModel>]> {
        return self.getDepts().map({ (depts) -> [SectionModel<String, DeptModel>] in
            return [SectionModel(model: "", items: depts)]
        });
    }
    
   
    
    func reloadData()  {
        result = self.getDepts2();
    }
    
     
    
}
