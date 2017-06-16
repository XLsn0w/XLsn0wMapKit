//
//  Retweeted_Status.swift
//  椰海雅客微博
//
//  Created by sunshine.lee on 2017/04/11.
//  Copyright © 2017年 sunshine.lee. All rights reserved.
//


import  UIKit

class Retweeted_Status:NSObject {

    //:  biz_feature,Int.
    var biz_feature : Int = 0

    //:  Optional("in_reply_to_status_id"),Optional("String").
    var in_reply_to_status_id : String?

    //:  Optional("source"),Optional("String").
    var source : String?

    //:  reposts_count,Int.
    var reposts_count : Int = 0

    //:  source_allowclick,Int.
    var source_allowclick : Int = 0

    //:  Optional("idstr"),Optional("String").
    var idstr : String?

    //:  attitudes_count,Int.
    var attitudes_count : Int = 0

    //:  positive_recom_flag,Int.
    var positive_recom_flag : Int = 0

    //:  comments_count,Int.
    var comments_count : Int = 0

    //:  favorited,Bool.
    var favorited : Bool = false

    //:  Optional("in_reply_to_screen_name"),Optional("String").
    var in_reply_to_screen_name : String?

    //:  id,Int.
    var id : Int = 0

    //:  Optional("text"),Optional("String").
    var text : String?

    //:  is_show_bulletin,Int.
    var is_show_bulletin : Int = 0

    //:  hasActionTypeCard,Int.
    var hasActionTypeCard : Int = 0

    //:  isLongText,Bool.
    var isLongText : Bool = false

    //:  Optional("geo"),Optional("Any").
    var geo : Any?

    //:  Optional("in_reply_to_user_id"),Optional("String").
    var in_reply_to_user_id : String?

    //:  textLength,Int.
    var textLength : Int = 0

    //:  Optional("user"),Optional("Dictionary").
    var user : User?

    //:  Optional("biz_ids"),Optional("Array").
    var biz_ids : Array<Int>?

    //:  Optional("mid"),Optional("String").
    var mid : String?

    //:  source_type,Int.
    var source_type : Int = 0

    //:  Optional("gif_ids"),Optional("String").
    var gif_ids : String?

    //:  Optional("hot_weibo_tags"),Optional("Array").
    var hot_weibo_tags : Array<Hot_Weibo_Tags>?

    //:  userType,Int.
    var userType : Int = 0

    //:  mlevel,Int.
    var mlevel : Int = 0

    //:  Optional("created_at"),Optional("String").
    var created_at : String?

    //:  Optional("text_tag_tips"),Optional("Array").
    var text_tag_tips : Array<AnyObject>?

    //:  truncated,Bool.
    var truncated : Bool = false

    //:  Optional("darwin_tags"),Optional("Array").
    var darwin_tags : Array<Darwin_Tags>?

    //:  Optional("visible"),Optional("Dictionary").
    var visible : Visible?

    //:  Optional("pic_urls"),Optional("Array").
    var pic_urls : Array<Pic_Urls>?

}
