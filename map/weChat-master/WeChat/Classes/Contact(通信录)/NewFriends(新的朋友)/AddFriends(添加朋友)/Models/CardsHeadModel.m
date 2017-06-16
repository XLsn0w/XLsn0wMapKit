//
//  CardsHeadModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "CardsHeadModel.h"
#import "CardsHeadFrameModel.h"

@implementation CardsHeadModel

+ (instancetype)settingCardsHeadModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconImage:(UIImage *)iconImage andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass{
    CardsHeadModel *model = [super settingArrowModelWithTitle:title andWithIconName:nil andWithDestinationClass:destinationClass];
    model.detailTitle = detail;
    model.cellHeight = heigth;
    model.iconImage = iconImage;
    model.modelFrame = [CardsHeadFrameModel initWithModel:model];
    
    return model;
}

@end
