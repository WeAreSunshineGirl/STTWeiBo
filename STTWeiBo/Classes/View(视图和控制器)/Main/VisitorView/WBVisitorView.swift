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
    }
}