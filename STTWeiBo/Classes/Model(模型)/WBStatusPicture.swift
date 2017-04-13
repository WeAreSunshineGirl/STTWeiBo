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
    
    /// 缩略图地址 新浪返回的缩略图令人发指
    var thumbnail_pic:String?{
        didSet{
//            http://wx2.sinaimg.cn/thumbnail/cc4db942ly1fejof9ygdij20m80citcz.jpg
//            print(thumbnail_pic)
            
            
            //设置中等尺寸图片
            bmiddlePic =  thumbnail_pic?.stringByReplacingOccurrencesOfString("/thumbnail/", withString: "/wap360/")
            //更改缩略图地址  更清晰点
            thumbnail_pic = thumbnail_pic?.stringByReplacingOccurrencesOfString("/thumbnail/", withString: "/wap360/")
        }
    }
    
    /// 中等尺寸图片
    var bmiddlePic:String?
    
    override var description: String{
        
        return yy_modelDescription()
    }

}
