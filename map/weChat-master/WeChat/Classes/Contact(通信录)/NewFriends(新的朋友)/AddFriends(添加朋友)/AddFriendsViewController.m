//
//  AddFriendsViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddFriendsViewCell.h"
#import "SearchFriendsFooterView.h"
#import "SearchResultViewController.h"
#import "SearchFriendsViewController.h"



@interface AddFriendsViewController ()<UISearchBarDelegate,UIBarPositioningDelegate>


@end

@implementation AddFriendsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAddFriendsView];
    // Do any additional setup after loading the view.
}

- (void)setupAddFriendsView{
    PersionModel *data = [PersionModel sharedPersionModel];
    SettingModel *search = [SettingArrowModel settingArrowModelWithTitle:@"" andWithIconName:@"add_friend_searchicon" andWithDestinationClass:nil];
    search.detailTitle = @"微信号/手机号";
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    SearchFriendsFooterView * footerView = [[SearchFriendsFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    
    [footerView.title setText:[NSString stringWithFormat:@"我的微信号：%@",data.wechatID]];
    
    [footerView.icon setImage:[UIImage imageNamed:@"add_friend_myQR"]];
    
    itemGroup0.footerView = footerView;
    itemGroup0.items =@[search];
    [self.groupItems addObject:itemGroup0];
    
    [self.tableView setSectionFooterHeight:40];

    
    SettingModel *reda = [SettingArrowModel settingArrowModelWithTitle:@"雷达加朋友" andWithIconName:@"add_friend_icon_reda" andWithDestinationClass:nil];
    reda.detailTitle = @"添加身边的朋友";
    reda.cellHeight = 60;
    
    SettingModel *addGroup = [SettingArrowModel settingArrowModelWithTitle:@"面对面建群" andWithIconName:@"add_friend_icon_addgroup" andWithDestinationClass:nil];
    addGroup.detailTitle = @"与身边的朋友进入同一个群聊";
    addGroup.cellHeight = 60;
    
    SettingModel *scanQR = [SettingArrowModel settingArrowModelWithTitle:@"扫一扫" andWithIconName:@"add_friend_icon_scanqr" andWithDestinationClass:nil];
    scanQR.detailTitle = @"扫描二维码名片";
    scanQR.cellHeight = 60;
    
    SettingModel *contacts = [SettingArrowModel settingArrowModelWithTitle:@"手机联系人" andWithIconName:@"add_friend_icon_contacts" andWithDestinationClass:nil];
    contacts.detailTitle = @"添加通讯录中的朋友";
    contacts.cellHeight = 60;
    
    SettingModel *offical = [SettingArrowModel settingArrowModelWithTitle:@"公众号" andWithIconName:@"add_friend_icon_offical" andWithDestinationClass:nil];
    offical.detailTitle = @"获取更多的资讯和服务";
    offical.cellHeight = 60;
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[reda,addGroup,scanQR,contacts,offical];
    [self.groupItems addObject:itemGroup1];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SettingGroup *group = self.groupItems[section];

    return group.footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section){
        AddFriendsViewCell *cell = [[AddFriendsViewCell class] cellWithTableView:tableView];
        
        SettingGroup *group = self.groupItems[indexPath.section];
        SettingArrowModel *model = group.items[indexPath.row];
        [cell  setModel:model];
           return cell;
    }else{
        SearchFriendsViewCell *cell = [[SearchFriendsViewCell class] cellWithTableView:tableView];
        
        SettingGroup *group = self.groupItems[indexPath.section];
        SettingArrowModel *model = group.items[indexPath.row];
        [cell  setModel:model];
            return cell;
    }
}


//选中的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //记录选中的indexpath
    if(![self.lastIndexPath isEqual:indexPath]){
        self.lastIndexPath = indexPath;
    }
    
    if(!indexPath.section){
   
         SearchResultViewController *resultController = [[SearchResultViewController alloc] init];
    
         SearchFriendsViewController *controller = [[SearchFriendsViewController alloc] initWithRootViewController:resultController];
        
        [self presentViewController:controller animated:YES completion:nil];
    
    }else{
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


@end
