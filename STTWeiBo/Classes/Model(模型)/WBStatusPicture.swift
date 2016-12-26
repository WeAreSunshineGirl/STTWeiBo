//
//  WBStatusPicture.swift
//  STTWeiBo
//
//  Created by user on 16/12/26.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

/// 微博配图模型
class WBStatusPicture: NSObject {
    
    /// 缩略图地址
    var thumbnail_pic:String?
    
    
    override var description: String{
        
        return yy_modelDescription()
    }

}
