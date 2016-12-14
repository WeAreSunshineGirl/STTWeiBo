//
//  WBUserAccount.swift
//  STTWeiBo
//
//  Created by user on 16/12/14.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

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
    /*
     1 偏好设置(小) - xcode8 beta 无效
     2 沙盒 - 归档/plist/json
     3 数据库(FMDB/CoreData)
     4 钥匙串访问(小/自动加密 - 需要使用框架 SSKeychain)
     */
    func saveAccount() {
        
        
    }
}
