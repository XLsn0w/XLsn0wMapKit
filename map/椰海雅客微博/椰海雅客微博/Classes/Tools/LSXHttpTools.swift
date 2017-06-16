//
//  LSXHttpTools.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/5.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import AFNetworking
import QorumLogs

class LSXHttpTools: AFHTTPSessionManager {
//MARK: 单例
    static let shareInstance:LSXHttpTools = { () -> LSXHttpTools in
        let instance = LSXHttpTools(baseURL: URL(string:ServerDomain), sessionConfiguration:.default)
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript","text/plain") as? Set
        
        return instance
    }()

//MARK: 网络数据请求处理方法
    func loadHomeWeiboStatus(finished:@escaping (_ array:Array<Any>?,_ error:Error?) ->Void ) {
        
        assert(LSXUserAccountModel.loadAccount() != nil, "授权登陆后才可以获取用户数据")
        
        let path = "2/statuses/home_timeline.json"
        let parmeters = ["access_token":LSXUserAccountModel.loadAccount()!.access_token]
        
        get(path, parameters: parmeters, progress: nil, success: { (task, data) in
            
            QL2(data)
            
            guard let status = (data as! Dictionary<String,Any>)["statuses"]  else {
                finished(nil,NSError(domain: RedirectURL, code: 404, userInfo: ["msg":"Returned Null Value!"]) as Error)
                return
            }
            
            finished(status as? Array<Any>,nil)
            

        }, failure: { (task, error) in
            
            finished(nil,error)
            QL4(error)
        })
    }
}
