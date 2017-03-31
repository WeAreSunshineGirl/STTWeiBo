//
//  WBComposeViewController.swift
//  STTWeiBo
//
//  Created by user on 17/1/12.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 撰写微博控制器
/*
 加载视图控制器的时候 如果XIB 和控制器同名 默认的构造函数 会优先加载 XIB
 
 */
class WBComposeViewController: UIViewController {
    
    /// 文本编辑视图
    @IBOutlet weak var textView: UITextView!
    /// 底部工具栏
    @IBOutlet weak var toolbar: UIToolbar!
    
    /// 发布按钮
    @IBOutlet var sendButton: UIButton!
    /// 工具栏底部约束
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    /// 标题标签 - 换行的 热键 option(Alt)+回车
    //逐行选中文本并且设置属性
    //如果想要调整行间距 可以增加一个空行 设置空行的字体 lineHeight
    @IBOutlet var titleLabel: UILabel!
    
    //MARK:视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.cz_randomColor()
       setupUI()
        
        //监听键盘通知 - UIWindow
        /*
         1 监听对象
         2 监听方法
         3 监听的通知字符串
         4 发送通知的对象 如果是nil 监听所有的对象
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyBoardChanged), name: UIKeyboardWillChangeFrameNotification, object: nil)
        

    }
 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //激活键盘
        textView.becomeFirstResponder()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //关闭键盘
        textView.resignFirstResponder()
    }
    //MARK: 键盘监听方法
    @objc func keyBoardChanged(n:NSNotification){
        print(n)
        
        // 1 目标 rect
        guard let rect = (n.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(), duration = (n.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else{
            return
        }
        
        // 2 设置底部约束的高度
        let offset = view.bounds.height - rect.origin.y
        // 3 更新底部约束
        toolBarBottomConstraint.constant = offset
        
        // 4 动画更新约束
        UIView.animateWithDuration(duration) { 
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: 微博按钮监听方法
     ///发布微博方法
    @IBAction func postStatus() {
        
        print("发布微博")
    }
    ///关闭按钮方法
     @objc private func back(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


private extension WBComposeViewController{
    
    func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        setupToolBar()
    }
    
    /**
     设置工具栏
     */
    func setupToolBar(){
        let itemSettings = [["imageName":"compose_toolbar_picture"],
            ["imageName":"compose_mentionbutton_background"],
            ["imageName":"compose_trendbutton_background"],
            ["imageName":"compose_emoticonbutton_background"],
            ["imageName":"compose_add_background"]]
        
        //遍历数组
        var items = [UIBarButtonItem]()
        for s in itemSettings {
            let btn = UIButton()
            guard let imageName = s["imageName"] else{
                continue
            }
            let image = UIImage(named: imageName)
            let imageHL = UIImage(named: imageName + "_highlighted")
            btn.setImage(image, forState: .Normal)
            btn.setImage(imageHL, forState: .Highlighted)
            
            btn.sizeToFit()
            //追加按钮
            items.append(UIBarButtonItem(customView: btn))
            
            //追加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil))
            
        }
        //删除末位弹簧
        items.removeLast()
        
        toolbar.items = items
        
    }
    /**
     设置导航栏
     */
    func setupNavigationBar(){
        
        //设置关闭按钮
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(back))
        
        //设置发送按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        //设置标题视图
        navigationItem.titleView = titleLabel

        sendButton.enabled = false
    }
}





/*
 //发布按钮的纯代码
 lazy var sendButton: UIButton = {
 let btn = UIButton()
 btn.setTitle("发布", forState: .Normal)
 btn.titleLabel?.font = UIFont.systemFontOfSize(14)
 //设置标题颜色
 btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
 btn.setTitleColor(UIColor.grayColor(), forState: .Disabled)
 
 //设置背景图片
 btn.setBackgroundImage(UIImage(named: "common_button_orange"), forState: .Normal)
 btn.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), forState: .Highlighted)
 btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Disabled)
 //设置大小
 btn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
 return btn
 }()
 */
