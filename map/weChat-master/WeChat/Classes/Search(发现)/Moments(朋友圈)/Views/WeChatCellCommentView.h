//
//  WeChatCellCommentView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatCellCommentView : UIView
@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);

- (NSInteger)setupWithLikeItems:(NSArray *)likeItems commentItemsArray:(NSArray *)commentItems;

@end
