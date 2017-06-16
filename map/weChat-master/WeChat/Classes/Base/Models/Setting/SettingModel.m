//
//  SettingModel.m
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel

- (instancetype)init{
    self = [super init];
    if(self){
       self.cellHeight = 40;
    }
    return self;
}

+ (instancetype)settingModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon{
    //如果子类也调用该方法创建对象最好用self,便于后面知道该对象的真实类型
    SettingModel *model = [[self alloc] init];
    model.title = title;
    model.icon = icon;
    
    return model;
}

@end
