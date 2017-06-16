//
//  MeInformArrowModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SettingArrowModel.h"
@class MeInformArrowFrameModel;

typedef enum{
    RightItemsTypeImage = 0,
    RightItemsTypeViews = 1,
}RightItemsType;

@interface MeInformArrowModel : SettingArrowModel
@property (nonatomic,strong)MeInformArrowFrameModel *modelFrame;
//右边视图
@property (nonatomic,strong)NSArray *rightItemImages;
//右边视图间距
@property (nonatomic,assign)CGFloat rightItemPadding;

@property (nonatomic,assign)RightItemsType rightItemsType;

+ (instancetype)settingMeInformArrowModelWithTitle:(NSString *)title andWithIconName:(NSString *)icon andCellHeight:(CGFloat) heigth andWithDestinationClass:(Class) destinationClass;
@end
