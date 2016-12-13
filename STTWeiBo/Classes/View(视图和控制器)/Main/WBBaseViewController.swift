//
//  WBBaseViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit


// 面试题 OC中支持多继承吗 如果不支持 如何替代？ 答案 使用协议替代！
//swift 的写法更类似于多继承！
//class WBBaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//swift中利用 extension 可以把函数 按照功能分类管理 便于阅读和维护
//注意
//1 extension 中不能有属性
//2 extension 中不能重写’ 父类 ‘本类的 方法  重写父类方法是子类的职责  扩展是对类的扩展


/// 所有主控制器的基类控制器
class WBBaseViewController: UIViewController{
    
    /// 用户登录标记  为 true 时 显示数据 否则是访问视图页面 
//    var userLogin = true //可以用accessToken有值没值来判断
    
    /// 访客视图字典信息
    var visitorInfoDictionary:[String:String]?
    
    /// 表格视图 - 如果用户没有登录,就不创建
    var tableView:UITableView?
    /// 刷新控件
    var refreshControl:UIRefreshControl?
    /// 上拉刷新标记
    var isPullup = false
    
    /// 自定义导航条   因为是使航条渲染所以自定义
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    /// 自定义的导航条目 -- 以后设置导航栏内容 统一使用 navitem
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
        
        WBNetworkManager.shared.userLogon ? loadData() :()
        
        
    }
    /// 重写 title 的 didSet
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    /**
     加载数据 具体的实现由子类负责
     */
    func loadData(){
        
        //如果子类不实现任何方法 默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
}

//MARK: 访客视图监听方法
extension WBBaseViewController{
    
    @objc private func login(){
        
        print("用户登录")
    }
    
    @objc private func register(){
        
        print("用户注册")
    }
    
    
    
}


//MARK:- 设置界面
extension WBBaseViewController{
    /**
     设置界面
     */
   private func setupUI(){
        
        /**
         用不到随机色了 UIColor.cz_randomColor() 设成白色
         */
        view.backgroundColor = UIColor.whiteColor()
        
        //取消自动缩进 - 如果隐藏导航栏会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        
        
        setupNavigationBar()
        
        WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    /**
     设置表格视图 只有用户登录之后 执行（子类重写此方法）因为子类不需要关心用户登录之前的逻辑
     */
     func setupTableView(){
        
       tableView = UITableView(frame: view.bounds, style: .Plain)
        
       view.insertSubview(tableView!, belowSubview: navigationBar)
        
        ///设置数据源和代理 - 目的 子类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        
        //设置刷新控件
        //1 实例化控件
        refreshControl = UIRefreshControl()
        
        //2 添加到表格视图
        tableView?.addSubview(refreshControl!)
        
        //3 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), forControlEvents: .ValueChanged)
    }
    
    /**
     设置访客视图
     */
    private func setupVisitorView(){
        
        let visitorView = WBVisitorView(frame: view.bounds)
        
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
//        print("访客视图\(visitorView)")
        /// 1设置访客视图信息
        visitorView.visitorInfo = visitorInfoDictionary
        
        
        // 2 添加访客视图的监听方法
        visitorView.registerButton.addTarget(self, action: #selector(register), forControlEvents: .TouchUpInside)
        visitorView.loginButton.addTarget(self, action: #selector(login), forControlEvents: .TouchUpInside)
        
        // 3 设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(login))
    }
    
    
    /**
     设置导航条
     */
    private func setupNavigationBar(){
        //添加导航条
        view.addSubview(navigationBar)
        
        //将item设置给bar
        navigationBar.items = [navItem]
        
        // 1 设置 navBar 的 渲染颜色 设置导航条整个背景的
        navigationBar.barTintColor = UIColor.cz_colorWithHex(0xF6F6F6)
        
        // 2 设置navBar的字体颜色
//        navigationBar.tintColor = UIColor.darkGrayColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGrayColor()]
        
        //3 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orangeColor()
    }
}

//MARK:UITableViewDelegate,UITableViewDataSource
extension WBBaseViewController:UITableViewDelegate,UITableViewDataSource{
    
    //基类只是准备方法 子类负责具体的实现
    //子类的数据源方法不需要 super
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //只是保证没有语法错误
        return UITableViewCell()
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    /**
     在显示最后一行的时候 做上拉刷新
     
     - parameter tableView: <#tableView description#>
     - parameter cell:      <#cell description#>
     - parameter indexPath: <#indexPath description#>
     */
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        /*
        /**
         *  有种动画效果
         *
         *  @param 0.1 <#0.1 description#>
         *  @param 0.1 <#0.1 description#>
         *  @param 1   <#1 description#>
         *
         *  @return <#return value description#>
         */
        //设置cell的显示动画为3D缩放
        //xy方向缩放的初始值为0.1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        //设置动画时间为0.25秒，xy方向缩放的最终值为1
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform=CATransform3DMakeScale(1, 1, 1)
        })
        */
        
        //1 判断indexPath是否是最后一行(indexPath.section(最大)/indexPath.row（最后一行）)
         // 1row
        let row = indexPath.row
         // 2 section
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        //3 行数
        let count = tableView.numberOfRowsInSection(section)
        
        //如果是最后一行 同事没有开始上拉刷新
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            isPullup = true
            //开始刷新
            loadData()
        }
    }
    
}


