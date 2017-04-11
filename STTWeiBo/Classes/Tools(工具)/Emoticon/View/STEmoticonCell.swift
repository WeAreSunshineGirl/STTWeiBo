//
//  STEmoticonCell.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/**
 *  表情 cell 的协议
 */
@objc protocol STEmoticonCellDelegate:NSObjectProtocol{
    
    /**
     表情 cell 选中表情模型
     
     - parameter em: 表情模型 /nil 表示删除
     */
    func emoticonCellDidSelectedEmoticon(cell:STEmoticonCell,em:STEmoticon?)
}


//表情的页面cell
//每一个cell 就是和 collectionView 一样大小
//每一个cell 中用九宫格的算法 自行添加 20个表情
//最后一个位置放置删除按钮
class STEmoticonCell: UICollectionViewCell {

    /// 代理
    weak var delegate:STEmoticonCellDelegate?
    
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
    
    
    private lazy var tipView:STEmoticonTipView = STEmoticonTipView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //当试图从界面上删除 同样会调用此方法 newWindow = nil
    override func willMoveToWindow(newWindow: UIWindow?) {
        
        super.willMoveToWindow(newWindow)
        
        guard let w = newWindow else{
            return
        }
        
        //将提示视图添加到窗口上
        //提示：iOS6.0之前 很多程序员都喜欢把控件往窗口添加
        //在现在开发 如果有地方 就不要用窗口
        w.addSubview(tipView)
        
        tipView.hidden = true
        
        
    }
    
    //MARK: -监听方法
    /**
     选中表情按钮
     
     - parameter button: 选中的按钮
     */
    @objc private func selectedEmoticonButton(button:UIButton){
        
        
        // 1 取 tag 0-20  20对应的是删除按钮
        let  tag = button.tag
        
        // 2 根据 tag 判断是否是删除按钮  如果不是删除按钮  取得表情
        var em:STEmoticon?
        if tag < emoticons?.count{
            
            em = emoticons?[tag]
        }
        
        // 3 em 要么是选中的模型 如果为 nil 对应的是删除按钮
//        print(em)
        // 通知代理工作
        delegate?.emoticonCellDidSelectedEmoticon(self, em: em)
        
    }
    
//    override func awakeFromNib() {//xib   没有用nib注册 不会调用
//
//        setupUI()
//    }

    /**
     长按手势识别
     可以保证一个对象监听两种点击手势 而且不需要考虑解决手势冲突
     - parameter gesture: <#gesture description#>
     */
    @objc private func longGesture(gesture:UILongPressGestureRecognizer){
        
        //测试添加提示视图
//        addSubview(tipView)
        
        // 1> 获取触摸的位置
        let location = gesture.locationInView(self)
        
        // 2> 获取触摸位置对应的按钮
        guard let button = buttonWithLocation(location) else{
            
            tipView.hidden = true
            
             return
        }
        
        // 3> 处理手势状态
    // 在处理手势细节的时候 不要视图一下把所有状态都处理完毕
        switch gesture.state {
        case .Began,.Changed:
            
            tipView.hidden = false
            
            //坐标系的转换- 将按钮参照 cell 的坐标系 转换到 window 的坐标位置
            let center = self.convertPoint(button.center, toView: window)
            
            //设置提示视图的位置
            tipView.center = center
            
            //设置提示视图的表情模型
            if button.tag < emoticons?.count {
                
                tipView.emoticon = emoticons?[button.tag]
            }
            
        case .Ended:
            tipView.hidden = true
            //执行选中按钮的函数
            selectedEmoticonButton(button)
            
        case .Cancelled ,.Failed:
            tipView.hidden = true
        default:
            break
        }
//        print(button)
        
    }
    
    private func buttonWithLocation(location:CGPoint)->UIButton?{
        
        //遍历 contentView 所有子视图 如果可见 同时在 location 确认是按钮
        for btn in contentView.subviews as! [UIButton] {
            
            //删除按钮同样需要处理
            if btn.frame.contains(location) && !btn.hidden && btn != contentView.subviews.last {
                return btn
            }
        }
        return nil
    }
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
            
            //设置按钮的tag
            btn.tag = i
            //添加监听方法
            btn.addTarget(self, action: #selector(selectedEmoticonButton), forControlEvents: .TouchUpInside)
        }
        
        //取出 末尾的 删除按钮
        let removeButton = contentView.subviews.last as! UIButton
        
        //设置图像
        let imageHL = UIImage(named: "compose_emotion_delete_highlighted", inBundle: STEmoticonManager.shared.bundle, compatibleWithTraitCollection: nil)
          let image = UIImage(named: "compose_emotion_delete", inBundle: STEmoticonManager.shared.bundle, compatibleWithTraitCollection: nil)
        
        removeButton.setImage(image, forState: .Normal)
        removeButton.setImage(imageHL, forState: .Highlighted)
        
        //添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        
        longPress.minimumPressDuration = 0.1
        addGestureRecognizer(longPress)
        
        
    }
}