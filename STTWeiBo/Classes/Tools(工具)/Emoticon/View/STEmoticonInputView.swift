//
//  STEmoticonInputView.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 可重用标识符
private let cellId = "cellId"

//表情输入视图
class STEmoticonInputView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var toolbar: UIView!
    
    //选中表情回调闭包属性  成员变量
    private var selectedEmoticonCallBack:((emoticon:STEmoticon?)->())?
    
    //加载并且返回输入视图   类方法
    class func inputView(selectedEmoticon:(emoticon:STEmoticon?)->())->STEmoticonInputView{
        
        let nib = UINib(nibName: "STEmoticonInputView", bundle: nil)
        let v = nib.instantiateWithOwner(nil, options: nil)[0] as! STEmoticonInputView
        
        //记录闭包
        v.selectedEmoticonCallBack = selectedEmoticon
        
        return v
    }
    
    override func awakeFromNib() {
        collectionView.backgroundColor = UIColor.whiteColor()
        
        //注册可重用cell
        collectionView.registerClass(STEmoticonCell.self, forCellWithReuseIdentifier: cellId)
//        collectionView.registerNib(UINib(nibName: "STEmoticonCell",bundle: nil), forCellWithReuseIdentifier: cellId)
    }
}


extension STEmoticonInputView:UICollectionViewDataSource{
    
    //分组数量 - 返回表情包的数量
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return STEmoticonManager.shared.packages.count
    }
    
    //返回每个分组中的表情 页 的数量
    //每个分组的表情包中 表情页面的数量 emoticons 数组/20
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return STEmoticonManager.shared.packages[section].numberOfPages
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // 1 取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! STEmoticonCell
        
        // 2 设置 cell - 传递对应页面的表情数组
        cell.emoticons = STEmoticonManager.shared.packages[indexPath.section].emoticon(indexPath.item)
        
        
        // 设置代理- cell 不适合用闭包
        cell.delegate = self
        
        // 3 返回
        return cell
    }
}
// MARK: - STEmoticonCellDelegate
extension STEmoticonInputView:STEmoticonCellDelegate{
    
    /**
     选中的表情回调
     
     - parameter cell: 分页cell
     - parameter em:   选中的表情 删除键为 nil
     */
    func emoticonCellDidSelectedEmoticon(cell: STEmoticonCell, em: STEmoticon?) {
//        print(em)
        
        //执行闭包 回调选中的表情
        selectedEmoticonCallBack?(emoticon: em)
        
        //添加最近使用的表情
        guard let em = em else{
            return
        }
        
        STEmoticonManager.shared.recentEmoticon(em)
    }
}