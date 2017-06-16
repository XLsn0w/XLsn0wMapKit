//
//  AssetModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/17.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AssetModelMediaTypePhoto = 0,
    AssetModelMediaTypeLivePhoto,
    AssetModelMediaTypeVideo,
    AssetModelMediaTypeAudio
}AssetModelMediaType;

@class PHAsset;
@interface AssetModel : NSObject

@property (nonatomic, strong) id asset;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) AssetModelMediaType type;

@property (nonatomic, copy) NSString *timeLength;


// 初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(AssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(AssetModelMediaType)type timeLength:(NSString *)timeLength;

@end

@class PHFetchResult;
@interface AlbumModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) id result;             

@end



