//
//  BNetWokingBase.swift
//  Fch_Contact
//
//  Created by bai on 2017/11/6.
//  Copyright © 2017年 北京仙指信息技术有限公司. All rights reserved.
//

import Foundation

/// 服务器地址
let BASE_URL = "http://telbook.fchsoft.com:8099/"




//登录
let Login_URL = BASE_URL + "userLogin";

//电话本详情，可以获取是否需要重新下载db文件
let TelBook_Detail_URL = BASE_URL + "telBook/detail"

//用户电话本列表
let TelBooksList_URL = BASE_URL + "telBook/list.json"

//db文件下载
let DownLoadDB_URL = BASE_URL + "/person/personList"

//imei验证接口
let TestIMEIVerify_URL = "http://oa.fchsoft.com:8442/mobile/checkImei.json";

//客户端更新接口
let AppUpdate_URL = BASE_URL + "/app/detail/1.json"


