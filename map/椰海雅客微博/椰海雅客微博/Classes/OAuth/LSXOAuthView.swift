//
//  LSXOAuthView.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/5.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SnapKit

class LSXOAuthView: UIView {
//MARK: 属性
    weak var delegate:LSXOAuthViewDelegate?
//MARK: 懒加载
    lazy var webView:UIWebView = { () -> UIWebView in
        let web = UIWebView()
        
        return web
    }()
    
    //: 用户名
    private lazy var accountTextField:LSXTextField = { () -> LSXTextField in
      let account = LSXTextField()
        account.textField.placeholder = "输入微博账号／邮箱地址"
     
        guard let text = UserDefaults.standard.object(forKey: "usr_account") as? String else{
            return account
        }
        account.textField.text = text
        
        return account
    }()
    
    //: 密码
    private lazy var passwordTextField:LSXTextField = { () -> LSXTextField in
        let password = LSXTextField()
        password.textField.placeholder = "输入密码"
        password.textField.isSecureTextEntry = true
        return password
    }()
    
    //: 记住账号
    private lazy var rememberAccount:LSXCheckBox = LSXCheckBox()
    
    //: 登陆按钮
    private lazy var loginButton:UIButton = { () -> UIButton in
        let button = UIButton(type: .custom)
        
        button.setBackgroundImage(#imageLiteral(resourceName: "new_feature_finish_button"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "new_feature_finish_button_highlighted"), for: .highlighted)
        
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.isEnabled = false
        
        return button
    }()
    
    
    //: 登陆界面
    lazy var userLoginView:UIView = { () -> UIView in
    
       let view = UIView()
        view.backgroundColor = UIColor.white
//        view.isHidden = true
        
       let iconView = UIImageView(image:#imageLiteral(resourceName: "applogo"))
        view.addSubview(iconView)
        

        
        let accountLabel = UILabel()
        accountLabel.text = "账号："
        accountLabel.textColor = UIColor.darkText
        view.addSubview(accountLabel)
        
       
        
        let passwordLabel = UILabel()
        passwordLabel.text = "密码："
        passwordLabel.textColor = UIColor.darkText
        view.addSubview(passwordLabel)
        
        view.addSubview(self.accountTextField)
        view.addSubview(self.passwordTextField)
        
        view.addSubview(self.rememberAccount)
        view.addSubview(self.loginButton)
        
        iconView.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 120))
            make.top.equalToSuperview().offset(100)
        })
        
        var leftMargin = 0
        var textFieldwidth = 0
        var topMargin = 0
        var middleMargin = 0
        var textLabelHeight = 0
        var buttonHeight = 0
        if UIScreen.main.bounds.width > 320 {
            leftMargin = 70
            textFieldwidth = 220
            topMargin = 60
            middleMargin = 20
            textLabelHeight = 40
            buttonHeight = 50
    
        }else{
            leftMargin = 40
            textFieldwidth = 180
            topMargin = 40
            middleMargin = 14
            textLabelHeight = 35
            buttonHeight = 40
        }
        
        
        //: 布局代码
        accountLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(iconView.snp.bottom).offset(topMargin)
            make.left.equalToSuperview().offset(leftMargin)
        })
        
        self.accountTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(accountLabel)
            make.left.equalTo(accountLabel.snp.right)
            make.right.equalToSuperview().offset(-leftMargin)
            make.height.equalTo(40)
            make.width.equalTo(textFieldwidth)
        }
        
        passwordLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(self.accountTextField.snp.bottom).offset(middleMargin)
            make.left.equalToSuperview().offset(leftMargin)
        })
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordLabel)
            make.left.equalTo(passwordLabel.snp.right)
            make.right.equalToSuperview().offset(-leftMargin)
            make.height.equalTo(textLabelHeight)
            make.width.equalTo(textFieldwidth)
        }
        
        self.rememberAccount.snp.makeConstraints { (make) in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(middleMargin)
            make.left.equalTo(passwordLabel.snp.left)
            make.right.equalTo(self.passwordTextField.snp.right)
            make.height.equalTo(textLabelHeight)
        }
        
        self.loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.rememberAccount.snp.bottom).offset(middleMargin)
            make.left.equalTo(passwordLabel.snp.left)
            make.right.equalTo(self.passwordTextField.snp.right)
            make.height.equalTo(buttonHeight)
        }
        
       return view
    }()

//MARK: 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOAuthView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        userLoginView.snp.makeConstraints { (make) in
            
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        accountTextField.snp.makeConstraints { (make) in
            
        }
    }
    
//MARK: 私有方法
    private func setupOAuthView() {
        addSubview(webView)
        addSubview(userLoginView)
        
        rememberAccount.button.addTarget(self, action: #selector(rememberAccountClick(button:)), for: .touchUpInside)
        
        accountTextField.textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        loginButton.addTarget(self, action: #selector(loginButtonClick(button:)), for: .touchUpInside)
        
        
        
    }
    
    @objc private func rememberAccountClick(button:UIButton){
        button.isSelected = !button.isSelected
        
        guard let account = accountTextField.textField.text else {
            return
        }
        UserDefaults.standard.set(account, forKey: "usr_account")
    }
    
    @objc private func textFieldDidChanged() {
        loginButton.isEnabled = (((accountTextField.textField.text?.lengthOfBytes(using: .utf8)) != 0) && ((passwordTextField.textField.text?.lengthOfBytes(using: .utf8)) != 0))

    }
    
    @objc private func loginButtonClick(button:UIButton){
        delegate?.loginViewLoginButtonClick(withButton: button, withAccount: accountTextField.textField.text!, withPassword: passwordTextField.textField.text!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.endEditing(true)
    }
    

}

protocol LSXOAuthViewDelegate:NSObjectProtocol {
  
    func loginViewLoginButtonClick(withButton button:UIButton,withAccount account:String,withPassword password:String) ->Void
}
