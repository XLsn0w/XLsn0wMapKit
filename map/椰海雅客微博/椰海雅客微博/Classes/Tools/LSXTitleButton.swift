//
//  LSXTitleButton.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class LSXTitleButton: UIButton {

    
    convenience init(_ title:String?, imageName:String,selectImageName:String, target: Any?,action: Selector) {
        self.init()
    
        setTitleColor(UIColor.black, for: .normal)
        setTitle(title, for: .normal)
        setImage(UIImage(named:imageName)?.withRenderingMode(.alwaysOriginal), for: .selected)
        setImage(UIImage(named:selectImageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        sizeToFit()
        
        addTarget(target, action: action, for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        
        imageView?.frame.origin.x = titleLabel!.frame.width + 5
    }

}
