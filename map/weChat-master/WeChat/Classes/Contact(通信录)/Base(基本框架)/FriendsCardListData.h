//
//  FriendsCardListData.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/2/1.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsCardListData : NSObject

#pragma mark - 好友列表
///好友数据(原始数据)
@property (nonatomic, strong) NSMutableArray *friendsData;

///格式化的好友数据
@property (nonatomic, strong) NSMutableArray *data;

/// 格式化好友数据的分组标题
@property (nonatomic, strong) NSMutableArray *sectionHeaders;

/// 好友数量
@property (nonatomic, assign, readonly) NSInteger friendCount;


@property (nonatomic, strong) void(^dataChangedBlock)(NSMutableArray *friends,NSMutableArray *headers,NSInteger friendCount);
/// 群数据
@property (nonatomic, strong) NSMutableArray *groupsData;

/// 标签数据
@property (nonatomic, strong) NSMutableArray *tagsData;

+ (instancetype)sharedFriendsCardListData;
- (void)loadFriendsCardList;
@end
