//
//  ScanViewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanViewController;

@protocol ScanQRCodeReaderDelegate <NSObject>

@optional

// 读取结果
- (void)reader:(ScanViewController *)reader didScanResult:(NSString *)result;

// 取消扫描
- (void)readerDidCancel:(ScanViewController *)reader;

@end

@interface ScanViewController : UIViewController

@property (nonatomic, weak) id<ScanQRCodeReaderDelegate>  delegate;

// 检测设备是否就绪
+ (BOOL)isAvailable;
// 设置扫描出结果后的用户执行方法
- (void)setCompletionWithBlock:(void (^) (NSString *resultAsString))completionBlock;
@end
