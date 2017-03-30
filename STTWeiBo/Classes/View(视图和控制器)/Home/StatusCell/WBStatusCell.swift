//
//  WBStatusCell.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import SDWebImage

/**
 *  微博 Cell的协议
如果需要设置可选协议方法 
 需要遵守NSObjectProtocol
 协议需要是 @objc的
 方法需要 @objc optional
 */
@objc protocol WBStatusCellDelegate:NSObjectProtocol {
  
    /**
     微博 Cell 选中 URL 字符串
     */
  @objc optional func statusCellDidTapUrlString(cell:WBStatusCell,urlString:String)
}

/// 微博Cell
class WBStatusCell: UITableViewCell {

    /// 代理属性
    weak var delegate:WBStatusCellDelegate?
    
    /// 微博视图模型
    var viewModel:WBStatusViewModel?{
        didSet{
            /// 微博文本
//            statusLabel?.text = viewModel?.status.text
            statusLabel?.attributedText = viewModel?.statusAttrText
            /// 设置被转发微博的文字
            //            retweetedLabel?.text = viewModel?.retweetedText
            retweetedLabel?.attributedText = viewModel?.retweetedAttrText

            
            /// 姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            
            //会员 图标
            //判断 mbrank的值 根据值设置属性
            memberIconView.image = viewModel?.memberIcon
            
            //认证图标
            vipIconView.image = viewModel?.vipIcon
            
            //用户头像
            iconView.cz_setImage(viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"),isAvatar: true)
            
            /// 底部工具栏
            toolBar.viewModel = viewModel
            
            
            //配图视图模型
            pictureView.viewModel = viewModel
            
            //  测试修改配图视图的高度
            //pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
            // 设置配图视图的 URL 数据
//            // 测试 4 张图像
//            if viewModel?.status.pic_urls?.count > 4 {
//                //修改数组 -》 将末尾的数据全部删除
//                var picURLs = viewModel!.status.pic_urls!
//                picURLs.removeRange((picURLs.startIndex + 4)..<picURLs.endIndex)
//                pictureView.urls = picURLs
//            }else{
//            pictureView.urls = viewModel?.status.pic_urls
//            }
            
//            pictureView.urls = viewModel?.status.pic_urls
            
            /// 设置配图 （被转发 和 原创）
//            pictureView.urls = viewModel?.picURLs //在WBStatusPictureView中替代
            
           
            /// 微博来源
//            print("微博来源 \(viewModel?.status.source)")
//            sourceLabel.text = viewModel?.sourceStr
            sourceLabel.text = viewModel?.status.source
            
        }
        
    }
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 姓名
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员图标
    @IBOutlet weak var memberIconView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
   /// 来源
    @IBOutlet weak var sourceLabel: UILabel!
       /// 认证图标
    @IBOutlet weak var vipIconView: UIImageView!
    /// 微博正文
    @IBOutlet weak var statusLabel: FFLabel!
    /// 底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    /// 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    /// 被转发微博的标签 - 原创微博没有此控件 一定要用？
    @IBOutlet weak var retweetedLabel: FFLabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 离屏渲染 - 异步绘制  在进入屏幕前绘制好表格 cell 进入之后 直接显示  离屏渲染需要在GPU/CPU之间快速切块    耗电厉害
        self.layer.drawsAsynchronously = true

        //栅格化  - 异步绘制之后 会生成一张独立的图像 cell 在屏幕上滚动的时候 本质上滚动的是这种图片
        // cell 优化 要尽量减少图层的数量 相当于就只有一层
        // 停止滚动之后 可以接收监听
        self.layer.shouldRasterize = true
        
        //使用 栅格化 必须注意指定分辨率
        
        //        删格化我知道，只不过，删格化的并不能从根本上解决问题，他只不过是把圆角控件化成了一个bitmap，缓存到内存中，下次直接从内存中取出来用。但切圆角在一屏幕超过25个的时候，使用删格化第一次加载也是很卡的。而且内存中没有的，也还是要从新生成一个。
        self.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        //设置微博文本代理
        statusLabel.delegate = self
        retweetedLabel?.delegate = self
     
    }
}
extension WBStatusCell:FFLabelDelegate{
    
    //MAR: - 点击cell 中的 url 实现 FFLabelDelegate 代理方法
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        
        //判断是否是 URL
        if !text.hasPrefix("http://") {
            return
        }
        //插入 ？ 表示如果代理没有实现协议方法 就什么都不做
        //如果使用 ！ 代理没有实现协议方法 仍然强制执行 会崩溃
        delegate?.statusCellDidTapUrlString?(self, urlString: text)
    }
    
}
