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
            setTitle(title! + " ", forState: .Normal)
            
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

    
    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()

        //判断label 和 imageView 是否同时存在
        guard let titleLabel = titleLabel,imageView = imageView else{
            return
        }
        print("调整布局按钮")
        
        //将 label 的 x 向左移动 imageView 的宽度
//        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        //将 imageView 的 x 向右移动 label 的宽度
//        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
       
        //       将 label 的 x 向左移动 imageView 的宽度
        //OC中不允许直接修改结构体内部的值
        //    swift中可以直接就修改
        titleLabel.frame.origin.x = 0
        //        将 imageView 的 x 向右移动 label 的宽度
        imageView.frame.origin.x = titleLabel.bounds.width
    }
}
