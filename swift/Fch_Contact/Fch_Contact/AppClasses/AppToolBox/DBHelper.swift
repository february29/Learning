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
    
    
    
    func getDBSaveName(telBook:TelBookModel?) -> String {
        if let model = telBook {
            return "\(model.bookName!)_\(model.id!).db";
        }else{
            return "";
        }
        
        
    }
    
    
    
    func getPersonsFromDB(deptId:Int) -> Array<PersonModel> {
        
        var persons:[PersonModel] = Array();
        let dbName = getDBSaveName(telBook: UserDefaults.standard.getTelBookModel());
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
    
    
    func getDepsFromDB() -> Array<DeptModel> {
        
        var deps:[DeptModel] = Array();
        let dbName = getDBSaveName(telBook: UserDefaults.standard.getTelBookModel());
        let db = FMDatabase.init(url: DBFileSavePath?.appendingPathComponent(dbName))
        if db.open() {
            let selectSql:String?;
           
                selectSql="select * from \(deptTableName)";
            
            
            let resultSet =  db.executeQuery(selectSql!, withParameterDictionary: nil);
            
            while resultSet!.next() {
                let dic =  resultSet?.resultDictionary;
                deps.append(DeptModel.deserialize(from: dic! as NSDictionary)!)
            };
            
        }
        
        
        return deps;
    }
    
    func getPersons(searchString:String) -> Array<PersonModel> {
        
        
        var persons:[PersonModel] = Array();
        let dbName = getDBSaveName(telBook: UserDefaults.standard.getTelBookModel());
        let db = FMDatabase.init(url: DBFileSavePath?.appendingPathComponent(dbName))
        if db.open() {
            let selectSql:String?;
            selectSql="select * from \(personTableName)  where is_title = 0 and column1 like '%%%\(searchString)%%%' or column2 like '%%%\(searchString)%%%' or column3 like '%%%\(searchString)%%%' or column4 like '%%%\(searchString)%%%' or column5 like '%%%\(searchString)%%%'";
            
            let resultSet =  db.executeQuery(selectSql!, withParameterDictionary: nil);
            
            
            while resultSet!.next() {
                let dic =  resultSet?.resultDictionary;
                persons.append(PersonModel.deserialize(from: dic! as NSDictionary)!)
            };
            
        }
        
        
        return persons;
        
    }
    
    
    func clearDB()  {
        let dbName = getDBSaveName(telBook: UserDefaults.standard.getTelBookModel());
        let db = FMDatabase.init(url: DBFileSavePath?.appendingPathComponent(dbName))
        if db.open() {
            let selectSql = "delete from \(personTableName)";
            db.executeStatements(selectSql);
          
            let selectSql2 = "delete from \(deptTableName)";
            db.executeStatements(selectSql2);
            
            
            
            
        }
    }
   
}
