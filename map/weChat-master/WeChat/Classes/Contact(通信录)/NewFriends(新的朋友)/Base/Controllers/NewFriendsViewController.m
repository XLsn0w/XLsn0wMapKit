//
//  NewFriendsViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "NewFriendsViewController.h"
#import "AddPhoneContactMode.h"
#import "AddPhoneContactCell.h"
#import "AddFriendsViewController.h"


@interface NewFriendsViewController ()

@end

@implementation NewFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTableViewSearchBar];
    [self setupNewFriendsView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加朋友" style:UIBarButtonItemStylePlain target:self action:@selector(addNewFriends)];
}

- (void)setupNewFriendsView{
   SettingModel *addPhoneContact = [AddPhoneContactMode settingModelWithTitle:nil andWithIconName:nil];
    ((AddPhoneContactMode *)addPhoneContact).cellText = @"添加手机联系人";
    ((AddPhoneContactMode *)addPhoneContact).middleIcon = [UIImage imageNamed:@"NewFriend_Contacts_icon"];
    addPhoneContact.cellHeight = 80;
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[addPhoneContact];
    
     [self.groupItems addObject:itemGroup0];
}

- (void)setTableViewSearchBar{
    
    [self searchTableViewCustomerTextFieldWithBorderColor:nil andTextFieldStyle:UISearchTextFieldDefault];
    
    [self setSearchBarDelegate:self];
    
    [self searchTableViewHidesNavigationBarDuringPresentation:YES];
    
    [self searchTableViewCancelButtonWithName:@"取消"];
    //设置光标颜色
    [self searchTableViewTextFieldCursorWithColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
    
    [self searchTableViewTextFieldRightButtonNormalImageWithName:nil andHighledImageName:nil andButtonStyle:UISearchTextFieldRightButtonCustomer andPlaceHolder:@"微信号/手机号"];
    
    //    [self searchTableViewClearButton];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    SettingGroup *group = self.groupItems[indexPath.section];
    //类名创建控制器
    if(!indexPath.section){
        cell = [[AddPhoneContactCell class] cellWithTableView:tableView];
        
        AddPhoneContactMode *model =(AddPhoneContactMode *)group.items[indexPath.row];
        [(AddPhoneContactCell *)cell setModel:model];
        
    }else{
        [super tableView:tableView cellForRowAtIndexPath:indexPath];
        
    }
    return cell;
}

- (void)addNewFriends{
    AddFriendsViewController * controller = [[AddFriendsViewController alloc] init];
    controller.title = @"添加朋友" ;
    
    [self.navigationController pushViewController:controller animated:YES ];}

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
