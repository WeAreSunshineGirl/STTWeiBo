//
//  STEmoticonTipView.swift
//  STTWeiBo
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 表情选择提示视图
class STEmoticonTipView: UIImageView {

    
    //MARK:私有控件
    private lazy var tipButton = UIButton()
    
    
    //MARK: 构造函数
    init(){
        let bundle = STEmoticonManager.shared.bundle
        let image = UIImage(named: "emoticon_keyboard_magnifier", inBundle: bundle, compatibleWithTraitCollection: nil)
        
        //[[UIImageView alloc] initWithImage:image] => 会根据图像大小设置图像视图的大小
        super.init(image: image)
        
        //设置锚点
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.2)
        
        //添加按钮
        tipButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        tipButton.frame = CGRect(x: 0, y: 8, width: 36, height: 36)
        
        tipButton.center.x = bounds.width * 0.5
        
        tipButton.setTitle("😄", forState: .Normal)
        tipButton.titleLabel?.font = UIFont.systemFontOfSize(32)
        
        addSubview(tipButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
