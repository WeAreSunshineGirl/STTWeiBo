//
//  WBNetworkManager+Extension.swift
//  STTWeiBo
//
//  Created by user on 16/12/8.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

// MARK: - 封装新浪微博的 网络请求方法 
extension WBNetworkManager{
    /**
     加载微博数据字典数组
     
     - parameter completion: 完成回调[list:微博字典数组，是否成功]
     */
    func statusList(completion:(list:[[String:AnyObject]]?,isSuccess:Bool)->()) {
        //用网络工具加载微博数据  对token进行封装
//        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
//        let params = ["access_token":"2.00mqiHMEXmKOnDdeff3a547e9YmKFD"]
//        
//        request(URLString: urlString, parameters: params) { (json, isSuccess) in
//            
//            //从json中获取statuses字典数组
//            //如果as？失败 result = nil
//            let result = json?["statuses"] as? [[String:AnyObject]]
//            
//            completion(list: result, isSuccess: isSuccess)
//        }
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenRequest(URLString: urlString, parameters: nil) { (json, isSuccess) in
            
            //从json中获取statuses字典数组
            //如果 as？失败 result = nil
            let result = json?["statuses"] as? [[String:AnyObject]]
            
            completion(list: result, isSuccess: isSuccess)
        }
    }
    
    
}