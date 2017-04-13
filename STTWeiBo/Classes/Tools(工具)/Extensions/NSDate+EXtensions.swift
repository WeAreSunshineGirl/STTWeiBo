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

/// 当前日历对象
private let calender = NSCalendar.currentCalendar()

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
    
    /**
     将新浪格式的字符串转换成日期
     yyyy是小写的；大写的YYYY的意思有些不同——“将这一年中第一周的周日当作今年的第一天”，因此有时结果和yyyy相同，有时就会不同。
     
     - parameter string: Thu Apr 13 13:41:41 +0800 2017
     
     - returns: 日期
     */
    static func st_sinaDate(string:String)->NSDate?{
        
        // 1 设置日期格式
        dateFormatter.locale = NSLocale(localeIdentifier: "en")

        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        //2 转换并且返回日期
        return dateFormatter.dateFromString(string)
        
    }
    
    /*
     返回当前日期的描述信息
     
     刚刚(一分钟内)
     X分钟前(一小时内)
     X小时前(当天)
     
     昨天 HH:mm(昨天)
     MM-dd HH:mm(一年内)
     yyyy-MM-dd HH:mm(更早期)
     */

    var st_dateDescription:String{
        
        // 1 判断日期是否是今天
        if calender.isDateInToday(self) {
            
            let delta = -Int(self.timeIntervalSinceNow)
            
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta/60)分钟前"
            }
            
            return "\(delta/3600)小时前"
        }
        // 2 其他天
        
        var fmt = "HH:mm"
        if calender.isDateInYesterday(self) {
            
            fmt = "昨天" + fmt
        }else{
            
            fmt = "MM-dd " + fmt
            //日期的年
            let  year =  calender.component(.Year, fromDate: self)
            //当前的年
            let thisYear = calender.component(.Year, fromDate: NSDate())
            
            if year != thisYear {
                
                fmt = "yyyy-" + fmt
            }
        }
        
        //设置日期格式字符串
        dateFormatter.dateFormat = fmt
        return dateFormatter.stringFromDate(self)
    }
}