//
//  UIView+Observer.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/13.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Observer)<UIScrollViewDelegate>
@property (nonatomic,assign)BOOL scorllObserveState;
@property (nonatomic,strong)UIScrollView *scrollView;
@end
