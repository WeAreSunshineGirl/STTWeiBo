//
//  WBStatusViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

/// 单条微博的视图模型
class WBStatusViewModel {
    
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
}