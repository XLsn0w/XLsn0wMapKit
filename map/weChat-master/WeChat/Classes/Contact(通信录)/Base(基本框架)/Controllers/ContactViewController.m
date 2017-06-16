//
//  ContactViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactArrowModel.h"
#import "WeChatNavigationController.h"
#import "NewFriendsViewController.h"
#import "AddFriendsViewController.h"
#import "FriendsCardListData.h"

@interface ContactViewController () <SearchTableViewControllerDelegate>

@end

@implementation ContactViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置table view headerview
    
    [self setTableViewSearchBar];
    [self setContactView];

}

- (void)setContactView{
    
    SettingModel *newFriends = [ContactArrowModel settingContactArrowModelWithTitle:@"新的朋友" andWithIconName:@"plugins_FriendNotify" andWithDestinationClass:[NewFriendsViewController class]];
    
    SettingModel *groupChat = [ContactArrowModel settingContactArrowModelWithTitle:@"群聊" andWithIconName:@"add_friend_icon_addgroup" andWithDestinationClass:nil];
    
    SettingModel *notte = [ContactArrowModel settingContactArrowModelWithTitle:@"标签" andWithIconName:@"Contact_icon_ContactTag" andWithDestinationClass:nil];
    
     SettingModel *officialAccounts  = [ContactArrowModel settingContactArrowModelWithTitle:@"公众号" andWithIconName:@"add_friend_icon_offical" andWithDestinationClass:nil];
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[newFriends,groupChat,notte,officialAccounts];
    
    
    [self.groupItems addObject:itemGroup0];
    

    [[FriendsCardListData sharedFriendsCardListData] loadFriendsCardList];
    
    //导航栏item设置
    UIButton *addContacts = [UIButton buttonWithType:UIButtonTypeCustom];
    [addContacts setFrame:CGRectMake(0, 0, 30, 30)];
    [addContacts setImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    
    [addContacts addTarget:self action:@selector(addContactFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addFriends = [[UIBarButtonItem alloc] initWithCustomView:addContacts];
    [self.navigationItem setRightBarButtonItem:addFriends];
    [self.navigationItem setTitle:@"通信录"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAddFriendsClick)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)rightButtonAddFriendsClick{
    AddFriendsViewController * controller = [[AddFriendsViewController alloc] init];
    controller.title = @"添加朋友" ;
    
    [self.navigationController pushViewController:controller animated:YES ];
}

- (void)setTableViewSearchBar{
    
    [self searchTableViewCustomerTextFieldWithBorderColor:nil andTextFieldStyle:UISearchTextFieldDefault];
    
    [self setSearchBarDelegate:self];
    
    [self searchTableViewHidesNavigationBarDuringPresentation:YES];
    
    [self searchTableViewCancelButtonWithName:@"取消"];
    //设置光标颜色
    [self searchTableViewTextFieldCursorWithColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
    
    [self searchTableViewTextFieldRightButtonNormalImageWithName:@"VoiceSearchStartBtn" andHighledImageName:@"VoiceSearchStartBtnHL" andButtonStyle:UISearchTextFieldRightButtonCustomer andPlaceHolder:@"搜索"];
   
//    [self searchTableViewClearButton];
}

- (void)addContactFriends:(UIButton *) button{
    
}

- (void)searchTableViewRightButtonDidClickWith:(UISearchBar *)searchBar{
    NSLog(@"语言输入啦，快快快");

}

- (void)searchTableViewSearchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"开始输入了啦");
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
