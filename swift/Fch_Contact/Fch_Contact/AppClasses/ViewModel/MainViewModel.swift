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

    
    var loadData = PublishSubject<Int>();
    
//    var dataSource = [SectionModel<String, PersonModel>]();
    public var result:Observable<[SectionModel<String, PersonModel>]>?
    
    
    
    override init() {
        super.init();
        prepare();
        
    }
    
    func prepare(){
        
        result = loadData.flatMapLatest({ (depId) -> Observable<[SectionModel<String, PersonModel>]> in
    
            if depId == -1 {
                return self.getPersonsSorted(deptId: -1);
            }else{
                return self.getPersonsNoSorted(deptId: depId);
            }
            
            
        })

        
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
    
    func getPersonsSorted(deptId:Int) -> Observable<[SectionModel<String, PersonModel>]> {
       return self.getPersons(deptId:deptId).map({ (persons) -> [SectionModel<String, PersonModel>] in
        
        
        
        
        var dic = Dictionary<String,[PersonModel]>();
        
        
        for  model in persons{
            let firstUInt8 = UInt8(pinyinFirstLetter((model.column1 as NSString).character(at: 0)))
            let firstString =  String(Character( UnicodeScalar(firstUInt8)));
            
            let hasContains =  dic.keys.contains(where: { (key) -> Bool in
                return key == firstString;
            });
            
            if !hasContains{
                var itemArray = [PersonModel]();
                itemArray.append(model);
                dic[firstString] = itemArray;
            }else{
                dic[firstString]?.append(model);
            }
        }
        let sortedArray =  dic.sorted(by: { (o1, o2) -> Bool in
            return o1.key < o2.key;
        });
        
        
        var sections:[SectionModel<String,PersonModel>] =  [];
       
        
        for item in sortedArray{
            sections.append(SectionModel<String, PersonModel>.init(model: item.key, items: item.value));
        }
        
        return sections;
       });
    }
    
    func getPersonsNoSorted(deptId:Int) -> Observable<[SectionModel<String, PersonModel>]> {
        return self.getPersons(deptId:deptId).map({ (persons) -> [SectionModel<String, PersonModel>] in
            
        
            return [SectionModel(model: "", items: persons)]
        });
    }
    
    func reloadData(depId:Int)  {
        loadData.onNext(depId);
    }
    
    
    
    
    
    
    
    
    
   
}
