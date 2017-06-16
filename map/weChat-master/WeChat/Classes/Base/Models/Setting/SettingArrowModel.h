//
//  SettingArrowModel.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingModel.h"

@interface SettingArrowModel : SettingModel
@property (nonatomic,assign)Class destinationClass;

+ (instancetype)settingArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithDestinationClass:(Class) destinationClass;
@end
