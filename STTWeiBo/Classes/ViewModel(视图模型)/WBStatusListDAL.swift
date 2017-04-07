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
     
     - parameter since_id:   下拉刷新 id
     - parameter max_id:     上拉刷新 id
     - parameter completion: 完成回调（微博的字典数组 是否成功）
     */
    class func loadStatus(since_id:Int64 = 0,max_id:Int64 = 0,completion:(list:[[String:AnyObject]]?,isSuccess:Bool)->()){
        
        // 1 检查本地数据 如果有 直接返回
        
        // 2 加载网络数据
        // 3 加载完成之后 将网络数据[字典数组] 写入数据库
        // 4 返回网络数据
    }
    
}