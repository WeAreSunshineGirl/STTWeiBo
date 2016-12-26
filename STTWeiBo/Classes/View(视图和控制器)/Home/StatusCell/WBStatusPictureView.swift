//
//  WBStatusPictureView.swift
//  STTWeiBo
//
//  Created by user on 16/12/23.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    /// 配图视图的高度
    @IBOutlet weak var heightCons:NSLayoutConstraint!

    
    override func awakeFromNib() {
        
        setupUI()
    }
    
}

// MARK: - 设置界面
extension WBStatusPictureView{
    
    // 1 cell 中多有的控件都是提前准备好
    // 2 设置的时候 根据数据觉得是否显示
    // 3 不要动态创建控件
    private func setupUI(){
        
        /// 超出边界的内容不显示
        clipsToBounds = true
        
        let count = 3
        let rect = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWidth, height: WBStatusPictureItemWidth)
        // 1 循环创建 9 个 imageView
        for i in 0..<count * count {
            
            let iv = UIImageView()
            
            iv.backgroundColor = UIColor.redColor()
            
            // 行 - Y
            let row = CGFloat( i / count)
            // 列 - X
            let col = CGFloat( i % count)
            
            let xOffset = col * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            let yOffset = row * (WBStatusPictureItemWidth + WBStatusPictureViewInnerMargin)
            iv.frame = rect.offsetBy(dx:xOffset , dy: yOffset)
            
            addSubview(iv)
        }
    }
}