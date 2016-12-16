//
//  WBUserAccount.swift
//  STTWeiBo
//
//  Created by user on 16/12/14.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit


private let accountFile:NSString = "useraccount.json"

/// 用户账户信息
class WBUserAccount: NSObject {

    //访问令牌
    var access_token:String? //= "2.00mqiHMEXmKOnDeff2feca1dip6eeB"
    //用户代号
    var uid:String?
    //过期时间 单位秒 开发者 5年 使用者 3天
    var expires_in:NSTimeInterval = 0{
        
        didSet{
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
            
        }
    }
    //过期日期
    var expiresDate:NSDate?
    
    override var description: String{
        
        return yy_modelDescription()
    }
    
    
    override init() {
        
        super.init()
        
        //从磁盘加载保存的文件 -> 字典
        // 1 加载磁盘文件到二进制数据 如果失败直接返回
        guard let path = accountFile.cz_appendDocumentDir(),data = NSData(contentsOfFile: path),dict = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject] else{
            
            return
        }
        // 2 使用字典设置属性值
        yy_modelSetWithJSON(dict ?? [:])
        
        // 3判断token是否过期
        //测试过期日期 - 开发中 每一个分支都需要测试！
//        expiresDate = NSDate(timeIntervalSinceNow: -3600*24)  日期比现在日期小 就是过期  升序
//        print(expiresDate)
        
        if expiresDate?.compare(NSDate()) != .OrderedDescending{
            
            print("账户过期")
            
            //清空 token
            access_token = nil
            uid = nil
            
            //删除账户文件
           _ = try? NSFileManager.defaultManager().removeItemAtPath(path)
            
        }
    }
    
    
    
    
    
    /*
     1 偏好设置(小) - xcode8 beta 无效
     2 沙盒 - 归档/plist/json
     3 数据库(FMDB/CoreData)
     4 钥匙串访问(小/自动加密 - 需要使用框架 SSKeychain)
     */
    /**
     保存用户数据到json
     */
    func saveAccount() {
        
        // 1 模型转字典
        var dict = self.yy_modelToJSONObject() as? [String:AnyObject] ?? [:]
        
        //需要 删除 expires_in 的值
        dict.removeValueForKey("expires_in")
        
        // 2 字典序列化 data
        guard let data = try? NSJSONSerialization.dataWithJSONObject(dict, options: []),filePath = accountFile.cz_appendDocumentDir()else{
            return
        }
        
        // 3 写入磁盘
        (data as NSData).writeToFile(filePath, atomically: true)
        
        print("用户账户保存成功\(filePath)")
    }
}
