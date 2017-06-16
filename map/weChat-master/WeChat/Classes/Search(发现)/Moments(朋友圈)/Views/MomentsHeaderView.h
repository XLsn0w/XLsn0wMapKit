//
//  MomentsHeaderView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TopViewOnHeaderViewHeight     500
#define AllImageViewHeight            300
@interface MomentsHeaderView : UIView
@property (nonatomic,copy) void(^iconImageClick)();
@property (nonatomic,copy) void(^backGroudImageClick)();

@end
