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

    /// 定时器
    private var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
    }
    deinit{
        
        //释放时钟
        timer?.invalidate()
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

// MARK: - 时钟相关方法
extension WBMainViewController{
    /**
     定义时钟
     */
    private func setupTimer(){
        
        timer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    /**
     时钟触发方法
     */
    @objc private func updateTimer(){
        
        WBNetworkManager.shared.unreadCount { (count) in
            
            print("检测到\(count)条新微博")
            //设置 首页 tabBarItem 的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            //设置 App的 badgeNumber  从ios8.0之后 要用户授权之后才能显示
            UIApplication.sharedApplication().applicationIconBadgeNumber = count
        }
    }
    
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
        
        // 0 获取沙盒的json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let jsonPath = (docDir as NSString).stringByAppendingPathComponent("main.json")
        
        //加载data
        var data = NSData(contentsOfFile: jsonPath)
        //判断data是否有内容 如果没有 说明本地沙河没有文件
        if data == nil {
            //从bundle加载data
            let path = NSBundle.mainBundle().pathForResource("demo.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        
        //data一定会有一个内容 反序列化
         //从Bundle加载配置的json
        //1 路径 2 加载NSData 3 反序列化
       guard let array = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [[String:AnyObject]]
        else{
            return
        }
        
        //在现在很多应用程序中 界面的创建都依赖网络的json
        /*
        let array:[[String:AnyObject]] = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"home","visitorInfo":["imageName":"","message":"关注一些人，回这里看看有什么惊喜"]],
               ["clsName":"WBMessageViewController","title":"消息","imageName":"message_center","visitorInfo":["imageName":"visitordiscover_image_message","message":"登陆后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
               ["clsName":"XXX"],
               ["clsName":"WBDiscoverViewController","title":"发现","imageName":"discover","visitorInfo":["imageName":"visitordiscover_image_message","message":"登陆后，最新最热微博尽在掌握，不再会与事实潮流擦肩而过"]],
               ["clsName":"WBProfileViewController","title":"个人","imageName":"discover","visitorInfo":["imageName":"visitordiscover_image_profile","message":"登陆后，你的微薄相册个人资料会显示在这里，展示给别人"]]]
        
        //测试数据格式是否正确 - 转换成 plist 数据更加直观
//        (array as NSArray).writeToFile("/Users/user/Desktop/demo.plist", atomically: true)
        
        //数组 到 json 序列化
        
//        let data = try? NSJSONSerialization.dataWithJSONObject(array, options: [.PrettyPrinted])
////        
//        let fileUrl = NSURL(fileURLWithPath: "/Users/user/Desktop/demo.json")
//        data?.writeToURL(fileUrl, atomically: true)
        
//        data?.writeToFile("/Users/user/Desktop/demooo.json", atomically: true)
        
        */
        
        /// 遍历数组 循环创建控制器数组
        var arrayM = [UIViewController]()
        
        for dict in array! {
            arrayM.append(controller(dict))
        }
        //设置 tabBar子控制器
        viewControllers = arrayM
    }
    ///使用字典创建一个子控制器
    /**
     使用字典创建一个子控制器
     
     - parameter dict: 信息字典[clsName,title,imageName,"visitorInfo"]
     
     - returns: 子控制器
     */
    private func controller(dict:[String:AnyObject])->UIViewController{
        
        //1 取得字典内容
        guard let clsName = dict["clsName"] as? String,title = dict["title"] as? String,imageName = dict["imageName"] as? String,let cls = NSClassFromString(NSBundle.mainBundle().namespace + "." + clsName) as? WBBaseViewController.Type,
        visitorDict = dict["visitorInfo"] as? [String:String]
            else{
                
            return UIViewController()
        }
        
        //2 创建视图控制器   将clsName 转成cls
        let vc = cls.init()
        
        vc.title = title
        
        //设置控制器的访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
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