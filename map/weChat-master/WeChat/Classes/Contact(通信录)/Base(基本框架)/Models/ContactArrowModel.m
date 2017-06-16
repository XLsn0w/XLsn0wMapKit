//
//  ContactArrowModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ContactArrowModel.h"

@implementation ContactArrowModel

+ (instancetype)settingContactArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andWithDestinationClass:(Class)destinationClass{
     ContactArrowModel *model = [super settingArrowModelWithTitle:title andWithIconName:icon andWithDestinationClass:destinationClass];
    
    model.cellHeight = 50;
    return model;
}
@end
