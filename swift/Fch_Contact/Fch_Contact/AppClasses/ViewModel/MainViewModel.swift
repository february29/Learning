//
//  MainViewModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/30.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewModel: NSObject {

    
//    var dataSource = [SectionModel<String, PersonModel>]();
    public var result:Observable<[SectionModel<String, PersonModel>]>?
    
    
    
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
    
    
    func getPersons(deptId:Int)->Observable<[PersonModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            let persons = DBHelper.sharedInstance.getPersonsFromDB(deptId: deptId);
            observer.onNext(persons);
            observer.onCompleted();
            return Disposables.create {
            }
        })
    }
    
    func getPersonsNoSorted(deptId:Int) -> Observable<[SectionModel<String, PersonModel>]> {
       return self.getPersons(deptId:deptId).map({ (persons) -> [SectionModel<String, PersonModel>] in
            return [SectionModel(model: "", items: persons)]
       });
    }
    
    func reloadData()  {
        result = self.getPersonsNoSorted(deptId: -1);
    }
    
    
    
    
    
    
    
    
    
   
}
