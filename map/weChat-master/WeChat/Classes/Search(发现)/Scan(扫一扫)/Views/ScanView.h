//
//  ScanView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/19.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScanTabbarView;


#define CameraScanAreaWidth   ([[UIScreen mainScreen] bounds].size.width - 100)

@protocol ScanViewDelegate <NSObject>
@optional
- (void)scanViewLoadView:(CGRect)rect;
@end

@interface ScanView : UIView 
@property (nonatomic, weak)   id<ScanViewDelegate> delegate;
@property (nonatomic, assign) CGRect innerViewRect;

- (void)addScanTabBarItemWithItemNum:(NSInteger) buttonItemNumber andNameArray:(NSArray *) nameArray andImageNameArray:(NSArray *) imageNameArray;
@end
