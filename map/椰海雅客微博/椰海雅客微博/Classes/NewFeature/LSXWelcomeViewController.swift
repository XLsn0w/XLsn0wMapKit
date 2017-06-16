//
//  LSXWelcomeViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SDWebImage
import QorumLogs

class LSXWelcomeViewController: UIViewController {
//MARK: 懒加载
    lazy var mainView:LSXWelcomeView = { () -> LSXWelcomeView in
       let view = LSXWelcomeView()
        return view
    }()
    
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupWelcomeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        QL4("退出了")
    }
//MARK: 私有方法
    private func setupWelcomeView() {
        mainView.frame = view.bounds
        view = mainView
        
        guard let urlStr = LSXUserAccountModel.loadAccount()?.avatar_large else {
            return
        }
        
        let url = URL(string: urlStr)
        mainView.avatarView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "avatar_default_big"))
    }
    
    private func startAnimation() {
        
        mainView.avatarView.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-200)
        }
        //: 父视图来调用layoutIfNeeded() 才会有动画
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.0, animations: {
            
            self.mainView.avatarView.snp.updateConstraints({ (make) in
                make.bottom.equalToSuperview().offset(-(UIScreen.main.bounds.height - 200))
            })
            
            self.view.layoutIfNeeded()
        }) { (_) in
            
            UIView.animate(withDuration: 2.0, animations: {
                self.mainView.nameLabel.alpha = 1.0
            }, completion: { (_) in
                //: 跳转主页面
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: SystemChangeRootViewControllerNotification), object: self, userInfo: [ToControllerKey:"LSXMainViewController"])
                
            })
        }
        
    }

}
