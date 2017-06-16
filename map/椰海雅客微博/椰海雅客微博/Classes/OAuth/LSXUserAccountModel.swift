//
//  LSXUserAccountModel.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/5.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

class LSXUserAccountModel: NSObject,NSCoding {
    //: 用户授权信息
    var access_token: String?
    var expires_in: Int = 0 {
        didSet{
            //: 监听set方法，转换成过期日期
            expiresDate = Date(timeIntervalSinceNow: TimeInterval(expires_in))
        }
    }
    var expiresDate:Date?
    var remind_in: String?
    var uid: String?
    //: 用户账户信息
    var idstr: String?
    var screen_name: String?
    var location: String?
    var gender: String?
    var avatar_large: String?
//MARK: 实现归解档的NSCoding代理方法
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.expires_in, forKey: "expires_in")
        aCoder.encode(self.remind_in, forKey: "remind_in")
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.expiresDate, forKey: "expiresDate")
        
        aCoder.encode(idstr, forKey: "idstr")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    
    required  init?(coder aDecoder: NSCoder) {
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_in = aDecoder.decodeInteger(forKey: "expires_in") as Int
        self.remind_in = aDecoder.decodeObject(forKey: "remind_in") as? String
        self.uid = aDecoder.decodeObject(forKey: "uid") as? String
        self.expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as? Date
        
        self.idstr = aDecoder.decodeObject(forKey: "idstr") as? String
        self.screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        self.location = aDecoder.decodeObject(forKey: "location") as? String
        self.gender = aDecoder.decodeObject(forKey: "gender") as? String
        self.avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
//MARK: 构造方法
    init(dictionary:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let property = ["access_token","expires_in","remind_in","uid","expiresDate","idstr","screen_name","gender","location"]
        let dictionary = dictionaryWithValues(forKeys: property)
        
        return "\(dictionary)"
    }
//MARK: 数据归档存储
    static var account: LSXUserAccountModel?
    static let filePath: String = ("useraccount.plist").cachesDirectories()
    
    func saveAccount() {
        //: 归档
        NSKeyedArchiver.archiveRootObject(self, toFile: LSXUserAccountModel.filePath)
    }
    
    class func loadAccount() -> LSXUserAccountModel? {
        //: 如果已经加载过账号
        if LSXUserAccountModel.account != nil {
            return LSXUserAccountModel.account
        }
        
        
        //: 解档
        guard let account = NSKeyedUnarchiver.unarchiveObject(withFile: LSXUserAccountModel.filePath) as? LSXUserAccountModel else {
            return LSXUserAccountModel.account
        }
        
        //: 校验是否过期 如果过期日期 < 当前日期 表明过期了
        guard let date = account.expiresDate,date.compare(Date()) != ComparisonResult.orderedAscending else {
            return LSXUserAccountModel.account
        }

        LSXUserAccountModel.account = account
        
        return LSXUserAccountModel.account
    }
    
    
    //: 判断用户是否登陆
    class func isLogin() -> Bool {
        return LSXUserAccountModel.loadAccount() != nil
    }
    
    func loadAccountInform(finished:@escaping (_ account: LSXUserAccountModel?,_ error:Error?) -> ()) {
        
        assert(access_token != nil, "获取授权后才能获取用户数据")
        
        let path = "users/show.json"
        let parmeters = ["access_token":access_token!,"uid":uid!]
        
        LSXHttpTools.shareInstance.get(path, parameters: parmeters, progress: nil, success: { (task, data) in
            
            QL2(data)
            
            //: JSON 数据
            let dictionary = data as! [String: AnyObject]
            
            self.idstr = dictionary["idstr"] as? String
            self.avatar_large = dictionary["avatar_large"] as? String
            self.screen_name = dictionary["screen_name"] as? String
            self.gender = dictionary["gender"] as? String
            self.location = dictionary["location"] as? String
            
            finished(self,nil)
        }, failure: { (task, error) in
            QL4(error)
            finished(self,error)
        })
    }
}


