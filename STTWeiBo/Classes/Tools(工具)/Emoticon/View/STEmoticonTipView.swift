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

    init(){
        let bundle = STEmoticonManager.shared.bundle
        let image = UIImage(named: "emoticon_keyboard_magnifier", inBundle: bundle, compatibleWithTraitCollection: nil)
        
        //[[UIImageView alloc] initWithImage:image] => 会根据图像大小设置图像视图的大小
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
