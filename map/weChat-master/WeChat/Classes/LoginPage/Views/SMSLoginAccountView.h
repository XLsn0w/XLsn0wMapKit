//
//  SMSLoginAccountView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhoneNumberTextField,SMSLoginAccountView;

@protocol SMSLoginAccountViewDelegate <NSObject>

@optional
- (void)SMSLoginAccountViewDidCountrySelect:(SMSLoginAccountView *) view;

@end

@interface SMSLoginAccountView : UIScrollView
@property (nonatomic,weak)id<SMSLoginAccountViewDelegate> delegate;
@end
