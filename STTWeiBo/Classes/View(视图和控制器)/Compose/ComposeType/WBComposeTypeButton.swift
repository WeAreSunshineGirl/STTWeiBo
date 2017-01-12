//
//  WBComposeTypeButton.swift
//  STTWeiBo
//
//  Created by user on 17/1/6.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class WBComposeTypeButton: UIControl {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
//点击按钮要展现控制器的类型
    var clsName :String?
    /**
     使用图像名称/标题创建按钮 按钮布局从xib加载
     
     - parameter imageName: 图像名称
     - parameter title:     标题
     
     - returns: 图像按钮
     */
    class func composeTypeButton(imageName:String,title:String)->WBComposeTypeButton{
        let nib = UINib(nibName: "WBComposeTypeButton", bundle: nil)
        
        let btn = nib.instantiateWithOwner(nil, options: nil)[0] as! WBComposeTypeButton
        
        btn.imageView.image = UIImage(named: imageName)
        btn.titleLabel.text = title
        
        return btn



    }
}
