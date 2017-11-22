//
//  DBHelper.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/22.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation
import FMDB

let personTableName = "t_person";



let deptTableName = "t_dept";


//数据库存储文件夹
let DBFileSavePath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Fch_OA");

class DBHelper {
    static let sharedInstance = DBHelper();
    private init() { };
    
    
    
    func getDBSaveName(telBook:TelBookModel) -> String {
        return "\(telBook.bookName!)_\(telBook.id!).db";
    }
    
    
    
    func getPersonsFromDB(deptId:Int) -> Array<PersonModel> {
        
        var persons:[PersonModel] = Array();
        let dbName = getDBSaveName(telBook: UserDefaults.standard.getTelBookModel()!);
        let db = FMDatabase.init(url: DBFileSavePath?.appendingPathComponent(dbName))
        if db.open() {
            let selectSql:String?;
            if deptId == -1{
                selectSql="select * from \(personTableName) where is_title = 0 ";
            }else{
                selectSql="select * from \(personTableName) where is_title = 0 and dept_id = \(deptId) ";
            }
            
            let resultSet =  db.executeQuery(selectSql!, withParameterDictionary: nil);
            
            while resultSet!.next() {
                let dic =  resultSet?.resultDictionary;
                persons.append(PersonModel.deserialize(from: dic! as NSDictionary)!)
            };
            
            
            
            
            
        }
        
        
        return persons;
    }
    
    
   
}
