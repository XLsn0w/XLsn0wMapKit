//
//  LSXTextField.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXTextField: UIView {
    
//MARK: 属性
    lazy var textField:UITextField = { () -> UITextField in
        let textField = UITextField()
        textField.tintColor = SystemTintColor
        textField.clearButtonMode = .unlessEditing
       return textField
    }()
    
    private let backImageView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "new_feature_share_false"))
//MARK: 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        textField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
//MARK: 私有方法
    private func setupTextField() {
        backImageView.isUserInteractionEnabled = true
        backImageView.addSubview(textField)
        addSubview(backImageView)
    }

}
