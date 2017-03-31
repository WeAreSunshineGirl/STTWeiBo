//
//  WBComposeTextView.swift
//  STTWeiBo
//
//  Created by user on 17/3/31.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 撰写微博的文本视图
class WBComposeTextView: UITextView {

  // 占位标签
    private lazy var placeholderLabel = UILabel()
    
    override func awakeFromNib() {
        
        setupUI()
    }
    
    //MARK: - 监听方法
    @objc private func textChange(n:NSNotification){
        print(n)
        //如果有文本 不显示占位标签 否则 显示
        placeholderLabel.hidden = self.hasText()
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


private extension WBComposeTextView{
    
    func setupUI(){
        // 0 注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textChange), name: UITextViewTextDidChangeNotification, object: self)
        
        // 1 设置占位标签
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = UIColor.lightGrayColor()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        addSubview(placeholderLabel)
    }
}