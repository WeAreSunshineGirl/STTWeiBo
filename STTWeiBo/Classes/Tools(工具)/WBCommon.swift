
//
//  WBCommon.swift
//  STTWeiBo
//
//  Created by user on 16/12/13.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

//MARK: 全局定义通知

/// 用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
/// 用户登录成功通知
let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"



//MARK:照片浏览通知定义
/*
 selectedIndex 选中照片索引
 urls 照片浏览 url 字符串数组
 parentImageVIews 父视图的图像视图数组 用户展现和解除专场动画参照
 
 */
//微博cel浏览照片通知
let WBStatusCellBrowserPhotoNotification = "WBStatusCellBrowserPhotoNotification"

//选中索引 Key
let WBStatusCellBrowserPhotoSelectedIndexKey = "WBStatusCellBrowserPhotoSelectedIndexKey"
// 照片浏览 URL 字符串KEy
let WBStatusCellBrowserPhotoURLsKey = "WBStatusCellBrowserPhotoURLsKey"
//父视图的图像数组
let WBStatusCellBrowserPhotoImageViews = "WBStatusCellBrowserPhotoImageViews"











//MARK: 应用程序信息

/// 应用程序 ID
//let WBAppKey = "3475817001"
///// 应用程序加密信息（开发者可以申请修改）
//let WBAppSecret = "51d356a35b5365283ea462952c2ef600"
let WBAppKey = "3912003191"
/// 应用程序加密信息（开发者可以申请修改）
let WBAppSecret = "3ca948a255cad520a56b876526c7f72d"
/// 回调地址- 登录完成 跳转的 URL 参数以 GET 形式拼接
let WBRedirectURI = "http://www.baidu.com"


// MARK: - 微博配图视图常量

/// 配图视图外侧的间距
let WBStatusPictureViewOutterMargin = CGFloat(12)
/// 配图视图内部图像视图的间距
let WBStatusPictureViewInnerMargin = CGFloat(3)
/// 视图的宽度
let WBStatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * WBStatusPictureViewOutterMargin
/// 每个 Item 默认的宽度
let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - 2 * WBStatusPictureViewInnerMargin) / 3