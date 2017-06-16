//
//  CardsNameFieldCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingModel;

@interface CardsNameFieldCell : UITableViewCell

@property (nonatomic,strong)SettingModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
