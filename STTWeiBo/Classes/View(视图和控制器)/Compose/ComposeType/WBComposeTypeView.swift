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