//
//  SettingViewModel.swift
//  Fch_Contact
//
//  Created by bai on 2017/12/26.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SettingViewModel: NSObject {

    var loadData = PublishSubject<Bool>();
    public var result:Observable<[SectionModel<String, String>]>?
    
    override init() {
        super.init();
        prepare();
        
    }
    
    func prepare(){
        
        result = loadData.flatMapLatest({ (_) -> Observable<[SectionModel<String, String>]> in
            return self.getSettingConfig();
        })
        
        
    }
    
    func getSettingConfig() -> Observable<[SectionModel<String, String>]> {
        return Observable.create({ (observer) -> Disposable in
            
            let secion1 = SectionModel(model: "  通用", items: ["字体大小","检查更新","关于"]);
            let secion2 = SectionModel(model: "  电话本", items: ["选择电话本"]);
            let secion3 = SectionModel(model: "  用户", items: ["退出登录"]);
            
            observer.onNext([secion1,secion2,secion3]);
            observer.onCompleted();
            return Disposables.create {
            }
        })
    }
    
    func reloadData()  {
        loadData.onNext(true);
    }
   
}
