//
//  User.swift
//  椰海雅客微博
//
//  Created by sunshine.lee on 2017/04/11.
//  Copyright © 2017年 sunshine.lee. All rights reserved.
//


import  UIKit

class User:NSObject {

    //:  Optional("lang"),Optional("String").
    var lang : String?

    //:  Optional("cover_image"),Optional("String").
    var cover_image : String?

    //:  Optional("verified_reason_url"),Optional("String").
    var verified_reason_url : String?

    //:  Optional("province"),Optional("String").
    var province : String?

    //:  bi_followers_count,Int.
    var bi_followers_count : Int = 0

    //:  friends_count,Int.
    var friends_count : Int = 0

    //:  Optional("verified_reason_modified"),Optional("String").
    var verified_reason_modified : String?

    //:  Optional("verified_source_url"),Optional("String").
    var verified_source_url : String?

    //:  id,Int.
    var id : Int = 0

    //:  allow_all_comment,Bool.
    var allow_all_comment : Bool = false

    //:  pagefriends_count,Int.
    var pagefriends_count : Int = 0

    //:  urank,Int.
    var urank : Int = 0

    //:  Optional("profile_image_url"),Optional("String").
    var profile_image_url : String?

    //:  following,Bool.
    var following : Bool = false

    //:  Optional("url"),Optional("String").
    var url : String?

    //:  Optional("city"),Optional("String").
    var city : String?

    //:  Optional("verified_contact_email"),Optional("String").
    var verified_contact_email : String?

    //:  star,Int.
    var star : Int = 0

    //:  geo_enabled,Bool.
    var geo_enabled : Bool = false

    //:  Optional("screen_name"),Optional("String").
    var screen_name : String?

    //:  Optional("description"),Optional("String").
    var Pref_description : String?

    //:  verified_state,Int.
    var verified_state : Int = 0

    //:  followers_count,Int.
    var followers_count : Int = 0

    //:  mbtype,Int.
    var mbtype : Int = 0

    //:  verified_type_ext,Int.
    var verified_type_ext : Int = 0

    //:  Optional("created_at"),Optional("String").
    var created_at : String?

    //:  Optional("remark"),Optional("String").
    var remark : String?

    //:  block_app,Int.
    var block_app : Int = 0

    //:  has_service_tel,Bool.
    var has_service_tel : Bool = false

    //:  Optional("domain"),Optional("String").
    var domain : String?

    //:  Pref_class,Int.Noteice you are using system keywords,Now the property name [Pref_class] is add Preffix [Pref_] from origin name [Optional("class")].
    var Pref_class : Int = 0

    //:  favourites_count,Int.
    var favourites_count : Int = 0

    //:  ptype,Int.
    var ptype : Int = 0

    //:  credit_score,Int.
    var credit_score : Int = 0

    //:  Optional("cover_image_phone"),Optional("String").
    var cover_image_phone : String?

    //:  Optional("idstr"),Optional("String").
    var idstr : String?

    //:  user_ability,Int.
    var user_ability : Int = 0

    //:  Optional("profile_url"),Optional("String").
    var profile_url : String?

    //:  Optional("weihao"),Optional("String").
    var weihao : String?

    //:  follow_me,Bool.
    var follow_me : Bool = false

    //:  statuses_count,Int.
    var statuses_count : Int = 0

    //:  verified_level,Int.
    var verified_level : Int = 0

    //:  Optional("name"),Optional("String").
    var name : String?

    //:  allow_all_act_msg,Bool.
    var allow_all_act_msg : Bool = false

    //:  Optional("insecurity"),Optional("Dictionary").
    var insecurity : Insecurity?

    //:  verified_type,Int.
    var verified_type : Int = 0

    //:  Optional("verified_contact_name"),Optional("String").
    var verified_contact_name : String?

    //:  block_word,Int.
    var block_word : Int = 0

    //:  Optional("verified_reason"),Optional("String").
    var verified_reason : String?

    //:  Optional("avatar_hd"),Optional("String").
    var avatar_hd : String?

    //:  Optional("gender"),Optional("String").
    var gender : String?

    //:  online_status,Int.
    var online_status : Int = 0

    //:  verified,Bool.
    var verified : Bool = false

    //:  Optional("verified_contact_mobile"),Optional("String").
    var verified_contact_mobile : String?

    //:  Optional("location"),Optional("String").
    var location : String?

    //:  Optional("verified_trade"),Optional("String").
    var verified_trade : String?

    //:  Optional("verified_source"),Optional("String").
    var verified_source : String?

    //:  mbrank,Int.
    var mbrank : Int = 0

    //:  Optional("avatar_large"),Optional("String").
    var avatar_large : String?

}
