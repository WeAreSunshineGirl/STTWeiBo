//
//  WBMainViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit


//主控制器
class WBMainViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildControllers()
        setupComposeButton()
    }
  
    /**
     使用代码控制设备的方向  好处 可以在需要横屏的时候 单独处理
     设置支持的方向之后 当前的控制器以及子控制器都会遵守这个方向
     如果播放视频 通常是通过 model 展现的
     
     - returns: 支持的方向   Portrait 竖屏 landscape 横屏
     */
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    
    
    //MARK: - 监听方法
    /**
     撰写微博
     */
    // FIXME :没有实现
    //private 能够保证方法私有 仅在当前对象被访问
    //@objc 允许这个函数在运行时 通过 OC的消息机制被调用
   @objc private func composeStatus(){
        print("撰写微博")
    //测试方向旋转
    let vc = UIViewController()
    vc.view.backgroundColor = UIColor.cz_randomColor()
    let nav = UINavigationController(rootViewController: vc)
    presentViewController(nav, animated: true, completion: nil)
    
//    self.navigationController?.pushViewController(vc, animated: true)
    
    
    }
    
    
    //MARK:-私有控件
    /// 撰写按钮
    private lazy var composeButton:UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    
    
}

//extension 类似于OC 中的分类 在Swift中还可以用来切分代码块
//可以把相近的功能函数 放在一个extension 中
//便于代码维护
//注意;和OC的分类一样extension 不能定义属性

//MARK: 设置界面
extension WBMainViewController{
    /**
     设置撰写按钮
     */
    private func setupComposeButton(){
        
        tabBar.addSubview(composeButton)
        
        //计算撰写按钮的宽度
        let count = CGFloat(childViewControllers.count)
        // 将向内缩进的宽度减少 能够让按钮的宽度变大 盖住容错点 防止穿帮
        let w = tabBar.bounds.width / count - 1
        //OC CGRectInset 正数向内缩进  负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮的宽度\(composeButton.bounds.width)")
        
        //按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), forControlEvents: .TouchUpInside)
    }
    
    
    ///设置所有子控制器
    private func setupChildControllers(){
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home"],["clsName":"WBMessageViewController","title":"消息","imageName":"message_center"],
            ["clsName":"XXX"],
               ["clsName":"WBDiscoverViewController","title":"发现","imageName":"home"],["clsName":"WBProfileViewController","title":"个人","imageName":"discover"]]
        var arrayM = [UIViewController]()
        
        for dict in array {
            arrayM.append(controller(dict))
        }
        viewControllers = arrayM
    }
    ///使用字典创建一个子控制器
    /**
     使用字典创建一个子控制器
     
     - parameter dict: 信息字典[clsName,title,imageName]
     
     - returns: 子控制器
     */
    private func controller(dict:[String:String])->UIViewController{
        
        //1 取得字典内容
        guard let clsName = dict["clsName"],title = dict["title"],imageName = dict["imageName"],let cls = NSClassFromString(NSBundle.mainBundle().namespace + "." + clsName) as? UIViewController.Type
            else{
                
            return UIViewController()
        }
        
        //2 创建视图控制器   将clsName 转成cls
        let vc = cls.init()
        
        vc.title = title
        
        //3设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        //4 设置tabbar 的标题字体 (大小 系统默认是12号字)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: .Highlighted)
        //系统默认是12号字 修改字体大小 要设置normal 的字体大小
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)], forState: .Normal)
        
        //实例化导航控制器的时候 会调用 push方法 将rootVC 压栈
        let nav = WBNavigationController(rootViewController: vc)
        
        
        return nav
        
    }
    
    
}