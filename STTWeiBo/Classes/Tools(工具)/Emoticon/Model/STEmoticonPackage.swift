//
//  STEmoticonPackage.swift
//  表情包数据
//
//  Created by user on 17/1/17.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 表情包模型
class STEmoticonPackage: NSObject {

    /// 表情包的分组名
    var groupName:String?
    
    /// 背景图片名称
    var bgImageName:String?
    
    /// 表情包目录 从目录下加载 info.plst 可以创建表情模型数组
    var directory:String?{
        didSet{
            //当设置目录时 从目录下加载 info.plist
            guard let directory = directory,path = NSBundle.mainBundle().pathForResource("EmotionIcons.bundle", ofType: nil) ,bundle = NSBundle(path: path),infoPath = bundle.pathForResource("info.plist", ofType: nil, inDirectory: directory),array = NSArray(contentsOfFile: infoPath) as? [[String:String]],models = NSArray.yy_modelArrayWithClass(STEmoticon.self, json: array) as? [STEmoticon]else{
                return
            }
            
            //遍历 models 数组 设置每一个表情符号的目录
            for m in models {
                m.directory = directory
            }
            
            //设置表情模型数组
            emoticons += models
//            print(models)
//            print("------- \(emoticons)")
//            print("111111 \(emoticons.count)")
        }
        
    }
    
    /// 表情页面的数量
    var numberOfPages :Int{
        return (emoticons.count-1) / 20 + 1
    }
    
  
    ///懒加载的表情模型的空数组
    /// 使用懒加载可以避免后续的解包
    lazy var emoticons = [STEmoticon]()
    
    /**
     从懒加载的表情包中 按照 page 截取最多 20 个表情模型的数组
     - parameter page: 页数
     - returns: 返回的表情模型数组
     例如 有 26个表情
     page= 0  返回0-19个模型
     page=1   返回20-25个模型
     */
    func emoticon(page:Int)->[STEmoticon]{
        
        //每页的数量
        let count = 20
        let location = page * count
        var length = count
        
        //判断数组是否越界
        if location + length > emoticons.count {
            
            length = emoticons.count - location
        }
        
        let range = NSRange(location: location,length: length)
        //截取数组的子数组
        let subArray = (emoticons as NSArray).subarrayWithRange(range)
        
        return subArray as! [STEmoticon]
    }
    
    
    override var description: String{
        return yy_modelDescription()
    }
}
