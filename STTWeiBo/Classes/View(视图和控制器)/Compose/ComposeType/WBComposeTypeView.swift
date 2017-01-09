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
    
    private let buttonInfos = [["imageName":"tabbar_compose_idea","title":"文字"],
                               ["imageName":"tabbar_compose_photo","title":"照片/视频"],
                               ["imageName":"tabbar_compose_weibo","title":"长微博"],
                               ["imageName":"tabbar_compose_lbs","title":"签到"],
                               ["imageName":"tabbar_compose_review","title":"点评"],
                               ["imageName":"tabbar_compose_more","title":"更多"],
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
        
        let v = nib.instantiateWithOwner(nil, options: nil)[0] as! WBComposeTypeView
        
        //XIB 加载默认 600 * 600
        v.frame = UIScreen.mainScreen().bounds
        
        return v
    }
    
    override func awakeFromNib() {
        setupUI()
    }
    
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
}
//private 让extension 中所有的方法都是私有的
private extension WBComposeTypeView{
    
    
    func setupUI(){
        
        // 1 创建类型按钮
        let btn = WBComposeTypeButton.composeTypeButton("tabbar_compose_music", title: "试一试")
        btn.center = center
        
        addSubview(btn)
        
        // 2 添加监听方法
        btn.addTarget(self, action: #selector(clickButton), forControlEvents: .TouchUpInside)
    }
}