//
//  FriendsCardViewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseGroupTableViewController.h"
@class XMPPvCardTemp;

@interface FriendsCardViewController : BaseGroupTableViewController

+ (instancetype)friendsCardViewControllerWithCard:(XMPPvCardTemp *)card;
@end
