//
//  WBStatusListDAL.swift
//  STTWeiBo
//
//  Created by user on 17/4/7.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

//DAL - Data Access Layer 数据访问层
//使命:负责处理数据库和网络数据 给 ListViewModel 返回微博的[字典数组]
/// 在调整系统的时候 尽量做最小化的调整
class WBStatusListDAL {
    
    /**
     从本地数据库 或者 网络加载数据
     
     提示：参数之所以参照网络接口 就是为了保证对原有代码的最小化调整
     - parameter since_id:   下拉刷新 id
     - parameter max_id:     上拉刷新 id
     - parameter completion: 完成回调（微博的字典数组 是否成功）
     */
    class func loadStatus(since_id:Int64 = 0,max_id:Int64 = 0,completion:(list:[[String:AnyObject]]?,isSuccess:Bool)->()){
        
        // 0 获取用户代号
        guard  let userId = WBNetworkManager.shared.userAccount.uid else{
            return
        }
        
        // 1 检查本地数据 如果有 直接返回
       let array =  STSQLiteManager.shared.loadStatus(userId, since_id: since_id, max_id: max_id)
        //判断数组的数量 没有数据返回的是没有数据的空数组[]
        if array.count > 0 {
            
            completion(list: array, isSuccess: true)
            
            return
        }
        // 2 加载网络数据
        WBNetworkManager.shared.statusList(since_id, max_id: max_id) { (list, isSuccess) in
            
            //判断网络请求是否成功
            if !isSuccess {
                completion(list: nil, isSuccess: false)
                return
            }
            
            //判断数据
            guard let list = list else{
                completion(list: nil, isSuccess: isSuccess)
                return
            }
            // 3 加载完成之后 将网络数据[字典数组]  同步写入数据库
            STSQLiteManager.shared.updateStatus(userId, array: list)
            // 4 返回网络数据
            completion(list: list, isSuccess: isSuccess)
        }
       
    }
    
}