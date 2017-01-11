//
//  WBComposeTypeView.swift
//  STTWeiBo
//
//  Created by user on 17/1/6.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 撰写微博类型视图
class WBComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    //关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    //返回前一页按钮约束
    @IBOutlet weak var returnButtonCenterXCons: NSLayoutConstraint!
    //返回前一页按钮
    @IBOutlet weak var returnButton: UIButton!
    
    private let buttonInfos = [["imageName":"tabbar_compose_idea","title":"文字"],
                               ["imageName":"tabbar_compose_photo","title":"照片/视频"],
                               ["imageName":"tabbar_compose_weibo","title":"长微博"],
                               ["imageName":"tabbar_compose_lbs","title":"签到"],
                               ["imageName":"tabbar_compose_review","title":"点评"],
                               ["imageName":"tabbar_compose_more","title":"更多","actionName":"clickMore"],
                               ["imageName":"tabbar_compose_friend","title":"好友圈"],
                               ["imageName":"tabbar_compose_wbcamera","title":"微博相机"],
                               ["imageName":"tabbar_compose_music","title":"音乐"],
                               ["imageName":"tabbar_compose_shooting","title":"拍摄"]]
//    override init(frame: CGRect) {
//        
//        super.init(frame: UIScreen.mainScreen().bounds)
//        
//        backgroundColor = UIColor.orangeColor()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    /**
     关闭视图
     */
    @IBAction func close() {
        
        removeFromSuperview()
    }
    class func composeTypeView()->WBComposeTypeView{
        
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        
        // 从 XIB 加载完成视图 就会调用 awakeFromNIb
        let v = nib.instantiateWithOwner(nil, options: nil)[0] as! WBComposeTypeView
        
        
        //XIB 加载默认 600 * 600
        v.frame = UIScreen.mainScreen().bounds
        
        v.setupUI()
        
        return v
    }
    
//    override func awakeFromNib() {
//        setupUI()
//    }
//    
    /**
     显示当前视图
     */
    func show(){
        
        // 1> 将当前视图 添加到 根视图控制器的 view
        guard let mainWindow = UIApplication.sharedApplication().keyWindow?.rootViewController else{
            return
        }
       
        // 2 > 添加视图
        mainWindow.view.addSubview(self)
    }
    
    //MARK:监听方法
    @objc private func clickButton(){
        print("按钮点击")
    }
    
    //点击更多按钮
    @objc private func clickMore(){
        print("点击更多")
        //将scrollView滚动到第二页
        let offset = CGPoint(x: scrollView.bounds.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        
        //处理底部按钮 让两个按钮分开
        returnButton.hidden = false
        
        let margin = scrollView.bounds.width / 6
        closeButtonCenterXCons.constant += margin
        
        returnButtonCenterXCons.constant -= margin
        
        UIView.animateWithDuration(0.25) { 
            self.layoutIfNeeded()
        }
        
    }
}
//private 让extension 中所有的方法都是私有的
private extension WBComposeTypeView{
    
    
    func setupUI(){
        
        // 0 强行更新布局
        layoutIfNeeded()
        
        // 1 向scrollView 添加视图
        
        let rect = scrollView.bounds
        
        let width = scrollView.bounds.width
        for i in 0..<2 {
            
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
         
            // 2 向视图添加按钮
            addButtons(v, idx: i * 6)
            
            // 3 将试图添加到 scrollView
            scrollView.addSubview(v)
        }
        
        // 设置 scrollView的contentSize
        scrollView.contentSize = CGSize(width:2 * width, height: 0)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = false
        
        //禁用滚动
        scrollView.scrollEnabled = false
    }
    
    /**
     向 v 中添加按钮 按钮的数组索引 从 idx 开始
     
     - parameter v:   视图
     - parameter idx: 索引
     */
    func addButtons(v:UIView,idx:Int){
        
        let count = 6
        // 从 idx 开始 添加 6 个按钮
        for i in idx..<(idx + count) {
            
            if i >= buttonInfos.count {
                break
            }
            
            // 0 从数组字典中获取图像名称 和 title
           let dict = buttonInfos[i]
            
            guard let imageName = dict["imageName"], title = dict["title"]else{
                continue
            }
            
            // 1 创建按钮
            let btn = WBComposeTypeButton.composeTypeButton(imageName, title: title)
            
            // 2 将btn添加到视图
            v.addSubview(btn)
            
            // 3 添加监听方法
            if let actionName = dict["actionName"] {
                //OC中使用 NSSelectorFromString(@"clickMore")
                btn.addTarget(self, action: Selector(actionName), forControlEvents: .TouchUpInside)
            }
        }
        
        // 遍历视图的子视图 布局按钮
        //准备常量
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for (i,btn) in v.subviews.enumerate() {
            
            let y:CGFloat = (i > 2) ? (v.bounds.height - btnSize.height) : 0
            let col = i % 3
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
        
    }
}