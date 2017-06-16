//
//  LSXWelcomeView.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXWelcomeView: UIView {
    
//MARK: 懒加载
    lazy var nameLabel:UILabel = { () -> UILabel in
        let lable = UILabel()
        lable.text = LSXUserAccountModel.loadAccount()?.screen_name?.appending("~欢迎回来...")
        lable.textColor = UIColor.darkGray
        lable.numberOfLines = 0
        lable.alpha = 0.0
        
        return lable
    }()
    
    
    private lazy var backgroudImage:UIImageView = { () -> UIImageView in
       let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        
        imageView.addSubview(self.avatarView)
        imageView.addSubview(self.nameLabel)
        
        return imageView
    }()
    
    lazy var avatarView:UIImageView = { () -> UIImageView in
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar_default_big"))
        imageView.layer.cornerRadius = imageView.bounds.width * 0.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
//MARK: 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupWelcomeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroudImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        avatarView.snp.makeConstraints { (make) in
            make.width.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarView.snp.bottom).offset(20)
        }
    }
    
//MARK: 私有方法
    private func setupWelcomeView() {
        addSubview(backgroudImage)
    }

}
