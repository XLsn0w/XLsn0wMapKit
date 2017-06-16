//
//  LSXHomeViewCell.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/12.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs
import SnapKit
import SDWebImage

class LSXHomeViewCell: UITableViewCell {
//MARK: 属性
    var viewModel:LSXHomeViewModel? {
        didSet{

            avatarIcon.sd_setImage(with: viewModel?.avatarIconUrl)
            
            nameLabel.text = viewModel?.nameLabelText
            
            statusLabel.text = viewModel?.statusLabelText
            
            srcDirLabel.text = viewModel?.srcDirLabelText
   
            messageLabel.text = viewModel?.messageLabelText
            
            nameLabel.textColor = viewModel?.nameLabelTextColor
            
            verifiedIcon.isHidden = (viewModel?.verifiedIconHidden)!
        
        }
    }
//MARK: 懒加载
    //: 头像认证
    var verifiedIcon: UIImageView = { () -> UIImageView in
        let view = UIImageView(image: #imageLiteral(resourceName: "avatar_enterprise_vip"))
        view.layer.cornerRadius = view.bounds.width*0.5
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    //: 头像信息
    var avatarIcon : UIImageView =  { () -> UIImageView in
        let view = UIImageView(image: #imageLiteral(resourceName: "avatar_default_small"))
        view.layer.cornerRadius = view.bounds.width*0.5
        view.layer.masksToBounds = true
        return view
    }()
    //: 用户名称
    var nameLabel  : UILabel  = { () -> UILabel in
        let label  = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    //: 消息状态
    var statusLabel: UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    //: 消息来源
    var srcDirLabel: UILabel  = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    //: 正文消息
    var messageLabel: UILabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
//MARK： 系统方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHomeViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        //: 布局
        avatarIcon.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.width.height.equalTo(35)
        }
    
        verifiedIcon.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(avatarIcon)
            make.width.height.equalTo(15)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIcon.snp.right).offset(10)
            make.centerY.equalTo(avatarIcon)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right)
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-10)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarIcon)
            make.top.equalTo(avatarIcon.snp.bottom).offset(10)
            make.right.equalTo(statusLabel.snp.right)
        }
        
        srcDirLabel.snp.makeConstraints { (make) in
            make.right.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
//MARK: 私有方法
    private func setupHomeViewCell() {
        //: 头像
        addSubview(avatarIcon)
        addSubview(verifiedIcon)
        
        addSubview(nameLabel)
        addSubview(messageLabel)
        addSubview(statusLabel)
        addSubview(srcDirLabel)
    }
    
    
}
