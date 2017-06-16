//
//  MeArrowModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeArrowModel.h"
#import "MeArrowFrameModel.h"

@implementation MeArrowModel


+ (instancetype)settingMeArrowModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconName:(NSString *)icon andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass{
    MeArrowModel *model = [super settingArrowModelWithTitle:title andWithIconName:icon andWithDestinationClass:destinationClass];
    model.detailTitle = detail;
    model.cellHeight = heigth;
    model.modelFrame = [MeArrowFrameModel initWithModel:model];
    
    return model;
}

+ (instancetype)settingMeArrowModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconImage:(UIImage *)iconImage andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass{
    MeArrowModel *model = [super settingArrowModelWithTitle:title andWithIconName:nil andWithDestinationClass:destinationClass];
    model.detailTitle = detail;
    model.cellHeight = heigth;
    model.iconImage = iconImage;
    model.modelFrame = [MeArrowFrameModel initWithModel:model];
    
    return model;
}
@end
