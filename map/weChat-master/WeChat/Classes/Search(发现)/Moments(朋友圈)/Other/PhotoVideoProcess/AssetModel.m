//
//  AssetModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/17.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AssetModel.h"

@implementation AssetModel

+ (instancetype)modelWithAsset:(id)asset type:(AssetModelMediaType)type{
    AssetModel *model = [[AssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(AssetModelMediaType)type timeLength:(NSString *)timeLength {
    AssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end

@implementation AlbumModel


@end
