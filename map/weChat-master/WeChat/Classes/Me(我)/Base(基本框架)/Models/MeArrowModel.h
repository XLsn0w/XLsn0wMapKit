//
//  MeArrowModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SettingArrowModel.h"
@class MeArrowFrameModel;



@interface MeArrowModel : SettingArrowModel

@property (nonatomic,strong)MeArrowFrameModel *modelFrame;

+ (instancetype)settingMeArrowModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconName:(NSString *)icon andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass;

+ (instancetype)settingMeArrowModelWithTitle:(NSString *)title andWithDetailTitel:(NSString *) detail andWithIconImage:(UIImage *)iconImage andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass;
@end
