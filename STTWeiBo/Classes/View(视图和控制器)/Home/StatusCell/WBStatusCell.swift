//
//  WBStatusCell.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import SDWebImage

class WBStatusCell: UITableViewCell {

    /// 微博视图模型
    var viewModel:WBStatusViewModel?{
        didSet{
            /// 微博文本
            statusLabel?.text = viewModel?.status.text
            
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
            
            //  测试修改配图视图的高度
            pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
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
            pictureView.urls = viewModel?.picURLs
            
            /// 设置被转发微博的文字
            retweetedLabel?.text = viewModel?.retweetedText

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
    @IBOutlet weak var statusLabel: UILabel!
    /// 底部工具栏
    @IBOutlet weak var toolBar: WBStatusToolBar!
    /// 配图视图
    @IBOutlet weak var pictureView: WBStatusPictureView!
    /// 被转发微博的标签 - 原创微博没有此控件 一定要用？
    @IBOutlet weak var retweetedLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
