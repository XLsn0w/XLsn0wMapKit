//
//  SettingLabelModel.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/11.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingModel.h"

@interface SettingLabelModel : SettingModel
@property (nonatomic,copy)NSString *text;

+ (instancetype)settingLabelModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithLableText:(NSString *) text;
@end
