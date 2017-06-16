//
//  LSXNewFeatureView.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXNewFeatureView: UICollectionViewCell {

//MARK: 属性
    weak var delegate:LSXNewFeatureViewDelegate?
    var index:Int = 0 {
        didSet{
            backImageView.image = images[index]
            enteryButton.isHidden = true
        }
    }
    
    let images:[UIImage] = [#imageLiteral(resourceName: "newfeature-0"),#imageLiteral(resourceName: "newfeature-1"),#imageLiteral(resourceName: "newfeature-2")]
    private lazy var backImageView:UIImageView = UIImageView()
    private lazy var enteryButton:UIButton = { () -> UIButton in
        let button = UIButton(type:.custom)
    
        button.setImage(#imageLiteral(resourceName: "new_feature_button"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "new_feature_button_highlighted"), for: .highlighted)

        button.isHidden = true
        
        return button
    }()
//MARK: 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNewFeatureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var bottomMargin = 0
        if UIScreen.main.bounds.width > 320 {
            bottomMargin = 170
        }else{
            bottomMargin = 130
        }
        
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        enteryButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
        
    }
//MARK: 私有方法
    private func setupNewFeatureView() {
       contentView.addSubview(backImageView)
       backImageView.addSubview(enteryButton)
    
        enteryButton.addTarget(self, action: #selector(LSXNewFeatureView.enteryButtonClick(button:)), for: .touchUpInside)
    }
    
    @objc private func enteryButtonClick(button:UIButton) {
        delegate?.newFeatureViewEnteryButtonClick(button: button)
    }
    
//MARK: 外部拓展方法
    func showEnteryButton(){
        backImageView.isUserInteractionEnabled = true
        enteryButton.isHidden = false
        enteryButton.isUserInteractionEnabled = false
        
        enteryButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: 2.0, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseOut, animations:{ () -> Void in
            self.enteryButton.transform = .identity
        }, completion:{(_) -> Void in
            self.enteryButton.isUserInteractionEnabled = true
        })
        
        
    }
    
    func isEnteryButtonShow() -> Bool {
        return !enteryButton.isHidden
    }
}

protocol LSXNewFeatureViewDelegate : NSObjectProtocol{
    func newFeatureViewEnteryButtonClick(button:UIButton) -> Void
}
