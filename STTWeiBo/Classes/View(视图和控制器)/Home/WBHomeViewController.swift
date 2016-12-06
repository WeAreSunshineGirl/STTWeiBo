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

    /// 微博数据数组
    private var statusList = [String]()
    
    /**
     加载数据
     */
    override func loadData() {
        print("开始加载数据")
        
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
            
        }
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
        return statusList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 1 取 cell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        // 2 设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        
        //3 返回 cell
        return cell
    }
    
}


//MARK:- 设置界面
extension WBHomeViewController{
    /**
     重写父类方法
     */
    override func setupUI(){
        super.setupUI()
        
        //设置导航栏按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .Plain, target: self, action: #selector(showFriends))
        
//        let btn:UIButton = UIButton.cz_textButton("好友", fontSize: 16, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.orangeColor())
//        btn.addTarget(self, action: #selector(showFriends), forControlEvents: .TouchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        //注册原型 cell
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
    }
}