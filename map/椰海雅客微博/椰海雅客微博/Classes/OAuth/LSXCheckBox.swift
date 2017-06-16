//
//  LSXCheckBox.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXCheckBox: UIView {
    
//MARK: 属性
    lazy var button:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        button.setImage(#imageLiteral(resourceName: "new_feature_share_false"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "new_feature_share_true"), for: .selected)
        button.adjustsImageWhenHighlighted = false
        
        return button
    }()
    
    lazy var label:UILabel = { () -> UILabel in
        let lable = UILabel()
        
        lable.text = "记住账号"
        lable.textColor = UIColor.darkText
        lable.textAlignment = .left
        return lable
    }()
//MARK: 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCheckBox()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        button.snp.makeConstraints { (make) in
            make.left.centerY.height.equalToSuperview()
            make.width.equalTo(button.snp.height)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(button.snp.right).offset(15)
            make.centerY.height.equalTo(button)
            make.right.equalToSuperview().offset(-15)
        }
    }
    //MARK: 私有方法
    private func setupCheckBox() {
        addSubview(button)
        addSubview(label)
    }
}
