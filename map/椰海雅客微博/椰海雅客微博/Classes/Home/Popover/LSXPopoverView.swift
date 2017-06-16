//
//  LSXPopoverView.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXPopoverView: UIView {
    var popoverArrowDirection:PopoverArrowDirection?
//MARK:  懒加载
    lazy var backgroundView:UIImageView = { () -> UIImageView in
        let view = UIImageView(image: #imageLiteral(resourceName: "popover_background"))
       
        return view
    }()
    
    lazy var tableView:UITableView = { () -> UITableView in
       let view = UITableView()
        view.backgroundColor = UIColor.clear
        return view
    }()

//MARK:  私有方法
    convenience init(_ type:PopoverArrowDirection?){
        self.init()
        
        guard let popoverType = type else{
            addSubview(backgroundView)
            addSubview(tableView)
            
            return
        }
        
        popoverArrowDirection = popoverType

        switch popoverType {
        case .middle:
            backgroundView.image = #imageLiteral(resourceName: "popover_background")
        case .left:
            backgroundView.image = #imageLiteral(resourceName: "popover_background_left")
        case .right:
            backgroundView.image = #imageLiteral(resourceName: "popover_background_right")
        }
        
        addSubview(backgroundView)
        addSubview(tableView)
    }
    
    
    
    override func layoutSubviews() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(0)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(backgroundView).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }
    

}

public enum PopoverArrowDirection : Int {
    
    case middle
    
    case right
    
    case left
    
}

