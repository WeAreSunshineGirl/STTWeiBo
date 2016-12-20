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
 */
class WBStatusViewModel:CustomStringConvertible {
    
    /// 微博模型  - 没有设可选项 在构造函数中 设置初始值
    var status:WBStatus
    
    /**
     构造函数
     
     - parameter model: 微博模型
     
     - returns: 微博的视图模型
     */
    init(model:WBStatus){
        self.status = model
    }
    
    var description: String{
        return status.description
    }
    
}