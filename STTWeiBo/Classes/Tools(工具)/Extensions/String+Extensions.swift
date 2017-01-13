//
//  String+Extensions.swift
//  正则表达式
//
//  Created by user on 17/1/13.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

extension String{
    
    //从当前字符串中提取 链接 和文本
    // swift 提供了元祖 可以同时返回多个值
    // 如果OC 可以返回字典 、自定义对象  、指针的指针
    func cz_href()->(link:String,text:String)?{
        
        // 1 创建正则表达式 并且匹配第一项
        let pattern = "<a href=\"(.*?)\" .*?>(.*?)</a>"
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []),result = regx.firstMatchInString(self, options: [], range: NSRange(location: 0, length: characters.count)) else{
            print("没有找到匹配项")
            return nil
        }
        
       // 2 获取结果
        let link = (self as NSString).substringWithRange(result.rangeAtIndex(1))
        let text = (self as NSString).substringWithRange(result.rangeAtIndex(2))
        
        return (link,text)
    }
}