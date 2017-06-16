//
//  CardsHeadModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SettingArrowModel.h"
@class CardsHeadFrameModel;

@interface CardsHeadModel : SettingArrowModel

@property (nonatomic,strong)CardsHeadFrameModel *modelFrame;
@property (nonatomic, copy)NSString *genderIcon;

+ (instancetype)settingCardsHeadModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconImage:(UIImage *)iconImage andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass;
@end
