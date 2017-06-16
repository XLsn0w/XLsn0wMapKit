//
//  AppDelegate.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //: 使用调试打印工具
        QorumLogs.enabled = true
        QorumLogs.minimumLogLevelShown = 1
        
    
        
        //: 1.创建window(去掉了mian.storyboard)
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = defaultRootViewController()
    
        window?.makeKeyAndVisible()
        
        //: 2.设置主题样式
        UITabBar.appearance().tintColor = SystemTintColor
        UINavigationBar.appearance().tintColor = SystemTintColor
        
        //: 3.注册系统通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeDefaultRootViewController(notification:)), name: NSNotification.Name(rawValue: SystemChangeRootViewControllerNotification), object: nil)
        
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK: 程序更新
extension AppDelegate {
    
    func isNewFeatureVersion() -> Bool {
        
        let newVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        as! String
        
        
        //: 旧版本到新版本为升序
        guard let sanboxVersion = UserDefaults.standard.object(forKey: "APPVersion") as? String , sanboxVersion.compare(newVersion) != .orderedAscending else {
            //: 跟新版本
            UserDefaults.standard.set(newVersion, forKey: "APPVersion")
            return true
        }
        
        
        return false
    }
    
    func defaultRootViewController() -> UIViewController {
        
        //: 没有登陆跳转到系统主界面
        guard LSXUserAccountModel.isLogin() else {
            return LSXMainViewController()
        }
        
        //: 判断是否新版本
        if isNewFeatureVersion() {
            return LSXNewFeatureViewController()
        }
        
        //: 跳转到欢迎主界面
        return LSXWelcomeViewController()
    }
    
    func changeDefaultRootViewController(notification:Notification) {
        
        QL2(notification.userInfo?[ToControllerKey])
        
       
        guard let controllerName = notification.userInfo?[ToControllerKey] as? String else {
            QL4("跳转根控制器失败，传入的控制器名称为空")
            return
        }
        
        guard let controller = UIViewController.controller(withName: controllerName) else {
            QL4("创建控制器失败")
            return
        }

        window?.rootViewController = controller
    }
}

//: <T> 范型函数
func LLog<T>(message:T,file: String = #file,function:String = #function,line:Int = #line){
       print("\((file as NSString).pathComponents.last!).\(function)[\(line)]:\(message)")
}
