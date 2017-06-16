//
//  Date+Extension.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/13.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit


extension Date {
    func createDate(withDateString date:String,withDateFormatter formatter:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        //: 指定转换默认语言格式，注意：不指定真机无法转换
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter.date(from: date)
    }
    
}
