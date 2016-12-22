//
//  WBStatusToolBar.swift
//  STTWeiBo
//
//  Created by user on 16/12/22.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {

    var viewModel:WBStatusViewModel?{
        didSet{
//            retweetedButton.setTitle("\(viewModel?.status.reposts_count)", forState: .Normal)
//            commentButton.setTitle("\(viewModel?.status.comments_count)", forState: .Normal)
//            likeButton.setTitle("\(viewModel?.status.attitudes_count)", forState: .Normal)
            retweetedButton.setTitle(viewModel?.retweetedStr, forState: .Normal)
            commentButton.setTitle(viewModel?.commentStr, forState: .Normal)
            likeButton.setTitle(viewModel?.likeStr, forState: .Normal)
        }
    }
    /// 转发
    @IBOutlet weak var retweetedButton: UIButton!
    /// 评论
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞
    @IBOutlet weak var likeButton: UIButton!

}
