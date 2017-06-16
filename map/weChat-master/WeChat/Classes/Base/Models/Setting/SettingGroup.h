//
//  SettingGroup.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject

@property (nonatomic,copy)NSString *headerTitle;
@property (nonatomic,copy)NSString *footerTitle;

@property (nonatomic,strong)UIView *footerView;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)NSArray *items;

@end
