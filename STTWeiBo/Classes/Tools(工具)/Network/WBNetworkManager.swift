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


/// 网络管理工具 封装 AFN 的
class WBNetworkManager: AFHTTPSessionManager {

    /// 静态区（常量区）   
    ///静态区/常量/闭包/在第一次访问时执行闭包 并且将结果保存在 shared 常量中
//    static let shared = WBNetworkManager()//但是需要做一些初始化的动作 改成闭包
    /*
    /// 访问令牌 所有的网络请求 都基于此令牌（登录除外）
    /// 为了保护用户安全 token是有时限的 默认用户 是 三天    token过期的话 服务器返回的状态码是 403
    var accessToken:String? //= "2.00mqiHMEXmKOnDeff2feca1dip6eeB"
    /// 用户微博id
    var uid:String? = "5365823342"
*/
    static let shared:WBNetworkManager = {
        //实例化对象
        let instance = WBNetworkManager()
        
        //设置响应的反序列化
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }()
    
    //用户账户的懒加载属性
    lazy var userAccount = WBUserAccount()
    
    /// 用户登录标记(计算型属性)
    var userLogon:Bool{
        
        return userAccount.access_token != nil
    }
    
    
    /**
     专门负责拼接 token 的网络请求方法
     */
    func tokenRequest(method:WBHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject]?,completion:(json:AnyObject?,isSuccess:Bool)->()) {
        
        //处理Token字典
        // 0判断 token 是否 为nil  为 nil时 直接返回 程序执行过程中一般Token不会为nil
        guard let token = userAccount.access_token else{
           
            // 发送通知，提示用户登录（本方法不知道被谁调用 谁接收到通知 谁处理）
             print("没有 toekn！ 需要登录")
            NSNotificationCenter.defaultCenter().postNotificationName(WBUserShouldLoginNotification, object: nil)

            completion(json: nil, isSuccess: false)
            
            return
        }
        // 1 判断 参数字典是否存在 如果 为 nil 应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            
            //实例化字典
            parameters = [String:AnyObject]()
        }
        
        // 2设置参数字典 代码在此处 字典一定有值
        parameters!["access_token"] = token
        
        //调用 request 发起真正的网络请求方法
       request(URLString: URLString, parameters: parameters, completion: completion)
    }
    
    
    
    /**
     使用一个函数封装 AFN 的 GET  / POST 请求
     
     - parameter method:     GET /POST
     - parameter URLString:  URLString
     - parameter parameters: 参数字典
     - parameter completion: 完成回调 [json(字典/数组),是否成功 ]
     */
    func request(method:WBHTTPMethod = .GET,URLString: String,parameters:[String:AnyObject]?,completion:(json:AnyObject?,isSuccess:Bool)->()){
        
        // 成功回调
        let success = {(task:NSURLSessionTask,json:AnyObject?)->() in
            completion(json: json, isSuccess: true)
        }
        
        //失败回调
        let failure = {(task:NSURLSessionTask?,error:NSError)->() in
        
            //针对 403 处理 token 过期
            //对于测试用户(应用程序还没有提交给新浪微博审核)每天的刷新量是有限的
            //超出上限 token 会被锁定一段时间
            //解决办法 新建一个应用程序
            if (task?.response as? NSHTTPURLResponse)?.statusCode == 403{
                
                print("token 过期了")
                
                // 发送通知，提示用户再次登录（本方法不知道被谁调用 谁接收到通知 谁处理）
                NSNotificationCenter.defaultCenter().postNotificationName(WBUserShouldLoginNotification, object: "bad token")
            }
            
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
