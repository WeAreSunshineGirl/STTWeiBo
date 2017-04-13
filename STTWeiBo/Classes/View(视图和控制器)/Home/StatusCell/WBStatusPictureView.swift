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

extension WBStatusPictureView:PhotoBrowserPresentDelegate{
    /// 指定 indexPath 对应的 imageView，用来做动画效果
    func imageViewForPresent(indexPath: NSIndexPath) -> UIImageView{
        let iv = UIImageView()

        // 1. 设置内容填充模式
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true


        // 2. 设置图像（缩略图的缓存）- SDWebImage 如果已经存在本地缓存，不会发起网络请求
        //        if let url = viewModle?.thumbnailUrls?[indexPath.item] {
        //            iv.sd_setImageWithURL(url)
        //        }
        
        if  let url = viewModel?.picURLs![indexPath.item].thumbnail_pic{
            iv.sd_setImageWithURL(NSURL(string: url))
        }
        
        
        return iv
    }
    
    /// 动画转场的起始位置
    func photoBrowserPresentFromRect(indexPath: NSIndexPath) -> CGRect{
        // 1. 根据 indexPath 获得当前用户选择的 cell
        //        let cell = self.cellForItemAtIndexPath(indexPath)!
        
        //==============================================================================
        //===========================   为了 适合打开新浪微博 图片浏览器  针对四张图片做了处理
        var indeP:Int
        var cell:UIImageView
        var indexP:NSIndexPath
        if viewModel?.picURLs?.count == 4 && indexPath.item > 1 {
            indeP = indexPath.item + 1
            indexP = NSIndexPath(forItem: indeP, inSection: 0)
            cell = subviews[indexP.item] as! UIImageView
            
        }else{
            cell = subviews[indexPath.item] as! UIImageView
        }

//        let cell = subviews[indexPath.item] as! UIImageView
//==============================================================================================
        // 2. 通过 cell 知道 cell 对应在屏幕上的准确位置
        // 在不同视图之间的 `坐标系的转换` self. 是 cell 都父视图
        // 由 collectionView 将 cell 的 frame 位置转换的 keyWindow 对应的 frame 位置
        let rect = self.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        
        // 测试转换 rect 的位置
        //        let v = UIView(frame: rect)
        //        v.backgroundColor = UIColor.redColor()
        // 再次测试
        //        let v = imageViewForPresent(indexPath)
        //        v.frame = rect
        //
        //        UIApplication.sharedApplication().keyWindow?.addSubview(v)
        
        return rect
    }
    
    /// 动画转场的目标位置
    func photoBrowserPresentToRect(indexPath: NSIndexPath) -> CGRect{
        // 根据缩略图的大小，等比例计算目标位置
        
//        guard let key = viewModle?.thumbnailUrls?[indexPath.item].absoluteString else {
//            return CGRectZero
//        }
        
        guard let str = viewModel?.picURLs![indexPath.item].thumbnail_pic, key = NSURL(string:str)?.absoluteString else {
            return CGRectZero
        }
        
        // 从 sdwebImage 获取本地缓存图片
        guard let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key) else {
            return CGRectZero
        }
        
        // 根据图像大小，计算全屏的大小
        let w = UIScreen.mainScreen().bounds.width
        let h = image.size.height * w / image.size.width
        
        // 对高度进行额外处理
        let screenHeight = UIScreen.mainScreen().bounds.height
        var y: CGFloat = 0
        if h < screenHeight {       // 图片短，垂直居中显示
            y = (screenHeight - h) * 0.5
        }
        
        let rect = CGRect(x: 0, y: y, width: w, height: h)
        
        // 测试位置
        //        let v = imageViewForPresent(indexPath)
        //        v.frame = rect
        //
        //        UIApplication.sharedApplication().keyWindow?.addSubview(v)
        
        return rect
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