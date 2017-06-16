//
//  RegisterAccountTabbarView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegisterAccountTabbarView;

@protocol RegisterAccountTabbarViewDelegate <NSObject>

@optional
- (void)registerAccountTabbarViewDidSelectAllowMent:(RegisterAccountTabbarView *) view;

@end

@interface RegisterAccountTabbarView : UIView
@property (nonatomic,weak)id<RegisterAccountTabbarViewDelegate> delegate;

@end
