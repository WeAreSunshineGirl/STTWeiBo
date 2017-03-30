//
//  STEmoticon.swift
//  表情包数据
//
//  Created by user on 17/1/17.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import YYModel

/// 表情模型
class STEmoticon: NSObject {

    /// 表情类型 false - 图片表情 / true - emoji
    var type = false
    /// 表情字符串 发送给新浪微博的服务器[节约流量]
    var chs:String?
    /// 表情图片名称 用于本地图文混排
    var png:String?
    /// emoji 的十六进制编码
    var code:String?
    
    /// 表情模型所在目录  方便获取图像
    var directory:String?

    //图片表情对应的图像  （计算型属性）
    var image:UIImage?{
        
        //判断表情类型
        if type {
            return nil
        }
        
        guard let directory = directory,png = png,path = NSBundle.mainBundle().pathForResource("EmotionIcons.bundle", ofType: nil),bundle = NSBundle(path: path)
            else{
            return nil
        }
        //将plist中对应的图片字符串  返回 一张同名的图像    直接返回表情模型对应的图像
       return  UIImage(named: "\(directory)/\(png)", inBundle: bundle, compatibleWithTraitCollection: nil)
        
    }
    
    //将当前图像转换生成图片的属性文本
    func imageText(font:UIFont) -> NSAttributedString {
        
        // 1 判断图像是否存在
        guard let image = image else{
            return NSAttributedString(string: "")
        }
        // 2 创建文本附件
        let attach = NSTextAttachment()
        attach.image = image
        let height = font.lineHeight
        attach.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        //直接返回当前表情模型对应的属性文本
        return NSAttributedString(attachment: attach)
    }
    override var description: String{
        
        return yy_modelDescription()
    }
}
