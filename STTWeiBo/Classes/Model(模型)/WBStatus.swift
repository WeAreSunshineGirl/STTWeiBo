
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
    
    /// 微博来源 - 发布微博使用的客户端
    var source:String?
    
    /// 微博创建时间字符串
    var created_at:String?
    
    /// 微博的用户 - 注意和服务器返回的 KEY 要一致
    var user:WBUser?
    
    /// 转发数
    var reposts_count:Int = 0
    
    /// 评论数
    var comments_count:Int = 0
    
    /// 表态数
    var attitudes_count:Int = 0
    
    /// 微博配图模型数组  
    var pic_urls:[WBStatusPicture]?
    
    /// 被转发的原创微博
    var retweeted_status:WBStatus?
    
    /// 重写 description 的计算型属性
    override var description: String{
        
        return yy_modelDescription()
    }
    //返回容器类中的所需要存放的数据类型（以Class 或 Class Name 的形式）
    /// 类函数 -> 告诉第三方框架 YY_Model 如果遇到数组类型的属性 数组中存放的对象是什么类？
    /// NSArray 中保存对象的类型通常是 ‘id’ 类型
    /// OC中的泛型是 Swift 推出后 苹果为了兼容给 OC 增加的
    /// 从运行的角度 仍然不知道数组中应该存放什么类型的对象
    class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["pic_urls":WBStatusPicture.self]
    }
}
