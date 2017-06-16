//
//  UIButton+Extension.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(imageName:String,backgroundName:String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: backgroundName), for: .normal)
        setBackgroundImage(UIImage(named: backgroundName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
