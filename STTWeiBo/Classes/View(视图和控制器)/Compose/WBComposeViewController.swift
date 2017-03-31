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
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.cz_randomColor()
       setupUI()

    }
     @objc private func back(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


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
}


private extension WBComposeViewController{
    
    func setupUI() {
        
        view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
    }
    
    /**
     设置导航栏
     */
    func setupNavigationBar(){
        
        //设置关闭按钮
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", target: self, action: #selector(back))
        
        //设置发送按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        
        sendButton.enabled = false
    }
}
