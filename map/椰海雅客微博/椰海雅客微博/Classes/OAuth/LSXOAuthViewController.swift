//
//  LSXOAuthViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/5.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs
import SVProgressHUD


class LSXOAuthViewController: UIViewController {
//MARK: 懒加载
    var oldTranslationY:CGFloat = 0.0
    
    var isNetWorkWorking:Bool = false
    lazy var mainView:LSXOAuthView = { () -> LSXOAuthView in
        let view = LSXOAuthView()
        view.backgroundColor = UIColor.white
        view.bounds = self.view.bounds
        
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOAuthView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
         QL4("退出了")
    }
//MARK: 私有方法
    private func setupOAuthView() {
        view = mainView
        mainView.delegate = self
        mainView.webView.delegate = self
        
        //: 导航栏
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(closeOAuthView))
        //: ceshi
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addwebView))
        
        self.title = "登陆"
        
        requestOAuthAccessToken()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame , object: nil)
    }
//MARK: 文件私有方法
    fileprivate func requestOAuthAccessToken() {
        
        guard let url = URL(string: "\(ServerDomain)oauth2/authorize?client_id=\(AppKey)&redirect_uri=\(RedirectURL)") else{
            return
        }
        
        let request = URLRequest(url: url)
        
        mainView.webView.loadRequest(request)

    }
//MARK: 内部回调方法
     @objc private func addwebView() {
        
        //: reload
        
        var jsStr = "var a = document.getElementsByTagName('span');"
        jsStr += "alert(a[0].innerText);"
        
        mainView.webView.stringByEvaluatingJavaScript(from: jsStr)
    }
    
    @objc private func closeOAuthView() {
        dismiss(animated: true, completion: nil)
        
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
        }
    }
    
    @objc private func keyboardDidChangeFrame(notification:Notification){
        
        guard let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        
        guard UIScreen.main.bounds.width <= 320 else {
            return
        }
        
        var translationY:CGFloat = 0.0
        
        if frame.origin.y == UIScreen.main.bounds.height {
            translationY = 0.0
        }else{
            translationY = -30.0
        }
        
        if oldTranslationY != translationY {
            oldTranslationY = translationY
            UIView.animate(withDuration: 1.0) {
             
                if frame.origin.y == UIScreen.main.bounds.height {
                    self.mainView.transform = .identity
                }else{
        
                    self.mainView.transform = CGAffineTransform(translationX: 0, y: translationY)
                }
            }
        }

        
        QL2(frame)
    }
}

extension LSXOAuthViewController:UIWebViewDelegate{
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        QL4(error)
        
        SVProgressHUD.dismiss()
        SVProgressHUD.show(#imageLiteral(resourceName: "w_nonet"), status: "网络不好")
        
        isNetWorkWorking = false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       SVProgressHUD.show(withStatus: "加载中...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        SVProgressHUD.dismiss()
        isNetWorkWorking = true
        
//        let html = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('html')[0].innerHTML")
//        
//        QL4(html)
        
        
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        guard let url = request.url?.absoluteString else {
            return false
        }
        
        QL1(url)
        
        if !url.hasPrefix(RedirectURL) {
            return true
        }
        
        let key = "code="
        
        guard let data = request.url!.query else {
            return false
        }
        
        if data.hasPrefix(key) {
            let code = request.url?.query?.substring(from: key.endIndex)
            QL2(code)
            
            loadAccessToken(code: code)
            return false
        }
        
        return false
    }
    
    private func loadAccessToken(code:String?){
        guard let codeString = code else {
            return
        }
        let path = "oauth2/access_token"
        let parmeters = ["client_id":AppKey,"client_secret":AppSecret,"grant_type":"authorization_code","code":codeString,"redirect_uri":"\(RedirectURL)"]
        
        LSXHttpTools.shareInstance.post(path, parameters: parmeters, progress: nil, success: { (task, data) in
            
            let account = LSXUserAccountModel(dictionary: data as! [String:AnyObject])
            //: 读取用户信息
            account.loadAccountInform(finished: { (account, error) in
                //: 存储数据
                account?.saveAccount()
                QL2(account?.description)
                
                //: 切换到登陆界面
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: SystemChangeRootViewControllerNotification), object: self, userInfo: [ToControllerKey:"LSXWelcomeViewController"])
                
            })
            
        }, failure: { (task, error) in
            QL4(error)
        })
        
        
    }
}

//MARK: 登陆界面的代理方法
extension LSXOAuthViewController:LSXOAuthViewDelegate{
    func loginViewLoginButtonClick(withButton button: UIButton, withAccount account: String, withPassword password: String) {
        
guard isNetWorkWorking == true else {
            requestOAuthAccessToken()
            return
        }
        //: js 注入登陆
        var jsStr = "document.getElementById('userId').value='\(account)';"
        jsStr += "document.getElementById('passwd').value='\(password)';"
        jsStr += "document.getElementsByClassName('btnP')[0].click();"
        mainView.webView.stringByEvaluatingJavaScript(from: jsStr)

        
        //: 读取登陆结果
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            //: js 注入
            let jsRet = "document.getElementsByTagName('span')[0].innerText;"
            let result =  self.mainView.webView.stringByEvaluatingJavaScript(from: jsRet)
            QL4("----result:\(result)----")
            
            guard let message:String = result  else {
                return
            }
            
            if message.lengthOfBytes(using: .utf8) != 0 {
                SVProgressHUD.showInfo(withStatus: message)
            }
        }
        
    
    }
}
