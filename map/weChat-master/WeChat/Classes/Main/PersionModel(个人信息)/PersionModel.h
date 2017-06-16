//
//  PersionModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersionModel : NSObject

// 个人名片头像
@property (nonatomic,strong)UIImage *headIcon;

// 个人简称
@property (nonatomic,copy)NSString *name;

// 个人昵称
@property (nonatomic,copy)NSString *nickName;

// 微信号
@property (nonatomic,copy)NSString *wechatID;

// 性别
@property (nonatomic,copy)NSString *gender;

// 地区
@property (nonatomic,copy)NSString *address;

// 个性签名
@property (nonatomic,copy)NSString *signature;


+ (instancetype )sharedPersionModel;
- (void)updateLocalDataToServers;
- (void)asyLocalDataFormServers;
@end
