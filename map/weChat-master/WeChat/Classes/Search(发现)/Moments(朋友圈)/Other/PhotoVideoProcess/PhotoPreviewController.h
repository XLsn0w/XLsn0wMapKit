//
//  PhotoPreviewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPreviewController : UIViewController
///< All photos / 所有图片的数组
@property (nonatomic, strong) NSArray *photoArr;

///< Current selected photos / 当前选中的图片数组
@property (nonatomic, strong) NSMutableArray *selectedPhotoArr;

///< Index of the photo user click / 用户点击的图片的索引
@property (nonatomic, assign) NSInteger currentIndex;

///< If YES,return original photo / 是否返回原图
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

/// Return the new selected photos / 返回最新的选中图片数组
@property (nonatomic, copy) void (^returnNewSelectedPhotoArrBlock)(NSMutableArray *newSeletedPhotoArr, BOOL isSelectOriginalPhoto);

@property (nonatomic, copy) void (^okButtonClickBlock)(NSMutableArray *newSeletedPhotoArr, BOOL isSelectOriginalPhoto);

@end
