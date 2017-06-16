//
//  LSXPresentationController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class LSXPresentationController: UIPresentationController {
    var presentAreaSize:CGSize = CGSize()
    var presentLocation:CGPoint = CGPoint()
//MARK: 懒加载
    private lazy var coverButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        button.frame = UIScreen.main.bounds
        button.backgroundColor = UIColor.clear
        return button
    }()
//MARK: 系统方法
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
//MARK: 重写父类方法
    //: 转场布局子控制器的方法
    override func containerViewWillLayoutSubviews() {
        //: 弹出视图尺寸与位置
        presentedView?.frame.size = presentAreaSize
        presentedView?.frame.origin = presentLocation
        
        //: 蒙板
        containerView?.insertSubview(coverButton, at: 0)
        coverButton.addTarget(self, action: #selector(coverButtonClick), for: .touchUpInside)
        
    }
//MARK: 内部回调私有方法
    @objc private func coverButtonClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
