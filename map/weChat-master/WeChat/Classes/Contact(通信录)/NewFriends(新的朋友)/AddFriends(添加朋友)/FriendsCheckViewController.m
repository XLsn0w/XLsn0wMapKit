//
//  FriendsCheckViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/30.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "FriendsCheckViewController.h"
#import "ProgressHUD.h"
#import "ServersConfig.h"
#import "CardsNameFieldCell.h"

@interface FriendsCheckViewController ()

@end

@implementation FriendsCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"朋友验证"];
    [self setupFriendsCheck];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(Finshed)];
    
    
    [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    [self.navigationItem setLeftBarButtonItem:back];

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    }else{
        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickSendAddFriends)];
    
    [buttonItem setTintColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
   
    self.navigationItem.rightBarButtonItem = buttonItem;
    // Do any additional setup after loading the view.
}

- (void)clickSendAddFriends{
    DebugLog(@"发送添加信息");
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"friends_card"];
    
    if([name isEqualToString:[PersionModel sharedPersionModel].wechatID]){
        [MBProgressHUD showError:@"不能添加自己！" toView:self.view];
        return;
    }

    
    if(name.length){
        //从服务器抓取数据
        XMPPJID *jid = [XMPPJID jidWithUser:name domain:LOCALHOSTIP resource:[[UIDevice currentDevice] iphoneType]];
        
        if([[XMPPTools sharedXMPPTools].rosterStorage userExistsWithJID:jid xmppStream:[XMPPTools sharedXMPPTools].xmppstream]){
            [MBProgressHUD showError:@"当前好友已经存在！" toView:self.view];
            return;
        }
        
        //订阅好友
        [[XMPPTools sharedXMPPTools].roster subscribePresenceToUser:jid];
    }
}

- (void)setupFriendsCheck{
    
    NSString *nickName = [[NSUserDefaults standardUserDefaults] valueForKey:@"friends_card_nick_name"];
    
    SettingModel *name = [SettingModel settingModelWithTitle:[NSString stringWithFormat:@"%@",nickName]andWithIconName:nil ];
    name.detailTitle = @"我是：";
    
    SettingModel *friendsRoot = [SettingSwitchModel settingModelWithTitle:@"不让他（她）看我的朋友圈" andWithIconName:nil];
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    [itemGroup0 setHeaderTitle:@"你需要发送验证申请，等待对方通过"];
    
    itemGroup0.items =@[name];
    
    [self.groupItems addObject:itemGroup0];
    
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    [itemGroup1 setHeaderTitle:@"朋友圈权限"];
    
    itemGroup1.items =@[friendsRoot];
    
    [self.groupItems addObject:itemGroup1];
}


- (void)Finshed{
    // model方式返回
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!indexPath.section){
        CardsNameFieldCell *cell = [[CardsNameFieldCell class] cellWithTableView:tableView];
        
        SettingGroup *group = self.groupItems[indexPath.section];
        SettingModel *model = group.items[indexPath.row];
        [cell setModel:model];
        
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }

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
