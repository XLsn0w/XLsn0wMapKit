//
//  MyAdderssViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/10.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MyAdderssViewController.h"

@interface MyAdderssViewController ()

@end

@implementation MyAdderssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMyAddressView];
}

- (void)setMyAddressView{
    
    SettingModel *newAddr = [SettingArrowModel settingArrowModelWithTitle:@"新增地址" andWithIconName:@"createNewTagIcon" andWithDestinationClass:nil];
    
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[newAddr];
    [self.groupItems addObject:itemGroup0];
    
     [self.navigationItem setTitle:@"我的地址"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
