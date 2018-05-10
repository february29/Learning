//
//  CallDirectoryHandler.swift
//  Fch_contact_CallDirectoryExtension
//
//  Created by bai on 2018/4/10.
//  Copyright © 2018年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import CallKit
import FMDB


class CallDirectoryHandler: CXCallDirectoryProvider {

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self

        // Check whether this is an "incremental" data request. If so, only provide the set of phone number blocking
        // and identification entries which have been added or removed since the last time this extension's data was loaded.
        // But the extension must still be prepared to provide the full set of data at any time, so add all blocking
        // and identification phone numbers if the request is not incremental.
//        if context.isIncremental {
//            addOrRemoveIncrementalBlockingPhoneNumbers(to: context)
//
//            addOrRemoveIncrementalIdentificationPhoneNumbers(to: context)
//        } else {
//            addAllBlockingPhoneNumbers(to: context)
//
//            addAllIdentificationPhoneNumbers(to: context)
//        }
        
        addAllBlockingPhoneNumbers(to: context)
        
        addAllIdentificationPhoneNumbers(to: context)

        context.completeRequest()
    }

    private func addAllBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Retrieve all phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        //
        // Numbers must be provided in numerically ascending order.
        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [  ]
        for phoneNumber in allPhoneNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
        }
    }

//    private func addOrRemoveIncrementalBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
//        // Retrieve any changes to the set of phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
//        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
//        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_408_555_1234 ]
//        for phoneNumber in phoneNumbersToAdd {
//            context.addBlockingEntry(withNextSequentialPhoneNumber: phoneNumber)
//        }
//
//        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ 1_800_555_5555 ]
//        for phoneNumber in phoneNumbersToRemove {
//            context.removeBlockingEntry(withPhoneNumber: phoneNumber)
//        }
//
//        // Record the most-recently loaded set of blocking entries in data store for the next incremental load...
//    }

    private func addAllIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
        //
        // Numbers must be provided in numerically ascending order.
        
        let data  = self.getDataFromDB();
        for (num,label) in data {
            let phoneNumber = Int64(num);
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber!, label: label)
        }
        
//        let allPhoneNumbers: [CXCallDirectoryPhoneNumber] = [ 1_877_555_5555, 1_888_555_5555 ]
//        let labels = [ "Telemarketer", "Local business" ]
//
//        for (phoneNumber, label) in zip(allPhoneNumbers, labels) {
//            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
//        }
    }

//    private func addOrRemoveIncrementalIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
//        // Retrieve any changes to the set of phone numbers to identify (and their identification labels) from data store. For optimal performance and memory usage when there are many phone numbers,
//        // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
//        let phoneNumbersToAdd: [CXCallDirectoryPhoneNumber] = [ 1_408_555_5678 ]
//        let labelsToAdd = [ "New local business" ]
//
//        for (phoneNumber, label) in zip(phoneNumbersToAdd, labelsToAdd) {
//            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
//        }
//
//        let phoneNumbersToRemove: [CXCallDirectoryPhoneNumber] = [ 1_888_555_5555 ]
//
//        for phoneNumber in phoneNumbersToRemove {
//            context.removeIdentificationEntry(withPhoneNumber: phoneNumber)
//        }
//
//        // Record the most-recently loaded set of identification entries in data store for the next incremental load...
//    }
    
    
    func getDataFromDB() -> Array<(String,String)> {
        
        var dataArray:Array<(String,String)> = [];
        //这里直接访问风驰电话本db文件
        let saveDocPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Fch_OA")?.path;
        let savePath = "\(saveDocPath ?? "")/风驰电话本_27.db"
        let db = FMDatabase(path: savePath);
        if db.open() {
            let sql = "select * from t_person order by column3 asc";
            let resultSet =  db.executeQuery(sql, withParameterDictionary: nil);
            if  resultSet != nil{
                while resultSet!.next() {
                    let dic =  resultSet?.resultDictionary;
                    
                    guard let name =  dic!["column1"] as? String else{continue}
                    guard let phone = dic!["column3"] as? String else{continue}
                    guard let dep = dic!["column2"] as? String else{continue}
                    
                    
                    
                    if !phone.isTelNumber || name.hasSuffix("传真"){
                        //不合法数据
                    }else{
                        let num = "86\(phone)".replacingOccurrences(of: "-", with: "");
                        let lab = "\(name)-\(dep)".replacingOccurrences(of: "\n", with: "")
                        
                        dataArray.append((num,lab));
                        
                    }
                    
                };
                
            }
        }
        return dataArray;
    }

}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {

    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
        // An error occurred while adding blocking or identification entries, check the NSError for details.
        // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
        //
        // This may be used to store the error details in a location accessible by the extension's containing app, so that the
        // app may be notified about errors which occured while loading data even if the request to load data was initiated by
        // the user in Settings instead of via the app itself.
    }

}

extension String{
    public var isPhoneNumber:Bool
    {
        let mobile = "1[34578]([0-9]){9}";//"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    public var isTelNumber:Bool
    {
        
        
        if self.isPhoneNumber {
            return true;
        }
        
        
        let tel = "^0(10|2[0-5789]|\\d{3})(-)?\\d{7,8}$";
        
        let regextesttle = NSPredicate(format: "SELF MATCHES %@",tel)
        
        if (regextesttle.evaluate(with: self) == true)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
}
