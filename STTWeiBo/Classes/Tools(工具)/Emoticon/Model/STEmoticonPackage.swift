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
        }
            
    }
    
    ///懒加载的表情模型的空数组
    /// 使用懒加载可以避免后续的解包
    lazy var emoticons = [STEmoticon]()
    
    override var description: String{
        return yy_modelDescription()
    }
}
