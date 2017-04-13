//
//  WBStatusPictureView.swift
//  STTWeiBo
//
//  Created by user on 16/12/23.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import SDWebImage
class WBStatusPictureView: UIView {
    
    
    var viewModel:WBStatusViewModel?{
        didSet{
            calcViewSize()
            //设置 urls
            urls = viewModel?.picURLs
        }
            
    }
    /**
      根据视图模型的配图视图大小调整显示内容
     */
    private func calcViewSize(){
        
        //处理宽度
        //1> 单图 根据配图视图的大小 修改 subViews[0]的宽高
        if viewModel?.picURLs?.count == 1 {
            
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            // 1)获取 第 0 个图像视图
            let v = subviews[0]
        
            v.frame = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: viewSize.width, height: viewSize.height - WBStatusPictureViewOutterMargin)
        }else{
            
            // 2> 多图 无图 恢复subViews[0]的宽高 保证九宫格布局的完整
            let v = subviews[0]
            v.frame = CGRect(x: 0, y: WBStatusPictureViewOutterMargin, width: WBStatusPictureItemWidth, height: WBStatusPictureItemWidth)

        }
        
        
        //修改高度约束
       heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
    
    /// 配图视图的数组
    private var urls:[WBStatusPicture]?{//带属性监视器的普通属性
        //我们需要在age属性发生变化后，更新这个属性
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
    
    @objc private func tapImageView(tap:UITapGestureRecognizer){
        print("点击了。。。。。")
        
        guard let iv = tap.view ,let picURLs = viewModel?.picURLs else{
            return
        }
//        print(picURLs.count)
        
        var selectedIndex = iv.tag
        
        //针对四张图像处理
        if picURLs.count == 4 && selectedIndex > 1 {
            selectedIndex -= 1
        }
        let urls = (picURLs as NSArray).valueForKey("thumbnail_pic") as! [String]
        
        //处理可见的图像视图数组
        var imageViewList = [UIImageView]()
        
        for iv in subviews as! [UIImageView] {
            
            if !iv.hidden {
                imageViewList.append(iv)
            }
        }
        print(selectedIndex)
        // 发送通知
        NSNotificationCenter.defaultCenter().postNotificationName(WBStatusCellBrowserPhotoNotification, object: self, userInfo: [WBStatusCellBrowserPhotoURLsKey:urls,WBStatusCellBrowserPhotoSelectedIndexKey:selectedIndex,WBStatusCellBrowserPhotoImageViewsKey:imageViewList])
    }
}


// MARK: - 照片查看器的展现协议




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
            
            
            
            //让imageView能够用户交互
            iv.userInteractionEnabled = true
            
            //添加点击手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
            iv.addGestureRecognizer(tap)
            
            //设置tag 
            iv.tag = i
            
        }
    }
}