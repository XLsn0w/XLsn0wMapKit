//
//  LSXNewFeatureViewController.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

class LSXNewFeatureViewController: UIViewController {
    let ID:String = "cell"
//MARK: 懒加载

    lazy var mainView:UICollectionView = { () -> UICollectionView in
        let view = UICollectionView(frame: self.view.frame, collectionViewLayout: LSXNewFeatureViewFlowLayout.init())
        
        return view
    }()
//MARK: 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()

        //: 添加主界面
        setupNewFeatureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        QL4("退出了")
    }
//MARK: 私有方法
    private func setupNewFeatureView() {
        mainView.register(LSXNewFeatureView.self, forCellWithReuseIdentifier: ID)
        mainView.dataSource = self
        mainView.delegate = self
        view = mainView
    }

}

//MARK: 数据源方法->UICollectionViewDataSource

extension LSXNewFeatureViewController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:LSXNewFeatureView =  collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! LSXNewFeatureView

        cell.backgroundColor = SystemTintColor
        cell.delegate = self
        cell.index = indexPath.item
        
        return cell
    }
    
}

//MARK: 代理方法
extension LSXNewFeatureViewController:UICollectionViewDelegate{
    //: cell 完全显示时调用
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let index = collectionView.indexPathsForVisibleItems.last!
        let visibleCell:LSXNewFeatureView = collectionView.cellForItem(at: index) as! LSXNewFeatureView
        if index.item == visibleCell.images.count - 1 {
            
            if !visibleCell.isEnteryButtonShow() {
                visibleCell.showEnteryButton() 
            }
         
        }
    }
}

//MARK: 新特性View的代理方法

extension LSXNewFeatureViewController:LSXNewFeatureViewDelegate{
    func newFeatureViewEnteryButtonClick(button: UIButton) {
        QL1("进入主页面")
        //: 跳转主页面
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: SystemChangeRootViewControllerNotification), object: self, userInfo: [ToControllerKey:"LSXMainViewController"])
        
    }
}
