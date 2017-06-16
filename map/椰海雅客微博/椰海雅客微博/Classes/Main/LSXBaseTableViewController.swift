//
//  LSXBaseTableViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class LSXBaseTableViewController: UITableViewController {
    var isLogin:Bool = LSXUserAccountModel.isLogin()
//    var isLogin:Bool = false
    var visitorView:LSXVisitorView?
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    //MARK: 私有方法
    private func setupVisitorView() {
        //: 访客视图
        visitorView = LSXVisitorView.visitorView()
        
        visitorView!.backgroundColor = UIColor.init(white: 238.0/255.0, alpha: 1.0)
        view = visitorView
        
        //: 按钮
        visitorView?.loginButton.addTarget(self, action: #selector(visistorLogin(button:)), for: .touchUpInside)
        visitorView?.registerButton.addTarget(self, action: #selector(visistorRegister(button:)), for: .touchUpInside)
        
        //: 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style:.plain, target: self, action: #selector(visistorRegister(button:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style:.plain, target: self, action: #selector(visistorLogin(button:)))
    }
    
    @objc private func visistorLogin(button:UIButton){
        present(UINavigationController(rootViewController: LSXOAuthViewController()), animated: true, completion: nil)
    }
    
    @objc private func visistorRegister(button:UIButton){
        
    }
}
