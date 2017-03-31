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
        
        view.backgroundColor = UIColor.cz_randomColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(back))

    }
     @objc private func back(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
