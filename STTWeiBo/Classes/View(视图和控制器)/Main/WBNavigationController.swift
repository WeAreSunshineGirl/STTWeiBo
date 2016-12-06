//
//  WBNavigationController.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //隐藏默认的NavigationBar
        navigationBar.hidden = true
    }
    
    
    
    
    
    
    /**
     重写push方法
     
     - parameter viewController: 是被 push 的控制器 设置它的在右侧按钮作为返回按钮
     - parameter animated:       true
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        //如果不是栈底控制器 才需要隐藏 根控制器不需要处理
        if childViewControllers.count > 0{
            //隐藏底部的tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            //判断控制器的类型       如果不是基类  就找不到navItem
            if let vc = viewController as? WBBaseViewController{
                var title = "返回"
                
                //判断控制器的级数
                if childViewControllers.count == 1{
                    //title显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                //取出自定义的 navItem 设置左侧按钮作为返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent),isBack:true)
            }
            

        }
       super.pushViewController(viewController, animated: true)
    }
    /**
     返回到上一级控制器
     */
    @objc private func popToParent(){
        popViewControllerAnimated(true)
    }
    
}
