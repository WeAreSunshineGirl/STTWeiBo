//
//  WBVisitorView.swift
//  STTWeiBo
//
//  Created by user on 16/12/6.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

/// 访客视图
class WBVisitorView: UIView {

    ///构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: 设置界面
extension WBVisitorView{
    
    func setupUI() {
        backgroundColor = UIColor.whiteColor()
    }
}