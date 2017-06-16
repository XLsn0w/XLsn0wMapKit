//
//  LSXHomeViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs
import SVProgressHUD
import LSXPropertyTool

class LSXHomeViewController: LSXBaseTableViewController {
    
    let cellID = "homeCell"
    
    var homeTimelines:Array<LSXHomeViewModel>? {
        didSet{
            //: 跟新数据
            tableView.reloadData()
        }
    }
    
    fileprivate var selectButton:UIButton?
//MARK: 懒加载
    lazy var animationManager:LSXPresentationManager = { () -> LSXPresentationManager in
        let manager = LSXPresentationManager()
        manager.presentAreaSize = CGSize(width: 200, height: 300)
        return manager
    }()
//MARK: 系统方法
    convenience init() {
        self.init(style:.grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if !isLogin {
            visitorView?.setupVisitorInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        //: 设置导航条
        navigationItem.leftBarButtonItem = UIBarButtonItem("navigationbar_friendattention", target: self, action: #selector(friendDattention))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem("navigationbar_pop", target: self, action: #selector(navigationScanQRCode))
        
        let title = LSXUserAccountModel.loadAccount()?.screen_name
        navigationItem.titleView = LSXTitleButton(title, imageName:"navigationbar_arrow_up",selectImageName:"navigationbar_arrow_down", target: self, action: #selector(titleButtonClick(button:)))
        
        //: 获取主页网络数据
        loadHomeWeiboData()
        
        //: 自动预估高度
        tableView.estimatedRowHeight = 800
        tableView.rowHeight = UITableViewAutomaticDimension
    }
//MARK: 私有方法
    private func loadHomeWeiboData() {
        LSXHttpTools.shareInstance.loadHomeWeiboStatus { (array, error) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "更新数据失败")
                return
            }
            
            guard let data = array as Array<Any>? else {
                SVProgressHUD.showError(withStatus: "正在获取数据...")
                return
            }
            
 //: JOSN数据过大生产代码耗性能
//            PropertyCodeMake.propertyCodeMake(withDictionaryArray: data, fileName: "Statuses", filePath: "/Users/lishaxin/Desktop/Models/yehaiyake")
            
            
        
            self.homeTimelines = LSXHomeViewModel.viewModel(withModelArray: ExchangeToModel.model(withClassName: "Statuses", withArray: data) as? Array<Statuses>)
            guard self.homeTimelines?.count != 0  else{
                return
            }
            
        }
    }
    
    @objc private func titleButtonClick(button:UIButton){
        button.isSelected = !button.isSelected
        selectButton = button
        
        let controller = UIViewController()
        controller.view = LSXPopoverView(.middle)
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = animationManager;
        animationManager.delegate = self
        animationManager.sourceRect = button.frame
        animationManager.popoverArrowDirection = (controller.view as! LSXPopoverView).popoverArrowDirection
        
        present(controller, animated: true, completion: nil)
    }
//MARK: 内部回调方法
    @objc private func friendDattention(){
//        present(LSXWelcomeViewController(), animated: true, completion: nil)
        present(LSXNewFeatureViewController(), animated: true, completion: nil)

    }
    
    @objc private func navigationScanQRCode(){
        
        present(UINavigationController(rootViewController: LSXQRCodeViewController()), animated: true, completion: nil)
    }
//MARK: 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: 数据源方法
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {

        
        return self.homeTimelines?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LSXHomeViewCell
        
        if cell == nil {
            cell = LSXHomeViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.viewModel = self.homeTimelines![indexPath.section]
        
        
        
        return cell!
    }
}

//MARK: 转场动画代理方法->LSXPresentationManagerDelegate
extension LSXHomeViewController:LSXPresentationManagerDelegate{
    func animationControllerPresented(manager: LSXPresentationManager) {
        
        
    }
    
    func animationControllerDismissed(manager: LSXPresentationManager) {
        selectButton?.isSelected = !selectButton!.isSelected
    }
}
