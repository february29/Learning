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
    public var result:Observable<[SectionModel<String, SettingCellModel>]>?
    
    let disposeBag = DisposeBag();
    
    
    override init() {
        super.init();
        prepare();
        
    }
    
    func prepare(){
        
        result = loadData.flatMapLatest({ (_) -> Observable<[SectionModel<String, SettingCellModel>]> in
            return self.getSettingConfig();
        })
        
    
        ColorCenter.shared.themeName.asObservable().subscribe(onNext: { (themName) in
            self.loadData.onNext(true);
        }).disposed(by: disposeBag)
        
        FontCenter.shared.fontName.asObservable().subscribe(onNext: { (fontName) in
            self.loadData.onNext(true);
        }).disposed(by: disposeBag)
        
        
        
    }
    
    func getSettingConfig() -> Observable<[SectionModel<String, SettingCellModel>]> {
        
        let imei = AppLoginHelper.uuidInKeyChain();
        let fontSizeName = FontCenter.shared.fontSize.displayName;
        let themName = ColorCenter.shared.theme.displayName;
        let information = "v\(UserDefaults.standard.getTelBookModel()?.information ?? "0")";
        
        let fontModel = SettingCellModel(labStr: "字体大小", infoStr: fontSizeName, showArrow: true)
        let themModel = SettingCellModel(labStr: "主题颜色", infoStr: themName, showArrow: true);
        let secion1 = SectionModel(model: "  通用", items: [fontModel,themModel]);
        
        
        let openldModel = SettingCellModel(labStr: "开启来电识别", infoStr: "", showArrow: true);
        let updateldModel = SettingCellModel(labStr: "刷新来电提示数据", infoStr: information, showArrow: true)
        let secion2 = SectionModel(model: "  来电识别", items: [openldModel,updateldModel ]);
        
        
        let identifierModel = SettingCellModel(labStr:imei, infoStr: "", showArrow: false)
        let secion3 = SectionModel(model: "  标识符", items: [identifierModel]);
        
        let loginModel = SettingCellModel(labStr:"重新登录", infoStr: "", showArrow: false)
        let secion4 = SectionModel(model: "  用户", items: [loginModel]);
        
        
        
        return Observable.create({ (observer) -> Disposable in
            
            
            
            observer.onNext([secion1,secion2,secion3,secion4]);
            observer.onCompleted();
            return Disposables.create {
            }
        })
    }
    
    func reloadData()  {
        loadData.onNext(true);
    }
   
}
