//
//  SearchResultViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchFriendsTableViewCell.h"
#import "WeChatNavigationController.h"
#import "FriendsCardViewController.h"
#import "SearchFriendsViewController.h"
#import "ProgressHUD.h"
#import "ServersConfig.h"
#import "BaseSearchBar.h"
#import "XMPPvCardTemp.h"


@interface SearchResultViewController () <UIViewControllerDelegate,BaseGroupTableViewControllerDelegate>
@property (nonatomic, copy)NSString *wechatID;
@end



@implementation SearchResultViewController



- (instancetype)init{
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setSearchResultView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatSearchFriends:) name:@"reflushWechatSearchFriends" object:nil];
}

- (void)setSearchResultView{
    
    SettingModel *searchItems = [SettingArrowModel settingArrowModelWithTitle:@"搜索：" andWithIconName:@"add_friend_icon_search" andWithDestinationClass:nil];
    
    searchItems.detailTitle = @"jlkkdkljslk";
    searchItems.cellHeight = 60;
   
    self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.groupItems addObject:searchItems];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reflushWechatSearchFriends:(NSNotification *)sender{

    NSString *text =(NSString *) sender.object;
    SearchFriendsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastIndexPath];
    
    if(text.length){
        self.wechatID = sender.object;
        
        [cell.contentView setHidden:NO];
        SettingModel *searchItems =self.groupItems[0];
        searchItems.detailTitle = sender.object;
    }else{
        [cell.contentView setHidden:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - tableView 数据源与代理方法 ---------------------------------------------------------

#pragma mark - 代理方法 计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingModel *model = self.groupItems[indexPath.row];
    return model.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.groupItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchFriendsTableViewCell *cell = [[SearchFriendsTableViewCell class] cellWithTableView:tableView];

    SettingModel *model = self.groupItems[indexPath.row];
    [cell setModel:model];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!indexPath.row&&!indexPath.section){
        [MBProgressHUD showMessage:@"正在搜索..." toView:self.view];
        
        //从服务器抓取数据
        XMPPJID *jid = [XMPPJID jidWithUser:self.wechatID domain:LOCALHOSTIP resource:[[UIDevice currentDevice] iphoneType]];
        
        XMPPvCardTemp *card = [[XMPPTools sharedXMPPTools].vCard vCardTempForJID:jid shouldFetch:YES];
        
        if(card.jid){

            [self setNavgationSearchBarHiden:YES];
            
            [MBProgressHUD hideHUDForView:self.view];
            DebugLog(@"card.name :%@",[NSString  replaceUnicode:card.formattedName]);
            //切换控制器
            FriendsCardViewController *cardsController = [FriendsCardViewController friendsCardViewControllerWithCard:card];

            [cardsController setDelegate:self];
            
            [self.navigationController pushViewController:cardsController animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"无匹配的用户！" toView:self.view];
        }
        
    }
}

- (void)baseUIViewDidListenNavigationShouldPopOnByBackButton{
    DebugLog(@"代理方法监听返回按钮");
    [self setNavgationSearchBarHiden:NO];
}


- (void)setNavgationSearchBarHiden:(BOOL) hiden{
    if(hiden){
        [self.navigationItem setTitle:@"添加朋友"];
        //设置导航栏属性
        [(WeChatNavigationController *)self.navigationController setWeChatNavigationDefaultStyle];
    }else{
        [self.navigationItem setTitle:nil];
        [(WeChatNavigationController *)self.navigationController setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    }
    
    [self.navigationController.navigationBar endEditing:hiden];
    for(UIView *view in self.navigationController.navigationBar.subviews){
        if([view isKindOfClass:[BaseSearchBar class]]){
            [view setHidden:hiden];
            if(!hiden){
                UITextField *searchField = [view valueForKey:@"_searchField"];
                [searchField becomeFirstResponder];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
