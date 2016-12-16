
//
//  UIBarButton+Extensions.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    ///创建UIBarButtonItem  便利构造函数
    /**
     创建UIBarButtonItem  构造函数
     
     - parameter title:    title
     - parameter fontSize: fontSize 默认 16
     - parameter target:   target
     - parameter action:   action
     - parameter isBack:   是否是返回按钮 如果是加上箭头
     
     - returns: UIBarButtonItem
     */
    convenience init(title:String,fontSize:CGFloat = 16,target:AnyObject?,action:Selector,isBack:Bool = false) {
        let btn:UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.orangeColor())
        
        if isBack{
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), forState: .Normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
            btn.sizeToFit()
        }

        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        //self.init  实例化 UIBarButtonItem
        self.init(customView:btn)
    }
}