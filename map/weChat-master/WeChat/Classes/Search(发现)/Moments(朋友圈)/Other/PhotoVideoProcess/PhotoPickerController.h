//
//  PhotoPickerController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/17.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoPickterController;

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

@protocol PhotoPickerControllerDelegate <NSObject>

@optional
// 如果用户没有选择发送原图,Assets将是空数组
- (void)imagePickerController:(PhotoPickterController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets;

- (void)imagePickerController:(PhotoPickterController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos;

- (void)imagePickerControllerDidCancel:(PhotoPickterController *)picker;

// 如果用户选择了一个视频，下面的handle会被执行
- (void)imagePickerController:(PhotoPickterController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset;

@end

@interface PhotoPickerController : UINavigationController

// 默认最大可选9张图片
@property (nonatomic, assign) NSInteger maxImagesCount;

// 默认为YES，如果设置为NO,原图按钮将隐藏，用户不能选择发送原图
@property (nonatomic, assign) BOOL allowPickingOriginalPhoto;

// 默认为YES，如果设置为NO,用户将不能选择发送视频
@property (nonatomic, assign) BOOL allowPickingVideo;

- (void)showAlertWithTitle:(NSString *)title;

@property (nonatomic, strong) UIColor *OkButtonTitleColorNormal;
@property (nonatomic, strong) UIColor *OkButtonTitleColorDisabled;

// 初始化方法
- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<PhotoPickerControllerDelegate>)delegate;

// 如果用户没有选择发送原图,第二个数组将是空数组
@property (nonatomic, copy) void (^didFinishPickingPhotosHandle)(NSArray<UIImage *> *photos,NSArray *assets);

@property (nonatomic, copy) void (^didFinishPickingPhotosWithInfosHandle)(NSArray<UIImage *> *photos,NSArray *assets,NSArray<NSDictionary *> *infos);

@property (nonatomic, copy) void (^imagePickerControllerDidCancelHandle)();

// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
@property (nonatomic, copy) void (^didFinishPickingVideoHandle)(UIImage *coverImage,id asset);

@property (nonatomic, weak) id<PhotoPickerControllerDelegate> pickerDelegate;

@end

@interface AlbumPickerController : UIViewController

@end
