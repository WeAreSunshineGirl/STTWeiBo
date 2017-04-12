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

    //工具栏
    @IBOutlet weak var toolbar: STEmoticonToolbar!
    
    //分页控件
    @IBOutlet weak var pageControl: UIPageControl!
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
        
        //设置工具栏代理
        toolbar.delegate = self
        
        
        //2> 设置分页控件的图片
        let bundle = STEmoticonManager.shared.bundle
        
        guard let normalImage = UIImage(named: "compose_keyboard_dot_normal", inBundle: bundle, compatibleWithTraitCollection: nil),selectedImage = UIImage(named: "compose_keyboard_dot_selected", inBundle: bundle, compatibleWithTraitCollection: nil)else{
            return
        }
        //使用填充图片设置颜色
        //控制台  po UIPageControl.cz_ivarsList()
        //        pageControl.pageIndicatorTintColor = UIColor(patternImage: normalImage)
        //        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: selectedImage)
        //使用 KVC 设置私有成员属性
        pageControl .setValue(normalImage, forKey: "_pageImage")
        pageControl .setValue(selectedImage, forKey: "_currentPageImage")
    }
}


extension STEmoticonInputView:STEmoticonToolbarDelegate{
    func emoticonToolbarDidSelectedItemIndex(toolbar: STEmoticonToolbar, index: Int) {
        
        // 让collectionView 发生滚动 -》每一个分组的第0页
        
        let indexPath = NSIndexPath(forItem: 0, inSection: index)
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
        
        //设置分组按钮的选中状态
        toolbar.selectedIndex = index
    }
}

// MARK: - UICollectionViewDelegate
extension STEmoticonInputView:UICollectionViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 1 获取中心点
        var center = scrollView.center
        center.x += scrollView.contentOffset.x
        
        // 2 获取当前显示的 cell 的indexPath
        let paths = collectionView.indexPathsForVisibleItems()
        
        // 3 判断中心点在哪一个 indexPath 上 在哪一个页面上
        var targetIndexPath:NSIndexPath?
        for indexPath in paths {
            
            //1>根据indexPath 获得cell
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
            
            //2>判断中心点位置
            if cell?.frame.contains(center) == true {
                
                targetIndexPath = indexPath
                break
            }
        
        }
        
       guard let target = targetIndexPath else {
            return
        }
        
        //4 判断是否找到 目标的 indexpath
        //indexpath.section =》对应的就是分组
        toolbar.selectedIndex = target.section
        
        // 5 设置分页控件
        // 1> 总页数 不同的分组 页数不一样
        pageControl.numberOfPages = collectionView.numberOfItemsInSection(target.section)
        pageControl.currentPage = target.item
        
//        compose_keyboard_dot_normal@2x
        
      
        
    }
}



// MARK: - UICollectionViewDataSource
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
        
        //如果当前collectionView 就是最近的分组 不添加最近使用的表情
        let indexPath = collectionView.indexPathsForVisibleItems()[0]
        if indexPath.section == 0 {
            return
        }
        
        
        STEmoticonManager.shared.recentEmoticon(em)
        
        //刷新数据 - 第0组
        let indexSet = NSMutableIndexSet()
        indexSet.addIndex(0)
       
        collectionView.reloadSections(indexSet)
    }
}