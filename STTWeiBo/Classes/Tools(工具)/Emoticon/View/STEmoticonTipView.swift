//
//  STEmoticonTipView.swift
//  STTWeiBo
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import pop
/// 表情选择提示视图
class STEmoticonTipView: UIImageView {

    /// 之前选择的表情
    private var preEmoticon:STEmoticon?
    
    /// 提示视图的表情模型
    var emoticon:STEmoticon?{
        didSet{
            
            //判断表情是否变化
            if emoticon == preEmoticon {
                return
            }
            //记录当前的表情
            preEmoticon = emoticon
            
            //设置表情数据
            tipButton.setTitle(emoticon?.emoji, forState: .Normal)
            tipButton.setImage(emoticon?.image, forState: .Normal)
            
            //表情的动画 弹力动画的结束时间是根据速度自动计算的 不需要也不指定 duration
            let anim:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
           
            anim.fromValue = 30
            anim.toValue = 8
            
            anim.springSpeed = 20
            anim.springBounciness = 20
            
            tipButton.layer.pop_addAnimation(anim, forKey: nil)
            print("设置表情....")
        }
    }
    
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
