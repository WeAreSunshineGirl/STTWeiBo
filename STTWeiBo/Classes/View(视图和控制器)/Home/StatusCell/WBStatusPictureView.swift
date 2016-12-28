//
//  WBStatusPictureView.swift
//  STTWeiBo
//
//  Created by user on 16/12/23.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    
    
    var viewModel:WBStatusViewModel?{
        didSet{
            calcViewSize()
        }
            
    }
    /**
      根据视图模型的配图视图大小调整显示内容
     */
    private func calcViewSize(){
        
        //修改高度约束
       heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    /// 配图视图的数组
    var urls:[WBStatusPicture]?{
        didSet{
            
            // 1 隐藏所有的imageView
            for v in subviews {
                v.hidden = true
            }
            
            // 2 遍历 urls 数据 顺序设置图像
            var index = 0
            for url in urls ?? []{
                
                // 获得对应索引的 imageView
                let iv = subviews[index] as! UIImageView
                
                // 4张图像处理
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                
                //设置图像
                iv.cz_setImage(url.thumbnail_pic, placeholderImage: nil)
                
                //显示图像
                iv.hidden = false
                
                index += 1
                
            }
        }
    }
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
        
        //设置背景颜色
        backgroundColor = superview?.backgroundColor
        
        /// 超出边界的内容不显示
        clipsToBounds = true
        
        let count = 3
        let rect = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWidth, height: WBStatusPictureItemWidth)
        // 1 循环创建 9 个 imageView
        for i in 0..<count * count {
            
            let iv = UIImageView()
            
            //设置 contemtMode
            iv.contentMode = .ScaleAspectFill
            iv.clipsToBounds = true
            
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