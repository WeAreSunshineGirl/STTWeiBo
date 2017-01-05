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
    var refreshState:STRefreshState = .Normal
    
    /// 指示器
    @IBOutlet weak var indicator: UIActivityIndicatorView!
   /// 提示图标
    @IBOutlet weak var tipIcon: UIImageView!
   /// 提示标签
    @IBOutlet weak var tipLabel: UILabel!
    
    
    
    
    class func refreshView()->STRefreshView{
        let nib = UINib(nibName: "STRefreshView", bundle: nil)
        return nib.instantiateWithOwner(nib, options: nil)[0] as! STRefreshView
    }
    
}
