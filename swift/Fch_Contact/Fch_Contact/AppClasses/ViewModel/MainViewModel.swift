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
import BAlertView

class MainViewModel: NSObject {

    
    var loadData = PublishSubject<(Int,String)>();
//    var dataSource = [SectionModel<String, PersonModel>]();
    public var result:Observable<[SectionModel<String, PersonModel>]>?
    
//    let shouldUpDateAPP:Variable<Bool> = Variable(false);
//    let shouldUpDateTelDataDB:Variable<Bool> = Variable(false);
    
    
    
    override init() {
        super.init();
        prepare();
        
    }
    
    func prepare(){
        
        result = loadData.flatMapLatest({ (depId,seartchStr) -> Observable<[SectionModel<String, PersonModel>]> in
    
            if depId == -1 {
                return self.getPersonsSorted(deptId: -1);
            }else if depId > 0{
                return self.getPersonsNoSorted(deptId: depId);
            }else{
                return self.getSearchedPersons(searchString: seartchStr);
            }
            
            
        })

        
    }
    
    
    /// 模糊搜索获取人员
    ///
    /// - Parameter searchString: 搜索字符
    /// - Returns: 搜索结果
    func getPersons(searchString:String)->Observable<[PersonModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            let persons = DBHelper.sharedInstance.getPersons(searchString: searchString);
            observer.onNext(persons);
            observer.onCompleted();
            return Disposables.create {
            
            }
        })
    }
    
    
    /// 获取整理数据后 将数据整理成列表可用数据 无排序
    ///
    /// - Parameter searchString: 搜索字符
    /// - Returns: 搜索结果
    func getSearchedPersons(searchString:String)->Observable<[SectionModel<String, PersonModel>]> {
        
        return self.getPersons(searchString:searchString).map({ (persons) -> [SectionModel<String, PersonModel>] in
            return [SectionModel(model: "", items: persons)]
        });
        
       
    }
    
    
    /// 根据部门ID 获取部门人员
    ///
    /// - Parameter deptId: 部门ID -1表示全部
    /// - Returns: 部门人员
    func getPersons(deptId:Int)->Observable<[PersonModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            let persons = DBHelper.sharedInstance.getPersonsFromDB(deptId: deptId);
            observer.onNext(persons);
            observer.onCompleted();
            return Disposables.create {
            }
        })
    }
    
    
    
    /// 根据部门ID获取排序后的人员
    ///
    /// - Parameter deptId: 部门ID -1表示全部
    /// - Returns: 人员
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
    
    
    /// 根据部门ID 获取无排序的人员
    ///
    /// - Parameter deptId: 部门ID
    /// - Returns: 人员
    func getPersonsNoSorted(deptId:Int) -> Observable<[SectionModel<String, PersonModel>]> {
        return self.getPersons(deptId:deptId).map({ (persons) -> [SectionModel<String, PersonModel>] in
            return [SectionModel(model: "", items: persons)]
        });
    }
    
    func reloadData(depId:Int)  {
        loadData.onNext((depId,""));
    }
    
    func reloadData(searchString:String) {
        loadData.onNext((-2,searchString));
    }
    
    
    
    // MARK: 网络请求
    
    /// 验证imei 是否可用
    ///
    /// - Parameter successHandler: 验证回掉
    func fchCheckImeiVerify(successHandler:@escaping (_ isVerify:Bool)->Void) {
        
        
        
        let uuid = AppLoginHelper.uuidInKeyChain();
        let par = ["imei":uuid];
        BNetWorkingManager.shared.request(url: TestIMEIVerify_URL,method: .get, parameters:par) { (response) in
            
            if let value = response.result.value as? Dictionary<String, Any> {
                if let error = value["error"]  {
                    let errorStr = error as! String;
                    if errorStr == "验证失败"{
//                        BAlertModal.sharedInstance().makeToast(errorStr);
                        successHandler(false);
                        self.clearDBAndPostNotification();
                    }else{
                        successHandler(true);
                    }
                    
                }else{
                    successHandler(true);
                }
            }else{
                successHandler(true);
                BAlertModal.sharedInstance().makeToast("网络异常");
            }
        }
    }
    
    
    
    
    /// 下载telBook对应的db文件
    ///
    /// - Parameter telBook: telBook
    func downLoadDB(telBook:TelBookModel?, finshedHandler:@escaping (_ isSuccess:Bool)->Void)  {
        
        print("开始下载数据库文件");
        
        if let telBookModel = telBook {
            
            
            
            let fileName =  DBHelper.sharedInstance.getDBSaveName(telBook: telBookModel);
            let url = "\(DownLoadDB_URL)/\(telBookModel.id!)"
            
            BNetWorkingManager.shared.download(url:url, method: .get, parameters: nil, progress: { (progress) in
                print("\(progress.completedUnitCount)/\(progress.totalUnitCount)");
            }, toLocalPath: DBFileSavePath,fileName:fileName) { (response) in
                
                if let data =  response.result.value {
                    print("文件下载成功:\(String(describing: DBFileSavePath))\(fileName)\\n size:\(data.count)");
                    //下载成功后重新设置本地的telBook  防止重复提示新数据
                    UserDefaults.standard.setTelBookModel(model: telBookModel);
                    //发送通知 刷新数据
                    NotificationCenter.default.post(name:relodDataNotificationName, object: nil);
                    //更新来电提示数据
                    CallDirectoryExtensionHelper.sharedInstance.reloadExtension(completeHandler: { (supprot, error) in
                        if supprot && error == nil{
                            print("来电显示数据更新成功");
                        }else{
                            print("来电显示数据更新失败或者系统不支持");
                        }
                    })
                    finshedHandler(true);
                }else{
                    finshedHandler(false);
                    BAlertModal.sharedInstance().makeToast("网络异常");
                }
            }
        }else{
            finshedHandler(false);
        }
        
        
    }
    
    // MARK: 本地方法
    
    /// 清空数据库并且发送通知
    func clearDBAndPostNotification() {
        DBHelper.sharedInstance.clearDB();
        NotificationCenter.default.post(name:relodDataNotificationName, object: nil);
    }
    
    
    /// 判断电话本是否过期，如果timeNow == ""则根据 days判断
    ///
    /// - Parameters:
    ///   - expiredTime: 过期时间
    ///   - timeNow: 现在时间
    ///   - days: 剩余天数
    /// - Returns: 是否过期
    func checkTelBookExpired(expiredTime:TimeInterval,timeNow:String,days:Int) -> Bool {
        
        if timeNow == "" {
            
            if days <= 3{
                BAlertModal.sharedInstance().makeToast("电话本使用即将到期，请您尽快续费!");
            }
            return days > 0;
        }else{
            let now = BDateTool.sharedInstance.dateFromGMTTimeString(timeString: timeNow);
            let timeNowTimeInterval = BDateTool.sharedInstance.timeIntervalSince1970FromDate(date: now);
            
            if expiredTime - timeNowTimeInterval < 3*24*60*60*1000 {
                BAlertModal.sharedInstance().makeToast("电话本使用即将到期，请您尽快续费!");
            }
            
            
            return expiredTime - timeNowTimeInterval < 0;
        }
        
        
    }
    
    
    
    
    
    
    
    
    
   
}
