//
//  RegisterAccountView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneNumberTextField,RegisterAccountView;

@protocol RegisterAccountViewDelegate <NSObject>

@optional
- (void)registerAccountViewDidCountrySelect:(RegisterAccountView *) view;
- (void)registerAccountViewDidRegister:(RegisterAccountView *) view;

@end

@interface RegisterAccountView : UIScrollView
@property (nonatomic,strong) PhoneNumberTextField *phoneInput;

@property (nonatomic,weak)id<RegisterAccountViewDelegate> delegate;

@end
