//
//  AlbumReflashHeaderIcon.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseReflashView.h"

@interface AlbumReflashHeaderIcon : BaseReflashView

@property (nonatomic, copy) void(^refreshingBlock)();

+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;
@end
