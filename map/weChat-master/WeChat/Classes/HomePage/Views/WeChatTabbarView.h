//
//  WeChatTabbarView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeChatTabbarView;

@protocol WeChatTabbarViewDelegate<NSObject>

@optional
- (void)WeChatTabbarView:(WeChatTabbarView *)tabBarView didSelectedBarButtonItemAtIndex:(NSInteger) index;

@end

typedef void (^WeChatTabbarViewBlock)(NSInteger index);

@interface WeChatTabbarView : UIView
@property (nonatomic,copy)WeChatTabbarViewBlock block;
@property (nonatomic,weak) id<WeChatTabbarViewDelegate> delegate;

- (void)addBarButtonItemsWithImageName:(NSString *)imageName selcetedImageName:(NSString *) selectedImageName titleText:(NSString *) titleText;
@end
