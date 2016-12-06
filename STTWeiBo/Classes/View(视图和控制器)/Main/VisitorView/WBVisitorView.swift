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

    //MARK:私有控件
    ///懒加载属性只有调用 UIKit 控件的指定函数 其他都需要使用类型
    /// 图像视图
    private lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    /// 小房子
    private lazy var houseIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示标签
    private lazy var tipLabel:UILabel = UILabel.cz_labelWithText("关注一些人，回这里看看有什么惊喜,关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGrayColor())
    
    /// 注册按钮
    private lazy var registerButton:UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orangeColor(), highlightedColor: UIColor.blackColor(), backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    private lazy var loginButton:UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.blackColor(), backgroundImageName: "common_button_white_disable")
    
}
//MARK: 设置界面
extension WBVisitorView{
    
    func setupUI() {
        backgroundColor = UIColor.whiteColor()
        
        ///1 添加控件
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        ///2 取消autoresizing   纯代码 默认 autoresizing xib 默认 autoLayout
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        ///3 自动布局
        let margin:CGFloat = 20.0
        
        //1 图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: -60))
        //2 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(item: houseIconView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        //3 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: iconView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 236))
        //4 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: tipLabel,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: tipLabel,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 100))
        //5 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: tipLabel,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: tipLabel,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: registerButton,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0))
        
        
    }
}