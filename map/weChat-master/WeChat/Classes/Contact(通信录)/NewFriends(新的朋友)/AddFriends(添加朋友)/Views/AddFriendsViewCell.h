//
//  AddFriendsViewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingArrowModel;
@interface AddFriendsViewCell : UITableViewCell
@property (nonatomic,strong)SettingArrowModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface SearchFriendsViewCell : UITableViewCell
@property (nonatomic,strong)SettingArrowModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
