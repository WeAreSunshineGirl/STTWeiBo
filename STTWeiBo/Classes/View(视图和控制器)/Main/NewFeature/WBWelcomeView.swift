//
//  WBWelcomeView.swift
//  STTWeiBo
//
//  Created by user on 16/12/19.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomeView: UIView {

//    override init(frame: CGRect) {//纯代码入口
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
    
    required init?(coder aDecoder: NSCoder) {//xib 入口
        super.init(coder: aDecoder)
        //        提示 initWithCode 只是刚刚 从 xib 的二进制文件将视图数据加载完成  还没有和代码连线建立关系 所以开发时 千万不要在这个方法中处理  UI
        print("initWithCode \(iconView)")//nil
        
    }
    override func awakeFromNib() {
        //         1 url
        guard let urlString = WBNetworkManager.shared.userAccount.avatar_large, url = NSURL(string: urlString) else{
            return
        }
        //        2 设置头像 如果网络头像没有下载完成 先显示占位头像
        //        如果不指定占位头像 之前设置的头像会被清空
        iconView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default_big"))
        // 3 设置圆角
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.clipsToBounds = true
        iconView.layer.masksToBounds = true
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
                UIView.animateWithDuration(1.0, animations: { 
                    self.tipView.alpha = 1
                    }, completion: { (_) in
                        self.removeFromSuperview()
                })
        }
    }

}
