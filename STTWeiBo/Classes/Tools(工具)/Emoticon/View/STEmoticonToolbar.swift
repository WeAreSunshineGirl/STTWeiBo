//
//  STEmoticonToolbar.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 表情键盘底部工具栏
class STEmoticonToolbar: UIView {

    override func awakeFromNib() {
        
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //布局所有按钮
        let count = subviews.count
        let w = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: bounds.height)
        
        for (i,btn) in subviews.enumerate() {
            
            btn.frame = rect.offsetBy(dx: CGFloat(i)*w, dy: 0)
        }
    }
}


private extension STEmoticonToolbar{
    
    func setupUI() {
        
        //0 获取表情管理单例
        let manager = STEmoticonManager.shared
        
        //从表情包分组名称 - 设置按钮
        for p in manager.packages {
            
            // 1 实例化按钮
            let btn = UIButton()
            
            // 2 设置按钮状态
            btn.setTitle(p.groupName, forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
            
            btn.backgroundColor = UIColor.blueColor()
            
            btn.sizeToFit()
            // 3  添加按钮
            addSubview(btn)
        }
    }
}