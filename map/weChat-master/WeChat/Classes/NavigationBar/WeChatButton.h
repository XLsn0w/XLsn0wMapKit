//
//  TarBarButton.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/8.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatButton : UIButton

//按比例缩放图片
- (void)setImageViewscaleSize:(CGFloat)scale newPostion:(CGPoint) postion withBackGroudColor:(UIColor *)color;

- (void)setImageViewsWithScaleWidth:(CGFloat) scaleWidth andScaleHeight:(CGFloat)scaleHeight newPostion:(CGPoint) postion withBackGroudColor:(UIColor *)color;
- (void)setTitleViewRect:(CGRect) rect;
@end
