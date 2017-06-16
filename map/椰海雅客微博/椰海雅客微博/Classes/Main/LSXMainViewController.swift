//
//  LSXMainViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

class LSXMainViewController: UITabBarController {
//MARK:  懒加载
    lazy var composeButton:UIButton = { () -> UIButton in
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
//        button.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
//        button.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
//        button.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
//        button.sizeToFit()
        
        let button = UIButton(imageName: "tabbar_compose_icon_add", backgroundName: "tabbar_compose_button")
        
        button.addTarget(self, action: #selector(composeButtonClick), for: .touchUpInside)
   
        return button
    }()
//MARK:  回调方法
    
    @objc private func composeButtonClick(button:UIButton) {
        QL2("button")
    }
//MARK:  私有方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //: 单独按钮添加
        tabBar.addSubview(composeButton)
        composeButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.height*0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //: 1.添加子控制器
        addChildViewControllers()
        
        

    }
    
    /** 添加所有子控制器*/
   private func addChildViewControllers() {
        //: 获取bundle中的json
        guard let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            QL3("MainVCSettings.json 不存在")
            return
        }
        
        
        guard let data = NSData(contentsOfFile: path) as? Data else {
            QL3("数据读取失败")
            return
        }
    
        do {
            
            
            //: swift 是强语言 遍历前必须指明类型如下下面指定字典数组 as![[String:AnyObject]]
            let objc = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [[String:AnyObject]]
            
            for dictionary in objc{
                QL1(dictionary)
                let controllerName = dictionary["vcName"] as? String
                let title = dictionary["title"] as? String
                let imageName = dictionary["imageName"] as? String
                
            addChildViewControllerDynamic(controllerName, title: title, imageName: imageName)
            }
        } catch  {
            //: 通过类名添加子控制器
            addChildViewControllerDynamic("LSXHomeViewController", title: "首页", imageName: "tabbar_home")
            
            addChildViewControllerDynamic("LSXMessageViewController", title: "消息", imageName: "tabbar_message_center")
            
             addChildViewControllerDynamic("LSXNullViewController", title: "", imageName: "")
            
            addChildViewControllerDynamic("LSXDiscoverViewController", title: "发现", imageName: "tabbar_discover")
            
            addChildViewControllerDynamic("LSXProfileViewController", title: "我", imageName: "tabbar_profile")
            

        }
        
        
        
    }
    
    /** 动态添加子控制器 */
   private func addChildViewControllerDynamic(_ childControllerName: String?,title:String?,imageName:String?) {
        //: 创建控制器
        guard let childController = UIViewController.controller(withName: childControllerName) else {
            
            return
        }
    
        childController.title = title
    
        if let name = imageName {
            
            childController.tabBarItem.image = UIImage(named: name)
            
            childController.tabBarItem.selectedImage = UIImage(named: name.appending("_highlighted"))
            
        }
    
        addChildViewController(UINavigationController(rootViewController: childController))

    
    }
    
    /** 添加子控制器 */
   private func addChildViewController(_ childController: UIViewController,title:String,imageName:String) {
        
        QL1(childController)
        //: 设置标题(简写成一句代码)
//        childController.tabBarItem.title = title
//        childController.navigationItem.title = title
        childController.title = title
        
        //: 不渲染使用原始图片
//        homeVC.tabBarItem.image = UIImage(named: "tabbar_home")?.withRenderingMode(.alwaysOriginal)
//
//        homeVC.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")?.withRenderingMode(.alwaysOriginal)
        
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        
        childController.tabBarItem.selectedImage = UIImage(named: imageName.appending("_highlighted"))?.withRenderingMode(.alwaysOriginal)
    
        addChildViewController(UINavigationController(rootViewController: childController))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
