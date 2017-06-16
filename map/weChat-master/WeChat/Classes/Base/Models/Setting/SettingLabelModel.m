//
//  SettingLabelModel.m
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/11.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingLabelModel.h"

@implementation SettingLabelModel

+ (instancetype)settingLabelModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithLableText:(NSString *) text{
    SettingLabelModel *model = [super settingModelWithTitle:title andWithIconName:icon];
    model.text = text;
    
    return model;
}
@end
