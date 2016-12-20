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
    func avatarImage(size:CGSize?,backColor:UIColor = UIColor.whiteColor(),lineColor:UIColor = UIColor.lightGrayColor()) -> UIImage? {
        
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalInRect: rect)
        path.addClip()
        
        drawInRect(rect)
        
        let ovalPath = UIBezierPath(ovalInRect: rect)
        ovalPath.lineWidth = 2
        lineColor.setStroke()
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
}