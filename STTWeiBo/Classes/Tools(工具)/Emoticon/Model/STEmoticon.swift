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
    var code:String?{
        didSet{
            guard let code = code else{
                return
            }
             //实例化字符扫描
            let scanner = NSScanner(string: code)
            //从 code 中扫描中十六进制的数值
            var result:UInt32 = 0
            
            scanner.scanHexInt(&result)
            
            let c = Character(UnicodeScalar(result))
            emoji = String(c)
        }
    }
    
    /// 表情使用次数
    var times:Int = 0
    
    /// emoji的字符串
    var emoji:String?
    
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
//        let attach = NSTextAttachment()
        let attach = STEmoticonAttachment()
        
        //记录属性文本文字
        attach.chs = chs
        
        attach.image = image
        let height = font.lineHeight
        attach.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        // 3直接返回当前表情模型对应的属性文本
        let attrStrM = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attach))
        //设置字体属性
        attrStrM.addAttributes([NSFontAttributeName:font], range: NSRange(location: 0, length: 1))
        
        // 4返回属性文本
        return attrStrM
    }
    override var description: String{
        
        return yy_modelDescription()
    }
}
