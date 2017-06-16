//
//  SettingTableViewCell.h
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingModel;

@interface SettingTableViewCell : UITableViewCell

@property (nonatomic,strong)SettingModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
