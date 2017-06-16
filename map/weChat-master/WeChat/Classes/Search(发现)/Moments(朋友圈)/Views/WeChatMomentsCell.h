//
//  WeChatMomentsCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeChatMomentsCellModel,WeChatMomentsCell;


@protocol WeChatMomentCellDelegate <NSObject>

@optional
//点击 点赞按钮与评论按钮代理方法
- (void)didClickLikeButtonInCell:(WeChatMomentsCell *)cell;
- (void)didClickcCommentButtonInCell:(WeChatMomentsCell *)cell;

@end

@interface WeChatMomentsCell : UITableViewCell

@property (nonatomic, strong) WeChatMomentsCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,weak) id<WeChatMomentCellDelegate> delegate;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);

@end
