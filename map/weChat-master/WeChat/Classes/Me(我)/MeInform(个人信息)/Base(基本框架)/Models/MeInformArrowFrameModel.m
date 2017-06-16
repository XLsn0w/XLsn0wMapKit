//
//  MeInformArrowFrameModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeInformArrowFrameModel.h"
#import "MeInformArrowModel.h"
#import "MeFrameConfig.h"
#import "Constant.h"

@implementation MeInformArrowFrameModel

+ (instancetype)initWithModel:(MeInformArrowModel *) model andWithIconSize:(CGSize) size{
  
    MeInformArrowFrameModel *frameModel = [[self alloc] init];
    [frameModel setFrameWithModel:model andWithIconSize:size];
    return frameModel;
}

- (void)setIconFrame:(CGRect)iconFrame{
    _iconFrame = iconFrame;
}

//设置模型
- (void)setFrameWithModel:(MeInformArrowModel *) model andWithIconSize:(CGSize) size{
    
    if(model.icon.length){
        _iconFrame = CGRectMake(bPadding_15, (model.cellHeight - size.height)*0.5, size.width, size.height);
    }
    CGRect textFrame = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CellTitelFontSize} context:nil];
   
    if(model.icon.length){
        textFrame.origin.x = bPadding_15 + CGRectGetMaxX(_iconFrame);
        
    }else{
        textFrame.origin.x = bPadding_15;
    }
    textFrame.origin.y = (model.cellHeight - textFrame.size.height)*0.5;
    
    _textFrame = textFrame;
    
    CGFloat rightViewHeight = model.cellHeight - bPadding_10*2;
    CGFloat rightViewWidth = rightViewHeight;
    
 
    if(model.rightItemsType == RightItemsTypeImage){
        _rightItemFrame =  CGRectMake(bScreenWidth - bPadding_10 - rightViewWidth, (model.cellHeight - rightViewHeight)*0.5,rightViewWidth ,rightViewHeight);
    }else{
        _rightItemFrame =  CGRectMake(bScreenWidth - bPadding_15, 0,0,model.cellHeight);
    }
}

@end
