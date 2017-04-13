//
//  UIImage+Extensions.swift
//  STTWeiBo
//
//  Created by user on 16/12/20.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation


extension UIImage{
    
    /**
     创建头像图像
     
     - parameter size:      尺寸
     - parameter backColor: 背景颜色
     - parameter lineColor: 线的颜色
     
     - returns: 裁切后的图像
     */
    //    不设置圆角半径 的情况下 直接设置圆形
    func cz_avatarImage(size:CGSize?,backColor:UIColor = UIColor.whiteColor(),lineColor:UIColor = UIColor.lightGrayColor()) -> UIImage? {
        
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        //        图像上下文 内存中开辟一个地址 跟屏幕无关
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        //        背景填充
        backColor.setFill()
        UIRectFill(rect)
        //        实例化一个圆形的路径
        let path = UIBezierPath(ovalInRect: rect)
        //        进行路径裁切  后续的绘制 都会出现在圆形路径内部 外部的全部干净
        path.addClip()
        //        绘图 drawInrect 就是在指定区域内拉伸屏幕
        drawInRect(rect)
        //        画圆形  画圆形的边线
        let ovalPath = UIBezierPath(ovalInRect: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        ovalPath.stroke()
              //        取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        //        关闭上下文
        UIGraphicsEndImageContext()
          //        返回结果
        return result
    }
    
    //    生成指定大小的不透明图象
    func cz_image(size:CGSize? = nil,backColor:UIColor = UIColor.whiteColor()) -> UIImage? {
        var size = size
        if size == nil{
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        //        获取图像上下文
        /*
         size 绘制的尺寸
         不透明： false（透明） true（不透明）
         scale 屏幕分辨率 默认生成的图像默认使用1.0分辨率 图像质量不好
         可以指定 0 会选择当前的设备的屏幕分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        //        绘制 drawinRect 就是在指定区域内拉伸屏幕
        drawInRect(rect)
        //        取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        //        关闭上下文
        UIGraphicsEndImageContext()
        //        返回结果
        return result
        
    }
    
    
    /// 将图像缩放到指定`宽度`
    ///
    /// - parameter width: 目标宽度
    ///
    /// - returns: 如果给定的图片宽度小于指定宽度，直接返回
    func scaleToWith(width: CGFloat) -> UIImage {
        
        // 1. 判断宽度
        if width > size.width {
            return self
        }
        
        // 2. 计算比例
        let height = size.height * width / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3. 使用核心绘图绘制新的图像
        // 1> 开启上下文
        UIGraphicsBeginImageContext(rect.size)
        
        // 2> 绘图 - 在指定区域拉伸绘制
        self.drawInRect(rect)
        
        // 3> 取结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4> 关闭上下文
        UIGraphicsEndImageContext()
        
        // 5> 返回结果
        return result
    }

}