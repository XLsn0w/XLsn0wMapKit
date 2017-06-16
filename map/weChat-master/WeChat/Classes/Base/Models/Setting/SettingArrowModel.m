//
//  SettingArrowModel.m
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingArrowModel.h"

@implementation SettingArrowModel

+ (instancetype)settingArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithDestinationClass:(Class)destinationClass{
    SettingArrowModel *model = [super settingModelWithTitle:title andWithIconName:icon];
    model.destinationClass = destinationClass;

    return model;
}


@end
