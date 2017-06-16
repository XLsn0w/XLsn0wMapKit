//
//  String+Extension.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

extension String{
    //: 快速生成缓存路径
    func cachesDirectories() -> String
    {

        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
        
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    //: 快速生成文档路径
    func docDirectories() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!

        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    //: 快速生成临时路径
    func tmpDirectories() -> String
    {

        let path = NSTemporaryDirectory()
        
        let name = (self as NSString).lastPathComponent
        let filePath = (path as NSString).appendingPathComponent(name)
        
        return filePath
    }
    
    //: 从两个字符串间截取字符串
    func substring(fromString from:String,toString to:String)-> String {
        
        guard let leftRange = self.range(of: from) else {
            return ""
        }
        
        guard let rightRange = self.range(of: to) else {
            return ""
        }
        
        guard rightRange.lowerBound > leftRange.upperBound else {
            return ""
        }
        
        return self.substring(with: leftRange.upperBound..<rightRange.lowerBound)
    }
    
    func substring(fromIndex startIndex:Int,toIndex endIndex:Int) -> String {
        guard endIndex > startIndex else {
            return ""
        }
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end  = self.index(self.startIndex, offsetBy: endIndex)
        
        return self.substring(with: start..<end)
    }
    
    func substring(fromeStartOffset startIndex:Int,fromEndOffset endIndex:Int) -> String {
        guard startIndex > self.lengthOfBytes(using: .utf8) - endIndex else {
            return ""
        }
        
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.endIndex, offsetBy: -endIndex)
        return self.substring(with: start..<end)
    }
}
