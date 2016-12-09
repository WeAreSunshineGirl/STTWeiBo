
//
//  WBStatus.swift
//  STTWeiBo
//
//  Created by user on 16/12/9.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import YYModel


/// 微博数据模型
class WBStatus: NSObject {

    ///Int 类型 在64位的机器是 64 位 在 32 为 机器是 32位
    ///如果不写 Int64 在Ipad 2、iPhone 5、5c、4s、4 都无法正常运行
    var id:Int64 = 0
    
    /// 微博信息内容
    var text:String?
    
    /// 重写 description 的计算型属性
    override var description: String{
        return yy_modelDescription()
    }
}
