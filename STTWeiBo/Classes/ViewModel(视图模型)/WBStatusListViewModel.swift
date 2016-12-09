
//
//  WBStatusListViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/9.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型
/*
 父类的选择
 -如果类需要使用 'KVC' 或者字典转模型框架设置对象值 类就需要继承自 NSObject
 -如果类只是包装一些代码逻辑（写了一些函数）,可以不用任何父类 好处：更加轻量级
 -提示：如果OC写 一律继承自 NSObject即可
 
 使命 ：负责微博的数据处理
 1 字典转模型
 2 下拉/上拉刷新数据处理
 */
class WBStatusListViewModel {
    
    /// 微博模型数组懒加载
    lazy var statusList = [WBStatus]()
    
    /**
     加载微博列表
     
     - parameter completion: 完成回调[网络请求是否成功]
     */
    func loadStatus(completion:(isSuccess:Bool)->()) {
        
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            
            //1 字典转模型
           guard let array = NSArray.yy_modelArrayWithClass(WBStatus.self, json: list ?? []) as? [WBStatus]else{
            
                completion(isSuccess: isSuccess)
                return
            }
            
            //2 拼接数据
            self.statusList += array
            
            //3 完成回调
            completion(isSuccess: isSuccess)
        }
        
    }
    
}