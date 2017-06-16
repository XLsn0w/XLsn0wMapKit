//
//  CardsHeadFrameModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CardsHeadModel;

@interface CardsHeadFrameModel : NSObject
@property (nonatomic,assign,readonly)CGRect headerFrame;
@property (nonatomic,assign,readonly)CGRect nameFrame;
@property (nonatomic,assign,readonly)CGRect genderFrame;

+ (instancetype)initWithModel:(CardsHeadModel *) model;
@end
