//
//  SettingViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingViewArrowModel.h"
#import "BlackArrowModel.h"
#import "MeFrameConfig.h"
#import "BlackTextTableViewCell.h"
#import "MeInformTableViewCell.h"
#import "ProgressHUD.h"
#import "LoginedController.h"
#import "ActionSheet.h"



@interface SettingViewController ()<XmppToolsDelegate,ActionSheetDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSettingView];
}

- (void)setSettingView{
    
    SettingModel *accountSafe = [SettingViewArrowModel settingMeInformArrowModelWithTitle:@"账号与安全" andWithIconName:nil andCellHeight:40 andWithDestinationClass:nil];
    
    UIImageView *lock = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProfileLockOn"]];
    lock.frame = CGRectMake(0, 0, 17, 17);
    UILabel *safeText = [[UILabel alloc] init];

    safeText.text = @"已保护";
    safeText.font = [UIFont systemFontOfSize:12];
    
    CGRect textFrame = [safeText.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:safeText.font} context:nil];
        safeText.frame = textFrame;
    
    safeText.textColor = [UIColor grayColor];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_ico"]];
    arrow.frame = CGRectMake(0, 0, 5, 9);
    
    NSArray *ViewImages = @[lock,safeText,arrow];
    
    ((MeInformArrowModel *)accountSafe).rightItemPadding = 10;
    ((MeInformArrowModel *)accountSafe).rightItemImages = ViewImages;
    ((MeInformArrowModel *)accountSafe).rightItemsType = RightItemsTypeViews;
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[accountSafe];
    
    
    SettingModel *news = [SettingArrowModel settingArrowModelWithTitle:@"新消息通知" andWithIconName:nil andWithDestinationClass:nil];
    
    SettingModel *protect = [SettingArrowModel settingArrowModelWithTitle:@"隐私" andWithIconName:nil andWithDestinationClass:nil];
    
    SettingModel *global = [SettingArrowModel settingArrowModelWithTitle:@"通用" andWithIconName:nil andWithDestinationClass:nil];
    
    
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[news,protect,global];
    
    SettingModel *help = [SettingArrowModel settingArrowModelWithTitle:@"帮助与反馈" andWithIconName:nil andWithDestinationClass:nil];
    
    SettingModel *about = [SettingArrowModel settingArrowModelWithTitle:@"关于微信" andWithIconName:nil andWithDestinationClass:nil];
    
    SettingGroup *itemGroup2 = [[SettingGroup alloc] init];
    itemGroup2.items =@[help,about];
    
    SettingModel *logout = [BlackArrowModel settingModelWithTitle:nil andWithIconName:nil];
    ((BlackArrowModel *)logout).cellText = @"退出登录";
    ((BlackArrowModel *)logout).fontType = CellTitelFontSize;
    
    SettingGroup *itemGroup3 = [[SettingGroup alloc] init];
    itemGroup3.items =@[logout];
    
    [self.groupItems addObject:itemGroup0];
    [self.groupItems addObject:itemGroup1];
    [self.groupItems addObject:itemGroup2];
    [self.groupItems addObject:itemGroup3];
    
    [self.navigationItem setTitle:@"设置"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    SettingGroup *group = self.groupItems[indexPath.section];
    //类名创建控制器
    if(!indexPath.section){
        cell = [[MeInformTableViewCell class] cellWithTableView:tableView];
        
        SettingViewArrowModel *model =(SettingViewArrowModel *)group.items[indexPath.row];
        [(MeInformTableViewCell *)cell setModel:model];
    }
    else if(indexPath.section == self.groupItems.count - 1){
        cell = [[BlackTextTableViewCell class] cellWithTableView:tableView];
        
        BlackArrowModel *model =(BlackArrowModel *)group.items[indexPath.row];
        [(BlackTextTableViewCell *)cell setModel:model];
        
    }else{
        cell = [[SettingTableViewCell class] cellWithTableView:tableView];
        
        SettingModel *model = group.items[indexPath.row];
        [(SettingTableViewCell *)cell setModel:model];
        
    }
    return cell;
}

#pragma mark - 可以重写父类方法 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 退出登录按钮
    if(indexPath.section == (self.groupItems.count - 1)){
        [self logoutAccout];
        
    }else{
        //调用父类方法
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (void)logoutAccout{
    ActionSheet *actionSheet = [[ActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
    [actionSheet show];
}

// 代理方法
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex){
        [MBProgressHUD showMessage: @"正在退出..."toView:self.view];

          XMPPTools *xmpp = [XMPPTools sharedXMPPTools];

          weak_self weakSelf = self;

         [xmpp XmppUsrLogoutwithCallBackResult:^(XmppResultType result, AppDelegate *app) {
            //退出成功
            if(result == XmppResultTypeNetWorkDisconnectSuccess){
                // 隐藏登录遮板
                [MBProgressHUD hideHUDForView:weakSelf.view];
                
                // 退出登录
                [actionSheet setBlock:^{
                    //退到根控制器
                    [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                    //切换根控制器
                    LoginedController *controller = [[LoginedController alloc] init];
                    //清除窗口颜色
                    [app.window setBackgroundColor:[UIColor whiteColor]];
                    [app.window setRootViewController:controller];
                }];
            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    DebugLog(@"释放了控制器%s",__func__);
}

@end
