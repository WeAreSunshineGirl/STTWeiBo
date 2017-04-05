//
//  STEmoticonCell.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

//表情的页面cell
//每一个cell 就是和 collectionView 一样大小
//每一个cell 中用九宫格的算法 自行添加 20个表情
//最后一个位置放置删除按钮
class STEmoticonCell: UICollectionViewCell {

    /// 当前页面的表情模型数组 ‘最多’ 20 个
    var emoticons:[STEmoticon]?{
        
        didSet{
            
//            print("表情包的数量\(emoticons?.count)")
            // 1 隐藏所有的按钮
            for v in contentView.subviews {
                v.hidden = true
            }
            //显示删除按钮
            contentView.subviews.last?.hidden = false
            
            // 2 遍历表情模型数组 设置按钮图像
            for (i,em) in (emoticons ?? []).enumerate() {
                
                // 1 取出按钮
                if let btn = contentView.subviews[i] as? UIButton{
                    
                    //设置图像 - 如果图像为nil 会清空图像 避免复用
                    btn.setImage(em.image, forState: .Normal)
                    
                    //设置emoji 的字符串 - 如果 emoji为 nil 会清空title 避免复用
                    btn.setTitle(em.emoji, forState: .Normal)
                    
                    btn.hidden = false
                }
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func awakeFromNib() {//xib   没有用nib注册 不会调用
//
//        setupUI()
//    }

}

// MARK: - 设置界面
private extension STEmoticonCell{
    
    //- 从 XIB 加载 bounds 是XIB 中定义的大小，不是size的大小
    // - 从纯代码创建 bounds是 就是布局属性中设置的itemSize
    func setupUI(){
        
        let rowCount = 3
        let colCount = 7
        
        //左右间距
        let leftMargin:CGFloat = 8
        //底部间距为分页控件预留控件
        let bottomMargin:CGFloat = 16
        
        
        let w = (bounds.width - 2 * leftMargin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        // 连续创建21个按钮
        for i in 0..<21 {
            let row = i / colCount// i 0 1 2 3 4 ..  row 0 0 0 0 0
            let col = i % colCount //i 0 1 2 3 4 ..  col 0 1 2 3 4 5
            
            let btn = UIButton()
            
            //设置按钮的大小
            let x = leftMargin + CGFloat(col) * w
            let y = CGFloat(row) * h
            
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            
//            btn.backgroundColor = UIColor.redColor()
            
            contentView.addSubview(btn)
            
            // 设置按钮的字体大小  lineHeight 基本上和图片的大小差不多
            btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        }
        
        //取出 末尾的 删除按钮
        let removeButton = contentView.subviews.last as! UIButton
        //设置图像
        let imageHL = UIImage(named: "compose_emotion_delete_highlighted", inBundle: STEmoticonManager.shared.bundle, compatibleWithTraitCollection: nil)
          let image = UIImage(named: "compose_emotion_delete", inBundle: STEmoticonManager.shared.bundle, compatibleWithTraitCollection: nil)
        removeButton.setImage(image, forState: .Normal)
        removeButton.setImage(imageHL, forState: .Highlighted)
        
    }
}