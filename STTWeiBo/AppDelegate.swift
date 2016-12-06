//
//  AppDelegate.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
//        sleep(2)
        
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
