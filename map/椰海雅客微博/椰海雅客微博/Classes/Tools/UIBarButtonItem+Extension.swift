//
//  UIBarButtonItem+Extension.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //: 遍历构造方法
    convenience init(_ imageName:String,target: Any?,action: Selector) {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        self.init(customView:button)
    }
}
