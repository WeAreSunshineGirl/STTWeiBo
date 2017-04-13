//
//  UIButton+Extensions.swift
//  SinaWeibo
//
//  Created by user on 16/8/9.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation
import UIKit


extension UIButton{
    
    //    func cz_textButton(title:String,fontSize:Int,normalColor:UIColor,highlightedColor:UIColor){
    //
    //        setTitle("好友", forState: .Normal)
    //        titleLabel?.font = UIFont.systemFontOfSize(CGFloat(fontSize))
    //        setTitleColor(normalColor, forState: .Normal)
    //        setTitleColor(highlightedColor, forState: .Highlighted)
    //        sizeToFit()
    //    }
    convenience init(title:String,fontSize:Int,normalColor:UIColor,highlightedColor:UIColor){
        self.init()
        setTitle(title, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(CGFloat(fontSize))
        setTitleColor(normalColor, forState: .Normal)
        setTitleColor(highlightedColor, forState: .Highlighted)
        sizeToFit()
    }
    convenience init(imageName: String, backImageName: String?)
    {
        self.init()
        
        // 1.设置背景图片
        if let backImageName = backImageName {
        setBackgroundImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named: backImageName + "_highlighted"), forState: UIControlState.Highlighted)
        }
        // 2.设置普通图片
        setImage(UIImage(named:imageName), forState: UIControlState.Normal)
        setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        
        sizeToFit()
    }
    convenience init(title:String,fontSize:Int,normalColor:UIColor,highlightedColor:UIColor,backImageName: String){
        self.init()
        setTitle(title, forState: .Normal)
        titleLabel?.font = UIFont.systemFontOfSize(CGFloat(fontSize))
        setTitleColor(normalColor, forState: .Normal)
        setTitleColor(highlightedColor, forState: .Highlighted)
        setBackgroundImage(UIImage(named: backImageName), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    /// - parameter backColor: 背景颜色（默认为nil）
    ///
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
        
        if let imageName = imageName {
            setImage(UIImage(named: imageName), forState: .Normal)
        }
        
        // 设置背景颜色
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        
        sizeToFit()
    }
    
    

}