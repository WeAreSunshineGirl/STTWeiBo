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
        
        //打开数据库
        createTable()
    }
    
}

// MARK: - 创建数据表以及其他私有方法
private extension STSQLiteManager{
    
    /**
     创建数据表
     */
    func createTable(){
        
        // 1 SQL
        guard  let path = NSBundle.mainBundle().pathForResource("status.sql", ofType: nil),sql = try? String(contentsOfFile: path)else{
            return
        }
        print(sql)
      // 2 执行 SQL - FMDB 的内部队列 串行队列，同步执行
        //可以保证同一时间，只有一个任务操作数据库， 从而保证数据库的读写安全
        queue.inDatabase { (db) in
            if  db?.executeStatements(sql) == true{
                
                print("创表成功")//先执行
            }else{
                print("创表失败")
            }
        }
        print("over")//后执行
    }
    
    
    
    
}