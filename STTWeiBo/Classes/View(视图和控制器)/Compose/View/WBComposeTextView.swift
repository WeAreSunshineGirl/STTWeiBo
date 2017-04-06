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
    @objc private func textChange(){
        //如果有文本 不显示占位标签 否则 显示
        placeholderLabel.hidden = self.hasText()
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

//extension WBComposeTextView:UITextViewDelegate{
//    func textViewDidChange(textView: UITextView) {
//        print("哈哈")
//    }
//}

// MARK: - 表情键盘专属方法
extension WBComposeTextView{
    
    /**
     向文本视图插入表情符号【图文混排】
     
     - parameter em: 选中的表情符号 nil 表示删除
     */
    func insertEmoticon(em:STEmoticon?){
        
        // 1  em ==nil 是删除按钮
        guard let em = em else{
            
            //em 为nil 时 删除文本
            deleteBackward()
            
            return
        }
        // 2 emoji 是字符串
        if let emoji = em.emoji,textRange = selectedTextRange {
            
            //UITextRange 仅用在此处
            replaceRange(textRange, withText: emoji)
            return
        }
        
        //代码执行到此 都是图片表情
        
        //0 获取表情中的图像属性文本
        //所有的排版系统中 几乎都有一个共同的特点 插入字符的显示 跟随前一个字符的属性 但是本身没有 ‘属性’
        let imageText = em.imageText(font!)
        
        /*  写在 imageText(textView.font!)此方法中
         //        let imageText = NSMutableAttributedString(attributedString: em.imageText(textView.font!))
         //设置图像文字的属性
         //        imageText.addAttributes([NSFontAttributeName:textView.font!], range: NSRange(location: 0, length: 1))
         */
        
        // 1> 获取当前 textView的属性文本 =》 可变的
        let attrStrM = NSMutableAttributedString(attributedString: attributedText)
        // 2> 将图像的属性文本插入到当前的光标位置
        attrStrM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
        
        // 3>重新设置属性文本
        //  记录光标位置
        let range = selectedRange
        //设置文本
        attributedText = attrStrM
        
        //恢复光标位置 length是选中字符的长度 插入文本之后 应该为 0
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        //  4 让代理执行文本变化方法  在需要的时候 通知代理执行协议方法
        delegate?.textViewDidChange?(self)
        
        // 5 执行当前对象的文本变化方法
        textChange()
    }

}

private extension WBComposeTextView{
    
    func setupUI(){
        // 0 注册通知 
        //通知一对多 如果其他控件监听当前文本视图的通知 不会影响
        //但是如果使用代理 其他控件就无法使用代理监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textChange), name: UITextViewTextDidChangeNotification, object: self)
        
        // 1 设置占位标签
        placeholderLabel.text = "分享新鲜事..."
        placeholderLabel.font = self.font
        
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = UIColor.lightGrayColor()
        placeholderLabel.frame.origin = CGPoint(x: 5, y: 8)
        addSubview(placeholderLabel)
        
        //测试代理 自己当自己的代理
//        self.delegate = self
    }
}