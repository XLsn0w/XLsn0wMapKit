//
//  PhotoPreviewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AssetModel;
@interface PhotoPreviewCell : UICollectionViewCell
@property (nonatomic, strong) AssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();
@end
