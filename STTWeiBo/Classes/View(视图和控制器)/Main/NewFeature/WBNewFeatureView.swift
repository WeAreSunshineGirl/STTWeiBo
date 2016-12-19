//
//  WBNewFeatureView.swift
//  STTWeiBo
//
//  Created by user on 16/12/19.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = UIColor.orangeColor()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBAction func enterStatus() {
        removeFromSuperview()
    }
    
    class func newFeatureView()->WBNewFeatureView{
        
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        
        let v = nib.instantiateWithOwner(nib, options: nil)[0] as! WBNewFeatureView //此处调用 awakeFromNib方法
        //从xib 加载的视图 默认是 600 x 600的
        v.frame = UIScreen.mainScreen().bounds
        
        return v
    }
    
    override func awakeFromNib() {
        // 如果使用自动布局设置的界面  从 xib 加载默认是 600 x 600 的大小
        //添加 4 个视图
        let count = 4
        let rect = UIScreen.mainScreen().bounds
        
        for i in 0..<count {
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
            
            //指定 scrollView的属性
            scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.bounces = false
            scrollView.pagingEnabled = true
            
            
            scrollView.delegate = self
            
            //隐藏按钮
            enterButton.hidden = true
        }
    }

}

extension WBNewFeatureView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //1 滚动到最后一屏 让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        //2 判断是否是最后一页
        if page == scrollView.subviews.count{
            print("欢迎欢迎 进入主页")
            removeFromSuperview()
        }
        // 3 如果是倒数第二页 显示按钮
        enterButton.hidden  = (page != scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 0 一旦滚动 隐藏按钮
        enterButton.hidden = true
        
        // 1 计算当前的偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        // 2设置分页控件
        pageControl.currentPage = page
        
        // 3 分页控件的隐藏
        pageControl.hidden = (page == scrollView.subviews.count)
    }
}