//
//  WBHomeViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

//定义全局常量 常量使用 private 修饰 否则到处可以访问
private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

//    /// 微博数据数组
//    private var statusList = [String]()
    
    /// 列表视图模型
    private lazy var listViewModel = WBStatusListViewModel()
    
    /**
     加载数据
     */
    override func loadData() {
        /*
        //用网络工具加载微博数据   测试使用
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token":"2.00mqiHMEXmKOnDdeff3a547e9YmKFD"]
//        WBNetworkManager.shared.GET(urlString, parameters: params, progress: nil, success: { (_, json) in
//            
//            print(json)
//            
//            }) { (_, error) in
//                print("网络请求失败\(error)")
//        }
        
        WBNetworkManager.shared.request(URLString: urlString, parameters: params) { (json, isSuccess) in
            print(json)
        }
        */
        print("准备刷新，最后一条\(self.listViewModel.statusList.last?.status.text)")
        listViewModel.loadStatus(self.isPullup) { (isSuccess,shouldRefresh) in
            
            print("数据加载结束")
            //结束刷新控件
            self.refreshControl?.endRefreshing()
            
            //恢复上拉刷新标记
            self.isPullup = false
            
            //刷新表格
            if shouldRefresh{
                
                self.tableView?.reloadData()
            }
            

        }
        
        
       /*
        //用网络工具加载微博数据 测试使用
        WBNetworkManager.shared.statusList({ (list, isSuccess) in
            print(list)
        })
        print("开始加载数据\(WBNetworkManager.shared)")
        
        //模拟 延时  加载数据 -dispatch_after
//        dispatch_after(DISPATCH_TIME_NOW , dispatch_get_main_queue()) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue()){
            
        for i in 0..<15 {
            
            if self.isPullup{
                //将数据追加到底部
                self.statusList.append("上拉\(i)")
                
            }else{
                //将数据插入到数组的顶部
                 self.statusList.insert(i.description, atIndex: 0)
            }
        }
          print("数据加载完成")
            //结束刷新控件
            self.refreshControl?.endRefreshing()
                
            //恢复上拉刷新标记
            self.isPullup = false
           //刷新表格
            self.tableView?.reloadData()
            
        }*/
    } 
    
    
    //MARK: -监听方法
    /**
     显示好友
     */
    @objc private func showFriends(){
        
        let vc = WBDemoViewController()
                
        //push 的动作是 nav 做的
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
//MARK: 表格数据源方法
extension WBHomeViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 1 取 cell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! WBStatusCell
        
        // 2 设置cell
        let viewModel = listViewModel.statusList[indexPath.row]
        cell.statusLabel?.text = viewModel.status.text
        
        cell.nameLabel.text = viewModel.status.user?.screen_name
        
        //3 返回 cell
        return cell
    }
    
}


//MARK:- 设置界面
extension WBHomeViewController{
    /**
     重写父类方法
     */
    override func setupTableView() {
        super.setupTableView()
            
        //设置导航栏按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .Plain, target: self, action: #selector(showFriends))
        
//        let btn:UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.orangeColor())
//        btn.addTarget(self, action: #selector(showFriends), forControlEvents: .TouchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型 cell  开始自定义cell 所以注释
//        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView?.registerNib(UINib(nibName: "WBStatusNormalCell",bundle: nil), forCellReuseIdentifier: cellId)
        
         //设置行高
         tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 300
        
        //取消分割线
        tableView?.separatorStyle = .None
        
        setupNavTitle()
    }
    /**
     设置导航栏
     */
    private func setupNavTitle(){
        
        let  title = WBNetworkManager.shared.userAccount.screen_name
        
        let button = WBTitleButton(title: title)
        
        navItem.titleView = button
        
        button.addTarget(self, action: #selector(clickTitleButton), forControlEvents: .TouchUpInside)
    }
    
    @objc func clickTitleButton(btn:UIButton){
        
        //选中状态
        btn.selected = !btn.selected
    }
}