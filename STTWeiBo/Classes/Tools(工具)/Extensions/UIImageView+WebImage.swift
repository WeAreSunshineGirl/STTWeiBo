//
//  UIImageView+WebImage.swift
//  STTWeiBo
//
//  Created by user on 16/12/22.
//  Copyright © 2016年 user. All rights reserved.
//

import SDWebImage

extension UIImageView{
    /**
     隔离 SDWEBImage 设置图像函数
     
     - parameter UrlString:        UrlString
     - parameter placeholderImage: 占位图像
     */
    func cz_setImage(UrlString:String?,placeholderImage:UIImage?){
        
        //处理url
        guard let UrlString = UrlString, url = NSURL(string: UrlString)else{
            
            //设置占位图像
            image = placeholderImage
            return
        }
        //可选项只是用在swift OC 有时候使用 ！同样可以传入nil
        sd_setImageWithURL(url, placeholderImage: placeholderImage, options: [], progress: nil) { (image, _, _, _) in
            
        }
    }
}