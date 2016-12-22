//
//  WBStatusViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation



/// 单条微博的视图模型  没有继承 NSObject  所以敲不出 description  让它遵守一个协议就行了
/*
 如果没有任何父类 如果希望在开发时调试 输出调试信息 需要
 1. 遵守 CustomStringConvertible 
 2. 实现 description 计算型属性
 
 关于表格的性能优化
 - 尽量少计算 所有需要的素材 提前计算好
 - 控件上不要设置圆角半径 所有图像渲染的属性 都要注意
 - 不要动态创建 所有需要的控件都要提前创建好 在显示的时候 根据数据隐藏/显示
 - cell 中控件的层次越少越好 ，数量越少越好
 - 要测量 不要猜测
 */
class WBStatusViewModel:CustomStringConvertible {
    
    /// 微博模型  - 没有设可选项 在构造函数中 设置初始值
    var status:WBStatus
    
    /// 会员图标 - 存储型属性（用内存 换 CPU）
    var memberIcon:UIImage?
    /// 认证类型 -1:没有认证 0 认证用户 2 3 5 企业认证 220 达人
    var vipIcon:UIImage?
    /**
     构造函数
     
     - parameter model: 微博模型
     
     - returns: 微博的视图模型
     */
    init(model:WBStatus){
        self.status = model
        
        //直接计算出会员等级 0 -6 common_icon_membership_level1
        if model.user?.mbrank > 0 && model.user?.mbrank < 7{
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        //认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }

        
    }
    
    var description: String{
        return status.description
    }
    
}