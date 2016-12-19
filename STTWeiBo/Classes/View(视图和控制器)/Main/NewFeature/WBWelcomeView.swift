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
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipView: UILabel!
    
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView()->WBWelcomeView{
        
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        
        let v = nib.instantiateWithOwner(nib, options: nil)[0] as! WBWelcomeView
        //从xib 加载的视图 默认是 600 x 600的
        v.frame = UIScreen.mainScreen().bounds
        
        return v
    }
    //自动布局系统 更新完成约束后会自动调用此方法
    //通常是对子视图布局进行修改
//    override func layoutSubviews() {
//        
//    }
    
    //视图被添加到 window 上 表示视图已经显示
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        //视图是使用自动布局来设置的 只是设置了约束
        // - 当视图被添加到窗口上时 根据父视图的大小 计算约束值 更新控件位置
        // - layoutIfNeeded 会按照当前的约束直接更新控件位置
        // - 执行之后 控件所在位置 就是 XIB 中布局的位置
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.size.height - 200
        
        // 如果 控件们的 frame 还没有计算好（所有的约束会一起动画）
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
            //更新约束
            self.layoutIfNeeded()
            }) { (_) in
                
        }
    }

}
