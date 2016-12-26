//
//  WBStatusViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation



/// 单条微博的视图模型  没有继承 NSObject  所以敲不出 description  让它遵守一个协议就行了
/*
 如果没有任何父类 如果希望在开发时调试 输出调试信息 需要
 1. 遵守 CustomStringConvertible 
 2. 实现 description 计算型属性
 
 关于表格的性能优化
 - 尽量少计算 所有需要的素材 提前计算好
 - 控件上不要设置圆角半径 所有图像渲染的属性 都要注意
 - 不要动态创建 所有需要的控件都要提前创建好 在显示的时候 根据数据隐藏/显示
 - cell 中控件的层次越少越好 ，数量越少越好
 - 要测量 不要猜测
 */
class WBStatusViewModel:CustomStringConvertible {
    
    /// 微博模型  - 没有设可选项 在构造函数中 设置初始值
    var status:WBStatus
    
    /// 会员图标 - 存储型属性（用内存 换 CPU）
    var memberIcon:UIImage?
    /// 认证类型 -1:没有认证 0 认证用户 2 3 5 企业认证 220 达人
    var vipIcon:UIImage?
    /// 转发文字
    var retweetedStr:String?
    /// 评论文字
    var commentStr:String?
    /// 点赞文字
    var likeStr:String?
    /// 配图视图大小
    var pictureViewSize = CGSize()
    /**
     构造函数
     
     - parameter model: 微博模型
     
     - returns: 微博的视图模型
     */
    init(model:WBStatus){
        self.status = model
        
        //直接计算出会员等级 0 -6 common_icon_membership_level1
        if model.user?.mbrank > 0 && model.user?.mbrank < 7{
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        //认证图标
        switch model.user?.verified_type ?? -1 {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }

        //设置底部计算字符串
        //测试 转发数
//        model.reposts_count = Int(arc4random_uniform(100000))
        retweetedStr = countString(model.reposts_count, defaultStr: "转发")
        commentStr = countString(model.comments_count, defaultStr: "评论")
        likeStr = countString(model.attitudes_count, defaultStr: "赞")
        
        // 计算配图视图的大小
        pictureViewSize = calcPictureViewSize(status.pic_urls?.count )
    }
    
    var description: String{
        return status.description
    }
    
    /**
     计算指定数量的图片对应的配图视图的大小
     
     - parameter count: 配图数量
     
     - returns: 配图视图的大小
     */
    private func calcPictureViewSize(count:Int?)->CGSize{
        if count == 0{
            return CGSize()
        }
        
        // 1 计算配图视图的宽度
        // 常数准备
        /// 配图视图外侧的间距
        let WBStatusPictureViewOutterMargin = CGFloat(12)
        /// 配图视图内部图像视图的间距
        let WBStatusPictureViewInnerMargin = CGFloat(3)
        /// 视图的宽度
        let WBStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * WBStatusPictureViewOutterMargin
        /// 每个 Item 默认的宽度
        let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - 2 * WBStatusPictureViewInnerMargin) / 3
        
        // 2 计算高度
        // 1> 根据count 知道 行数 1 - 9
        /*
         1 2 3 = 0 1 2 / 3 = 0 + 1 = 1
         4 5 6 = 3 4 5 / 3 = 1 + 1 = 2
         7 8 9 = 6 7 8 / 3 = 2 + 1 = 3
         */
        let row = (count! - 1) / 3 + 1
        
        // 2> 根据行数算高度
        let height = WBStatusPictureViewOutterMargin
            + CGFloat(row) * WBStatusPictureItemWidth
            + CGFloat(row - 1) * WBStatusPictureViewInnerMargin
        
        return CGSize(width: WBStatusPictureViewWidth, height: height)
    }
    
    /**
     
     - returns: 描述结果
     */
    /**
     给定一个数字返回对应的描述结果
     
     - parameter count:      数字
     - parameter defaultStr: 默认字符串 转发 评论 赞
     
     - returns: 描述结果
     */
    /*
     如果数量 == 0 显示默认标题
     如果数量超过 10000 显示 x.xx万
     如果数量 < 10000 显示实际数字
     */
    private func countString(count:Int,defaultStr:String)->String{
        
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万", Double(count) / 10000)
        
    }
   
    
}