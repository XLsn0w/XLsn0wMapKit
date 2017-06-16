//
//  GenderSelectedTableViewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/10.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GenderSelectedTableViewControllerProtocol <NSObject>

@optional
- (void)genderSelectedTableViewdidSelectedCell;

@end
@interface GenderSelectedTableViewController : UITableViewController

@property(nonatomic,weak)id<GenderSelectedTableViewControllerProtocol> delegate;

@end
