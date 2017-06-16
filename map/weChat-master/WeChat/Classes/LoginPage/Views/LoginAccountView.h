//
//  LoginAccountView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhoneNumberTextField,LoginAccountView;

@protocol LoginAccountViewDelegate <NSObject>

@optional
- (void)LoginAccountViewDidCountrySelect:(LoginAccountView *) view;
- (void)LoginAccountViewDidSMSLogin:(LoginAccountView *)view;

@end

@interface LoginAccountView : UIScrollView

@property (nonatomic,weak)id<LoginAccountViewDelegate > delegate;

@end
