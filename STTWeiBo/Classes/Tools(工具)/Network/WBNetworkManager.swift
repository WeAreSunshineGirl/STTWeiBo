//
//  WBNetworkManager.swift
//  STTWeiBo
//
//  Created by user on 16/12/8.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

import AFNetworking


///Swift 的枚举支持任意数据类型
///switch / enum 在OC中都只支持整数
enum WBHTTPMethod {
    case GET
    case POST
}



/// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    /// 静态区（常量区）   
    ///静态区/常量/闭包/在第一次访问时执行闭包 并且将结果保存在 shared 常量中
    static let shared = WBNetworkManager()
    
    
    /**
     使用一个函数封装 AFN 的 GET  / POST 请求
     
     - parameter method:     GET /POST
     - parameter URLString:  URLString
     - parameter parameters: 参数字典
     - parameter completion: 完成回调 [json(字典/数组),是否成功 ]
     */
    func request(method:WBHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject],completion:(json:AnyObject?,isSuccess:Bool)->()){
        
        // 成功回调
        let success = {(task:NSURLSessionTask,json:AnyObject?)->() in
            completion(json: json, isSuccess: true)
        }
        
        //失败回调
        let failure = {(task:NSURLSessionTask?,error:NSError)->() in
            //error 通常比较吓人 例如编号：XXXX 错误原因一堆英文
            print("网络请求错误\(error)")
            completion(json: nil, isSuccess: false)
        }
        
        if method == .GET {
            GET(URLString, parameters: parameters, progress: nil, success: success, failure: failure)

        }else{
            POST(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
    
    
    
}
