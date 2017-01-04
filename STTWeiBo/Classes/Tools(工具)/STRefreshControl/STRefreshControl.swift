//
//  STRefreshControl.swift
//  STTWeiBo
//
//  Created by user on 17/1/3.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 刷新状态切换的临界点
private let  STRefreshOffset:CGFloat = 60

//刷新控件 - 负责刷新相关的 ’逻辑‘ 处理
class STRefreshControl: UIControl {

    //MARK:-属性
    /// 滚动视图的父视图 下拉刷新应该适用于 UITableView /UICollectionView  所以是父视图UIScrollView
    private weak var scrollView:UIScrollView?
    
    /// 刷新视图
    private lazy var refreshView:STRefreshView = STRefreshView.refreshView()
    
    //MARK:-构造函数
    init(){
        super.init(frame: CGRect())
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) { //xib开发要用
        
        super.init(coder: aDecoder)

        setupUI()
    }
    
    /*
     willMove addSubview 方法会调用
     - 当添加到父视图的时候 newSuperview 是父视图
     - 当父视图被移除，newSuperview 是 nil
     */
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
        //判断父视图对的类型
        guard let sv = newSuperview as? UIScrollView else{
            return
        }
        
        //记录父视图
        scrollView = sv
        
        //KVO监听父视图的contentOffset    KVO要监听的对象 负责添加监听者
        //scrollView 要添加监听者 由谁来监听 由self  监听scrollView的contentOffset的变化
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        
    }
    //本视图从父视图上移除
    //提示：所有的下拉刷新框架都是监听父视图的contentOffset
    // 所有的框架KVO  监听实现思路都是这个！
    override func removeFromSuperview() {
        //superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        // suoerView 不存在
    }
    
    //所有 KVO 会统一调用此方法   KVO属于观察者模式
    //在程序中  通常只监听某一个对象的某几个属性 如果属性太多 方法会很乱！
    //观察者模式在不需要的时候都需要释放
    //-通知中心 如果不释放 什么也不会发生但是会有内存泄漏 会有多次注册额的可能
    //- KVO 如果不释放 会崩溃
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        //contentOffset 的 y 值 跟 contentInset 的 top 有关
//        print(scrollView?.contentOffset)
        
        guard let sv = scrollView else{
            return
        }
        //初始高度就应该是 0
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        if height < 0 {
            return
        }
        //可以根据高度设置刷新控件的 frame
        self.frame = CGRect(x: 0, y: -height, width: sv.bounds.width, height: height)
        
        //判断临界点 -只需要判断一次
        if sv.dragging {
            if height > STRefreshOffset{
                print("放手刷新")
            }else{
                print("再使劲...")
            }
        }else{
            //放手
        }
        
    }
    
    //开始刷新
    func beginRefreshing(){
        print("开始刷新")
    }
    
    //结束刷新
    func endRefreshing(){
        print("结束刷新")
    }
}


extension STRefreshControl{
    private func setupUI(){
        backgroundColor = UIColor.orangeColor()
        
        //设置超出边界不显示
        clipsToBounds = true
        //添加刷新视图 - 从xib加载出来 默认是xib 中指定的宽高
        addSubview(refreshView)
        
        //自动布局 - 设置 xib 控件的自动布局 需要指定宽高约束
        //提示 iOS程序员 一定要会原生的写法 因为 如果自己开发的框架 不能用任何的自动布局框架
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
         addConstraint(NSLayoutConstraint(item: refreshView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: refreshView.bounds.width))
        
        addConstraint(NSLayoutConstraint(item: refreshView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: refreshView.bounds.height))
    }
}