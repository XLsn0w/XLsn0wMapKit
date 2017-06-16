//
//  BaseGroupTableViewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"
#import "SettingArrowModel.h"
#import "SettingSwitchModel.h"
#import "SettingLabelModel.h"
#import "SettingGroup.h"
#import "SettingTableViewCell.h"
#import "MeTableViewCell.h"
@class BaseGroupTableViewController;

@protocol BaseGroupTableViewControllerDelegate <NSObject>

@optional
- (void)baseGroupTableviewWillAppear:(BaseGroupTableViewController *) controller;
- (void)baseGroupTableviewDidAppear:(BaseGroupTableViewController *) controller;


@end

@interface BaseGroupTableViewController : UITableViewController
@property (nonatomic ,strong)id<BaseGroupTableViewControllerDelegate> delegate;
//主框架分组信息列表
@property (nonatomic ,strong)NSMutableArray *groupItems;
//cell数据列表
@property (nonatomic,strong)NSMutableArray *datalist;
//cell 选中的indexpath
@property (nonatomic, strong) NSIndexPath *lastIndexPath;
@end
