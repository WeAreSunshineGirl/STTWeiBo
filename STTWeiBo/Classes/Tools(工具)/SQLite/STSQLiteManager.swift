//
//  STSQLiteManager.swift
//  STTWeiBo
//
//  Created by user on 17/4/6.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

import FMDB
/// SQLite 管理器

/*
 1 数据库本质上是保存在沙盒中的一个文件，首先需要创建并且打开数据库
    FMDB - 队列
 2 创建数据表
 3 增删改查
 
 */
class STSQLiteManager{
    
    /// 单例 全局数据库工具访问点
    static let shared = STSQLiteManager()
    
     //数据库队列  常量
    let queue:FMDatabaseQueue
    
    ///构造函数
    private init(){
        
        //数据库的全路径 - path
        let dbName = "status.db"
        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path = (path as NSString).stringByAppendingPathComponent(dbName)
        
        print("数据库的路径 \(path)")
         //创建数据库队列 同时 ‘创建或打开’ 数据库
       queue = FMDatabaseQueue(path: path)
        
    }
    
}