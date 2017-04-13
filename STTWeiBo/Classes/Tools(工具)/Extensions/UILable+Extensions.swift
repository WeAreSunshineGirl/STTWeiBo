//
//  UILable+Extensions.swift
//  SinaWeibo
//
//  Created by user on 16/8/10.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit


extension UILabel{
    convenience init(withText:String,fontSize:CGFloat,color:UIColor) {
        self.init()
        text = withText
        font = UIFont.systemFontOfSize(fontSize)
        textColor = color
        sizeToFit()
        numberOfLines = 0
    }
}
