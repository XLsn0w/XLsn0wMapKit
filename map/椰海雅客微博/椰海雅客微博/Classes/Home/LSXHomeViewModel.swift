//
//  LSXHomeViewModel.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/13.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import SDWebImage
import QorumLogs

class LSXHomeViewModel: NSObject {
    
    var model:Statuses?
    
    var avatarIconUrl:URL?
    
    var nameLabelText:String?
    
    var nameLabelTextColor:UIColor?
    
    var verifiedIconHidden:Bool = false
    
    var statusLabelText:String?
    
    var srcDirLabelText:String?
    
    var messageLabelText:String?
    
    var picUrl:Array<Pic_Urls>?
    
    init(withModel model:Statuses) {
        self.model = model
        
        if let iconUrl = model.user?.avatar_hd{
            avatarIconUrl = URL(string: iconUrl )
        }
        
        nameLabelText = model.user?.name
        
        
        if let date = model.created_at,date != "" {
            //: 日期格式 Wed Apr 12 23:27:53 +0800 2017
            let severDate = Date().createDate(withDateString: date, withDateFormatter: "EE MM dd HH:mm:ss Z yyyy")
            let interval = severDate?.timeIntervalSince(Date())
            
            if abs(Int(round(interval!))) < 60 {
                statusLabelText = "刚刚"
            }else if abs(Int(round(interval!))) < 60*60 {
                statusLabelText = "\(abs(Int(round(interval!)))/60)分钟前"
            }else if abs(Int(round(interval!))) < 60*60*24 {
                statusLabelText = "\(abs(Int(round(interval!)))/(60*60))小时前"
            }else {
                let calendar = Calendar.current.dateComponents([.year,.month,.day], from: severDate!)
                statusLabelText = "\(calendar.year)-\(calendar.month)-\(calendar.day)"
            }
            
        }
        
        
        //: 来源处理
        if let source = model.source , source != "" {
            srcDirLabelText = "来自：" + source.substring(fromString: ">", toString: "</a>")
            
        }
        
        messageLabelText = model.text
        
        if (model.user?.verified)! {
            nameLabelTextColor = SystemTintColor
            verifiedIconHidden = false
        }else{
            nameLabelTextColor = UIColor.black
            verifiedIconHidden = true
        }
    }
    
    //: 缓存图片
    class func cachesImages(withViewModelsArray viewModels:Array<LSXHomeViewModel>?) {
        
        let group = DispatchGroup()
        
        for viewMode in viewModels! {
            
            guard let pic_urls = viewMode.model?.pic_urls  else {
                continue
            }
            
            for j in 0..<pic_urls.count {
                guard let url = pic_urls[j].thumbnail_pic else {
                    continue
                }
                
                group.enter()
                SDWebImageManager.shared().loadImage(with: URL(string: url), options: SDWebImageOptions.init(rawValue: 0), progress: nil, completed: { (image, _, error, _, _, _) in
                    group.leave()
                    QL2("图片下载完毕")
                })
                
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            QL2("全部下载完毕")
        }
    }
    
    //: 模型转换为视图模型
    class func viewModel(withModelArray array:Array<Statuses>?) -> Array<LSXHomeViewModel>?{
        
        guard array?.count != 0 else {
            return nil
        }
        
        var arrayViewModel:Array<LSXHomeViewModel> = Array<LSXHomeViewModel>()
        
        for i in 0..<array!.count {
            let viewModel = LSXHomeViewModel(withModel: array![i])
            
            arrayViewModel.append(viewModel)
        }
        
        return arrayViewModel
    }
}
