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
}
