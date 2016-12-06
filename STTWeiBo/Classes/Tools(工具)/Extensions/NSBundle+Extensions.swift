//
//  NSBundle+Extensions.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation
extension NSBundle{
    //计算型属性类似于函数 没有参数 有返回值
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}