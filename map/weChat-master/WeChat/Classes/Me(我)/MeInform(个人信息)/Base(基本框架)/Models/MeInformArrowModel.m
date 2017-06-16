//
//  MeInformArrowModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeInformArrowModel.h"
#import "MeInformArrowFrameModel.h"
#import "Constant.h"


@implementation MeInformArrowModel

+ (instancetype)settingMeInformArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andCellHeight:(CGFloat) height andWithDestinationClass:(Class) destinationClass{
    MeInformArrowModel *model = [super settingArrowModelWithTitle:title andWithIconName:icon andWithDestinationClass:destinationClass];
  
    model.cellHeight = height;
    
    UIImage *image = [UIImage imageNamed:icon];
    if(height <= bStanderCellHeigh){
         model.modelFrame = [MeInformArrowFrameModel initWithModel:model andWithIconSize:CGSizeMake(image.size.width, image.size.height)];
    }else{
        model.modelFrame = [MeInformArrowFrameModel initWithModel:model andWithIconSize:CGSizeMake(image.size.width*image.scale, image.size.height * image.scale)];
    }
    
    return model;
}
@end
