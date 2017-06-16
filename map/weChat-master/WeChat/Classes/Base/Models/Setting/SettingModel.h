//
//  SettingModel.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SettingModel;

typedef void(^SettingModelOptionBlock) (SettingModel *model);
@interface SettingModel : NSObject
@property (nonatomic,copy)NSString *title;
//头像
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,strong)UIImage *iconImage;

@property (nonatomic,copy)NSString *detailTitle;

@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,copy)SettingModelOptionBlock option;
@property (nonatomic,assign)BOOL responder;

+ (instancetype)settingModelWithTitle:(NSString *)title andWithIconName:(NSString *) icon;
@end
