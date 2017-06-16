//
//  LoginedView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginedView,AccountTextField;

@protocol LoginedViewDelegate <NSObject>

@optional
- (void)loginedViewDidLogin:(LoginedView *) view;
- (void)loginedViewDidMoreButton:(LoginedView *) view;
- (void)loginedViewDidLoginHelp:(LoginedView *)view;
@end

@interface LoginedView : UIScrollView
@property (nonatomic,strong)AccountTextField *passwordInput;
@property (nonatomic,weak)id<LoginedViewDelegate> delegate;
@end
