//
//  CardsHeadFrameModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "CardsHeadFrameModel.h"
#import "CardsHeadModel.h"
#import "MeFrameConfig.h"

@implementation CardsHeadFrameModel

+ (instancetype)initWithModel:(CardsHeadModel *) model{
    CardsHeadFrameModel *frameModel = [[self alloc] init];
    [frameModel setFrameWithModel:model];
    return frameModel;
}

//设置模型
- (void)setFrameWithModel:(CardsHeadModel *) model{
    _headerFrame = CGRectMake(bPadding_10, bPadding_10, model.cellHeight - bPadding_10*2, model.cellHeight - bPadding_10*2);
    
    CGRect nameFrame = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:NameTitelFontSize} context:nil];
    
    
    nameFrame.origin.x = bPadding_10 + CGRectGetMaxX(_headerFrame);
    nameFrame.origin.y = bPadding_10 + (_headerFrame.size.height - nameFrame.size.height*2 - bPadding_10)*0.5;
    
    _nameFrame = nameFrame;
    
    _genderFrame = CGRectMake(CGRectGetMaxX(nameFrame) + bPadding_10*0.5, nameFrame.origin.y, 18, 18);


}

@end
