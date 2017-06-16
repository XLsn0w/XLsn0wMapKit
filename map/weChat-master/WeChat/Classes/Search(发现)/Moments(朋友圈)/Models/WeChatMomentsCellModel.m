//
//  WeChatMomentsCellModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatMomentsCellModel.h"
#import <UIKit/UIKit.h>

extern CGFloat maxContentLabelHeight;

@interface WeChatMomentsCellModel (){
    CGFloat _lastContentWidth;
}

@end

@implementation WeChatMomentsCellModel

@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : ContentFontSize} context:nil];
        
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!self.shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}


@end

#pragma mark - CellLikeItemModel --------------------------------------------------------------------------

@implementation CellLikeItemModel


@end

#pragma mark - CellLikeItemModel --------------------------------------------------------------------------

@implementation CellCommentItemModel


@end

