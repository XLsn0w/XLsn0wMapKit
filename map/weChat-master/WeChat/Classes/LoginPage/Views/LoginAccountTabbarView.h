//
//  LoginAccountTabbarView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginAccountTabbarView;

@protocol LoginAccountTabbarViewDelegate <NSObject>

@optional
- (void)loginAccountTabbarViewDidOtherWayLogin:(LoginAccountTabbarView *) view;

@end

@interface LoginAccountTabbarView : UIView
@property (nonatomic,weak)id<LoginAccountTabbarViewDelegate> delegate;
@end
