//
//  OtherWayLoginAccountView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OtherWayLoginAccountView,AccountTextField;

@protocol OtherLoginAccountViewDelegate <NSObject>

@optional
- (void)otherWayLoginAccountViewDidLogin:(OtherWayLoginAccountView *) view;
- (void)otherWayLoginAccountViewDidLoginHelp:(OtherWayLoginAccountView *)view;

@end

@interface OtherWayLoginAccountView : UIScrollView
@property (nonatomic,strong)AccountTextField *accountInput;
@property (nonatomic,strong)AccountTextField *passwordInput;

@property (nonatomic,weak)id<OtherLoginAccountViewDelegate> delegate;

@end
