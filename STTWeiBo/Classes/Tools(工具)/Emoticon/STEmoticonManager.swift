//
//  STEmoticonManager.swift
//  表情包数据
//
//  Created by user on 17/1/16.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation
import UIKit
//表情管理器
class STEmoticonManager {
    
    // 为了便于表情的复用 建立一个单例 只加载一次表情数据
    /// 表情管理器的单例
    static let shared = STEmoticonManager()
    
    /// 表情包的懒加载数组   - 第一个数组是最近表情 加载之后 表情数组为空
    lazy var packages = [STEmoticonPackage]()
    
    /// 表情素材的 bundle
    lazy var bundle:NSBundle = {
        
        let path = NSBundle.mainBundle().pathForResource("EmotionIcons.bundle", ofType: nil)
        
        let  bundle = NSBundle(path: path!)
        
        return bundle!
    }()
    
    //构造函数 如果在init之前增加 private 修饰符 可以要求调用者必须通过 shared 访问对象
    //OC 要重写 allocWithZone方法 把单例锁住
    private init(){
        loadPackages()
    }
    
    
    func recentEmoticon(em:STEmoticon){
        
        // 1 增加表情的使用次数
        em.times += 1
        
        // 2 判断是否已经记录该表情 如果没有记录 添加该表情
        if !packages[0].emoticons.contains(em) {
            
            packages[0].emoticons.append(em)
        }
        
        // 3 根据使用次数排序 使用次数高的排序靠前
//        packages[0].emoticons.sortInPlace { (em1, em2) -> Bool in
//            
//            return em1.times > em2.times
//        }
        //在swift中 如果闭包中只有一个 return 参数可以省略 参数名用 $0....替代
        packages[0].emoticons.sortInPlace { $0.times > $1.times}
        
        // 4 判断表情数组是否超出 20 如果超出 删除末尾的表情
        if packages[0].emoticons.count > 20 {
            
             packages[0].emoticons.removeRange(20..<packages[0].emoticons.count)
        }
       
    }
}

//MARK: - 表情字符串的处理
extension STEmoticonManager{
    /**
     将给定的字符串转换成属性文本
     // 关键点 要按匹配结果倒序替换属性文本
     - parameter string: 完整的字符串
     
     - returns: 属性文本
     */
    func emoticonString(string:String,font:UIFont) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: string)
        
        // 1 建立正则表达式 过滤所有的表情文字
        // [] () 都是正则表达式的关键字 如果要参与匹配 需要转义
        let pattern = "\\[.*?\\]"
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else{
            return attrString
        }
        // 2 匹配所有项
        let matches =  regx.matchesInString(string, options: [], range: NSRange(location: 0, length: attrString.length))
        //        print(matches)
        // 3 遍历所有匹配结果
        for m in matches.reverse() {
            let r = m.rangeAtIndex(0)
//            print("匹配结果的range\(r)")
            let subStr = (attrString.string as NSString).substringWithRange(r)
            
            // 1> 使用 subStr 查找对应的表情符号
            if let em = STEmoticonManager.shared.findEmoticon(subStr){
                
                // 2> 使用表情符号中的属性文本 替换原有的属性文本内容
                attrString.replaceCharactersInRange(r, withAttributedString: em.imageText(font))
            }
        }
        //很重要 如果米有设置字符串属性 排版就是错乱
        // 4 统一设置一遍字符串的属性  除了需要设置‘字体’ 还需要设置 ‘颜色’
        attrString.addAttributes([NSFontAttributeName:font,NSForegroundColorAttributeName:UIColor.darkGrayColor()], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    

    /**
     根据 string [爱你] 在所有的表情符号中查找对应的模型对象
     
     - parameter string: 表情字符串
     
     - returns: 如果找到 返回表情模型   否则 返回 nil
     */
    func findEmoticon(string:String?) -> STEmoticon? {
        
        //1 遍历表情包
        for p in packages {
            
            // 2 在表情数组中过滤 string
            
            //方法一
//            let result = p.emoticons.filter({ (em) -> Bool in
//                return em.chs == string
//            })
            //方法二 尾随闭包
//            let result = p.emoticons.filter(){ (em) -> Bool in
//                return em.chs == string
//            }
            //方法三 如果闭包中只有一句 并且是返回
//            // 1> 闭包格式定义可以省略
//            // 2> 参数省略之后 使用$0,$1...依次代替原有的参数
//            let result = p.emoticons.filter(){
//                return $0.chs == string
//            }
            //方法四 如果闭包中只有一句 并且是返回
            // 1> 闭包格式定义可以省略
            // 2> 参数省略之后 使用$0,$1...依次代替原有的参数
            // 3> return 也可以省略
            let result = p.emoticons.filter(){ $0.chs == string }
            
            
            // 3判断结果数组的数量
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
    }
}

// MARK: - 表情包数据处理
private extension STEmoticonManager{
    
    func loadPackages(){
        
        //读取emoticons.plist
        // 只要按照 NSBundle 默认的目录结构设定 就可以直接读取Resources 目录下的文件
        guard let path = NSBundle.mainBundle().pathForResource("EmotionIcons.bundle", ofType: nil), bundle = NSBundle(path: path), plistPath = bundle.pathForResource("emoticons.plist", ofType: nil),array = NSArray(contentsOfFile: plistPath) as? [[String:String]],models = NSArray.yy_modelArrayWithClass(STEmoticonPackage.self, json: array) as? [STEmoticonPackage]
        else{
            return
        }
        //设置表情包数据
        //使用 += 不需要再次给packages 分配空间 直接追加数据
        packages += models
        
    }
}