//
//  WBWelcomeView.swift
//  STTWeiBo
//
//  Created by user on 16/12/19.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBWelcomeView: UIView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor.redColor()
//
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    class func welcomeView()->WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiateWithOwner(nib, options: nil)[0] as! WBWelcomeView
        //从xib 加载的视图 默认是 600 x 600的
        v.frame = UIScreen.mainScreen().bounds
        
        return v
    }

}
