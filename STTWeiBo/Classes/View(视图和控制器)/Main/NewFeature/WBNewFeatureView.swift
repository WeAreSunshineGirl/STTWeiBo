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
            
            //隐藏按钮
            enterButton.hidden = true
        }
    }
    
    
    
    
    
}
