//
//  STEmoticonToolbar.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

@objc protocol STEmoticonToolbarDelegate:NSObjectProtocol {
    
    /**
     表情工具栏选中分组项索引
     
     - parameter toolbar: 工具栏
     - parameter index:   索引
     */
    func emoticonToolbarDidSelectedItemIndex(toolbar:STEmoticonToolbar,index:Int)
}

/// 表情键盘底部工具栏
class STEmoticonToolbar: UIView {

    weak var delegate:STEmoticonToolbarDelegate?
    
    var selectedIndex:Int = 0{
        didSet{
            
            // 1 取消所有的选中状态
            for btn in subviews as! [UIButton] {
                
                btn.selected = false
            }
            
            // 2 设置index 对应的选中状态
            (subviews[selectedIndex] as! UIButton).selected = true
        }
    }
    
    override func awakeFromNib() {
        
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //布局所有按钮
        let count = subviews.count
        let w = bounds.width / CGFloat(count)
        let rect = CGRect(x: 0, y: 0, width: w, height: bounds.height)
        
        for (i,btn) in subviews.enumerate() {
            
            btn.frame = rect.offsetBy(dx: CGFloat(i)*w, dy: 0)
        }
    }
    
    //MARK:监听方法
    //点击分组项按钮
    @objc private func clickItem(button:UIButton){
        
        // 通知代理执行协议方法
        delegate?.emoticonToolbarDidSelectedItemIndex(self, index: button.tag)
        
    }
}


private extension STEmoticonToolbar{
    
    func setupUI() {
        
        //0 获取表情管理单例
        let manager = STEmoticonManager.shared
        
        //从表情包分组名称 - 设置按钮
        for (i,p) in manager.packages.enumerate() {
            
            // 1 实例化按钮
            let btn = UIButton()
            
            // 2 设置按钮状态
            btn.setTitle(p.groupName, forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Highlighted)
            btn.setTitleColor(UIColor.darkGrayColor(), forState: .Selected)
            
        
            // 3 设置按钮图片
            let imageName = "common_emotion_table_\(p.bgImageName ?? "")_normal"
            let imageNameHL = "common_emotion_table_\(p.bgImageName ?? "")_selected"
            
            
            var image = UIImage(named: imageName, inBundle: manager.bundle, compatibleWithTraitCollection: nil)
            var imageHL = UIImage(named: imageNameHL, inBundle: manager.bundle, compatibleWithTraitCollection: nil)

            //拉伸图像
            let size = image?.size ?? CGSize()
            
            let inset = UIEdgeInsetsMake(size.height * 0.5, size.width * 0.5, size.height * 0.5, size.width * 0.5)
            image = image?.resizableImageWithCapInsets(inset)
            
            imageHL = imageHL?.resizableImageWithCapInsets(inset)
            
            btn.setBackgroundImage(image, forState: .Normal)
            btn.setBackgroundImage(imageHL, forState: .Selected)
            btn.setBackgroundImage(imageHL, forState: .Highlighted)
            
            btn.sizeToFit()
            // 4  添加按钮
            addSubview(btn)
            
            // 5 设置按钮的 tag
            btn.tag = i
            
            // 6 添加按钮的监听方法
            btn.addTarget(self, action: #selector(clickItem), forControlEvents: .TouchUpInside)
        }
        
        //默认选中第0个按钮
        (subviews[0] as! UIButton).selected = true
    }
}