//
//  AppDelegate.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

//ios10
//import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        sleep(2)
        
       setupAdditions()
        
       
        
        window = UIWindow()
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = WBMainViewController()
        
        window?.makeKeyAndVisible()
        
        
        
        loadAppInfo()
        
        
        return true
    }


}
//MARK: 从服务器加载应用程序信息
extension AppDelegate{
    private func setupAdditions(){
        /*
        //#available 是检测设备版本 如果是10.0以上
        if #available(ios 10.0, *){
            UNUserNotificationCenter.current().requestAuthorization([.alert,.badge,.carPlay,.sound]){(success,error) in
                print("授权" + (success ? "成功" : "失败"))
            }
        }else{
            //10.0 以下
            //取得用户授权显示通知[上方的提示条/声音/badgeNumber]
            let notifySettings = UIUserNotificationSettings(forTypes: [.Alert,.Badge,.Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(notifySettings)
        }
 */
        //10.0 以下
        //取得用户授权显示通知[上方的提示条/声音/badgeNumber]
        let notifySettings = UIUserNotificationSettings(forTypes: [.Alert,.Badge,.Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notifySettings)
    }
    private func loadAppInfo(){
        //1 模拟异步
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            
            // 1 url 只是用的假数据 实际应该是网络请求
            let url = NSBundle.mainBundle().URLForResource("demo.json", withExtension: nil)
            
            // 2data
            let data = NSData(contentsOfURL: url!)
            
            //3 写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            let jsonPath = (docDir as NSString).stringByAppendingPathComponent("main.json")
            
            //直接保存在沙盒 等待下一次程序启动使用
            data?.writeToFile(jsonPath, atomically: true)
            print("应用程序加载完毕\(jsonPath)")
        }
    }
}


//测试工具 的 token 2.00mqiHMEXmKOnDdeff3a547e9YmKFD



//微博 home  url https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00mqiHMEXmKOnDdeff3a547e9YmKFD
//get


//获取某个用户的各种消息未读数
//https://rm.api.weibo.com/2/remind/unread_count.json











//https://www.raywenderlich.com/category/swift


//http://nshipster.com

//http://www.objc.io

//http://objccn.io 王巍 onevcat

//http://designcode.io/

