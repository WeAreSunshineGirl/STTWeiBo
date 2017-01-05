//
//  STRefreshView.swift
//  刷新控件
//
//  Created by user on 17/1/4.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 刷新视图 - 负责刷新相关的UI 显示 和 动画
class STRefreshView: UIView {

    //刷新状态
    /*iOS系统中 UIView封装的动画旋转   
     -默认顺时针旋转
     -就近原则
     -要想实现同方向旋转 需要调整一个 非常小的数字(近)
     -如果想实现360 旋转 需要核心动画 CABaseAnimation
     */
    var refreshState:STRefreshState = .Normal{
        didSet{
            switch refreshState {
            case .Normal:
                //恢复状态
                indicator.stopAnimating()
                // 显示 刷新图标
                tipIcon.hidden = false
                
                tipLabel.text = "继续使劲拉..."
                UIView.animateWithDuration(0.25, animations: {
                    self.tipIcon.transform = CGAffineTransformIdentity
                })
            case .Pulling:
                tipLabel.text = "放手就刷新..."
                UIView.animateWithDuration(0.25, animations: { 
                    self.tipIcon.transform = CGAffineTransformMakeRotation(CGFloat(M_PI - 0.001))
                })
            case .WillRefresh:
                tipLabel.text = "正在刷新中..."
                
                //隐藏提示图标 
                tipIcon.hidden = true
                //显示菊花
                indicator.startAnimating()
                
            }
        }
            
    }
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
   /// 提示图标
    @IBOutlet weak var tipIcon: UIImageView!
   /// 提示标签
    @IBOutlet weak var tipLabel: UILabel!
    
    
    
    
    class func refreshView()->STRefreshView{
        //箭头刷新
//        let nib = UINib(nibName: "STRefreshView", bundle: nil)
        // 小人刷新
//        let nib = UINib(nibName: "SThumRefreshView", bundle: nil)
        // 美团刷新
        let nib = UINib(nibName: "STMeiTuanRefreshView", bundle: nil)

        return nib.instantiateWithOwner(nib, options: nil)[0] as! STRefreshView
    }
    
}
