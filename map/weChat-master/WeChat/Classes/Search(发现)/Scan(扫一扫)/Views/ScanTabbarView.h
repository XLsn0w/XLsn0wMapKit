//
//  ScanTabbarView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanTabbarView;

@protocol ScanTabbarViewDelegate<NSObject>

@optional
- (void)scanTabbarView:(ScanTabbarView *)tabBarView didSelectedScanBarButtonItemAtIndex:(NSInteger) index;

@end

typedef void (^ScanTabbarViewBlock)(NSInteger index);

@interface ScanTabbarView : UIView
@property (nonatomic,copy)ScanTabbarViewBlock block;
@property (nonatomic,weak) id<ScanTabbarViewDelegate> delegate;

- (void)addScanBarButtonItemsWithImageName:(NSString *)imageName selcetedImageName:(NSString *) selectedImageName titleText:(NSString *) titleText;
@end
