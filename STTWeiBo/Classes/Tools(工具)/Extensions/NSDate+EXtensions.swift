//
//  NSDate+EXtensions.swift
//  STTWeiBo
//
//  Created by user on 17/4/7.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

/// 日期格式化器 - 不要频繁的释放和创建 会影响性能
private let dateFormatter = NSDateFormatter()

extension NSDate{
    
    /**
     计算与当前系统时间偏差 delta 秒数的日期字符串
     在swift 中 如果定义结构体的 ‘类’ 函数 使用 static 修饰 -》静态函数
     */
    static func  st_dateString(delta:NSTimeInterval)-> String{
        
        let date = NSDate(timeIntervalSinceNow: delta)
        
        //知道日期格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.stringFromDate(date)
    }
}