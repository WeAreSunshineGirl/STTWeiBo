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

     //MARK: 设置访客视图信息 属性字典
    /// 访客视图的信息字典 [imageName / message]
    ///如果是首页 imageName == ""
    var visitorInfo:[String:String]?{
        didSet{
            //1 取字典信息
            guard let imageName = visitorInfo?["imageName"],message = visitorInfo?["message"]
                else{
                    return
            }
            //2 设置消息
            tipLabel.text = message
            
            //3 设置图像 首页不需要设置
            if imageName == "" {
                return
            }
            iconView.image = UIImage(named: imageName)
            
            //其他控制器不需要显示小房子
            houseIconView.hidden = true
            maskIconView.hidden = true
        }
    }
    
    //MARK:构造函数
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
    
    /// 遮罩图像
    private lazy var maskIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 小房子
    private lazy var houseIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示标签
    private lazy var tipLabel:UILabel = UILabel.cz_labelWithText("关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGrayColor())
    
    /// 注册按钮
    private lazy var registerButton:UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orangeColor(), highlightedColor: UIColor.blackColor(), backgroundImageName: "common_button_white_disable")
    
    /// 登录按钮
    private lazy var loginButton:UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.blackColor(), backgroundImageName: "common_button_white_disable")
    
}
//MARK: 设置界面
extension WBVisitorView{
    
    func setupUI() {
        //在开发的时候 如果能够使用颜色 就不要使用图像 效率会更高
        backgroundColor = UIColor.cz_colorWithHex(0xEDEDED)
        
        ///1 添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        //      文本居中
        tipLabel.textAlignment = .Center
        
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
            constant: -100))
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
        //6 遮罩图像
        //views:定义 VFL 中的控件名称和实际名称映射关系
        //metrics 定义 VFL 中（） 指定的常数映射关系
        let viewDict = ["maskIconView":maskIconView,"registerButton":registerButton]
        
        let metrics = ["spacing":15]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[maskIconView]-(spacing)-[registerButton]", options: [], metrics:metrics, views: viewDict))
        
    }
}