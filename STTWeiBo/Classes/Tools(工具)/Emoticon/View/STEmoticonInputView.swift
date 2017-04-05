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
    //加载并且返回输入视图
    class func inputView()->STEmoticonInputView{
        
        let nib = UINib(nibName: "STEmoticonInputView", bundle: nil)
        let v = nib.instantiateWithOwner(nil, options: nil)[0] as! STEmoticonInputView
        
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
        
        // 3 返回
        return cell
    }
}