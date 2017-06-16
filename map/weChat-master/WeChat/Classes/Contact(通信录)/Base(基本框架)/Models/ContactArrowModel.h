//
//  ContactArrowModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SettingArrowModel.h"

@interface ContactArrowModel : SettingArrowModel

+ (instancetype)settingContactArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithDestinationClass:(Class)destinationClass;
@end
