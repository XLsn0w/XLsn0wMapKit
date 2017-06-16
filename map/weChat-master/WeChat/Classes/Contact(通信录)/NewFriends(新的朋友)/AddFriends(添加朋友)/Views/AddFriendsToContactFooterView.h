//
//  AddFriendsToContactFooterView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMPPvCardTemp;

@protocol AddFriendsToContactFooterViewProtocal <NSObject>

@optional

- (void)addFriendsToContactDidAdd;

@end

@interface AddFriendsToContactFooterView : UIView

@property (nonatomic,weak)id<AddFriendsToContactFooterViewProtocal> protocal;

@end
