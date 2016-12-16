//
//  WBTitleButton.swift
//  STTWeiBo
//
//  Created by user on 16/12/16.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    //重载构造函数
    //title 如果是nil 就显示首页
    // 如果不为 nil 显示 title 和箭头图像
    init(title:String?) {
        super.init(frame: CGRect())
        
        // 1 判断 title 是否为 nil
        if title == nil{
            setTitle("首页", forState: .Normal)
        }else{
            setTitle(title!, forState: .Normal)
            
            //设置图像
            setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        }
        // 2 设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFontOfSize(17)
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        // 3 设置大小
        sizeToFit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
