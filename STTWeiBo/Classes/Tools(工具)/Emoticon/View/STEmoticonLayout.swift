//
//  STEmoticonLayout.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 表情集合视图的布局
class STEmoticonLayout: UICollectionViewFlowLayout {


    override func prepareLayout() {
        
        super.prepareLayout()
        //在此方法中 collectionView的大小已经确定
        guard let collectionView = collectionView else{
            return
        }
        
        itemSize = collectionView.bounds.size
        //在xib中设置了 所以代码就注释了
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
        
        //设定滚动方向
        //水平方向滚动 cell是 垂直方向布局
        //垂直风向滚动 cell是 水平方向布局
        scrollDirection = .Horizontal
        
    }
}
