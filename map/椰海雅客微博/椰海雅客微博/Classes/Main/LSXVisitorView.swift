//
//  LSXVisitorView.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXVisitorView: UIView {
//MARK: 懒加载
    //: 转盘
    lazy var rotationView:UIImageView = { () -> UIImageView in
        let imageView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_smallicon"))
        return imageView
    }()
    //: 转盘遮盖
    lazy var rotationCoverView:UIImageView = { () -> UIImageView in
        let coverView = UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_mask_smallicon"))
        return coverView
    }()
    //: 图片
    lazy var imageView:UIImageView = { () -> UIImageView in
        let iconView =  UIImageView(image: #imageLiteral(resourceName: "visitordiscover_feed_image_house"))
        return iconView
    }()
    //: 标题
    lazy var titleLable:UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.numberOfLines = 0;
        label.text = "新特性，抢先试玩，注册就能体验新的生活方式"
        return label
    }()
    //: 注册
    lazy var registerButton:UIButton = { () -> UIButton in
        let button = UIButton()
        
        button.setTitleColor(SystemTintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setTitle("注册", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_white_disable"), for: .normal)
        return button
    }()
    //: 登录
    lazy var loginButton:UIButton = { () -> UIButton in
        let button = UIButton()
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setTitle("登录", for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "common_button_white_disable"), for: .normal)
        return button
    }()
//MARK: 构造方法
    class  func visitorView() -> LSXVisitorView {
        let view = self.init()
        
        view.addSubview(view.rotationView)
        view.addSubview(view.rotationCoverView)
        view.addSubview(view.imageView)
        view.addSubview(view.titleLable)
        view.addSubview(view.registerButton)
        view.addSubview(view.loginButton)
        
        return view
    }
    
//MARK: 私有方法
    //: 使用自动布局工具snapkit
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rotationView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        rotationCoverView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.top.equalTo(imageView.snp.bottom).offset(40)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleLable.snp.left)
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.right.equalTo(titleLable.snp.right)
            make.top.width.height.equalTo(registerButton)
        }
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        //: 设置动画属性
        animation.toValue = 2 * M_PI
        animation.duration = 10.0
        animation.repeatCount = MAXFLOAT
        
        // 注意: 默认情况下只要视图消失, 系统就会自动移除动画
        // 只要设置removedOnCompletion为false, 系统就不会移除动画
        animation.isRemovedOnCompletion = false
        
        rotationView.layer.add(animation, forKey: "transform.rotation")
        
    }
//MARK: 外部调用方法
    func setupVisitorInfo(imageName: String? ,title: String){
        titleLable.text = title
        
        guard let name = imageName else {
            
            startAnimation()
            return
        }
        
        rotationView.isHidden = true
        imageView.image = UIImage(named: name)
    }
}
