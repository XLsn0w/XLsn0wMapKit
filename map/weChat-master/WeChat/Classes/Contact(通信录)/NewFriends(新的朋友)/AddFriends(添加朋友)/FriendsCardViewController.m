//
//  FriendsCardViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "FriendsCardViewController.h"
#import "AddFriendsToContactFooterView.h"
#import "XMPPvCardTemp.h"
#import "CardsHeadModel.h"
#import "SettingViewArrowModel.h"
#import "MeInformArrowModel.h"
#import "CardsHeadTableViewCell.h"
#import "MeInformTableViewCell.h"
#import "WeChatNavigationController.h"
#import "FriendsCheckViewController.h"

@interface FriendsCardViewController ()<AddFriendsToContactFooterViewProtocal>

@end

@implementation FriendsCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationItem setTitle:@"详细资料"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
    // Do any additional setup after loading the view.
}

- (void)rightButtonClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFriendsCardView:(XMPPvCardTemp *)card{
    
    UIImage *image = [[UIImage alloc] init];
    if(card.photo){
        image = [UIImage imageWithData:card.photo];
    }else{
        image = [UIImage imageNamed:@"DefaultProfileHead"];
    }
//    [NSString stringWithFormat:@"微信号：%@",card.jid.user]
    
    [[NSUserDefaults standardUserDefaults] setObject:card.jid.user forKey:@"friends_card"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString replaceUnicode:card.formattedName] forKey:@"friends_card_nick_name"];
    
    SettingModel *inform = [CardsHeadModel settingCardsHeadModelWithTitle:[NSString replaceUnicode:card.formattedName]  andWithDetailTitel:nil andWithIconImage:image andCellHeight:80 andWithDestinationClass:nil];
     PersionModel *data = [PersionModel sharedPersionModel];
    
    if([data.gender isEqualToString:@"男"]){
        ((CardsHeadModel *)inform).genderIcon = @"Contact_Male";
    }else{
        ((CardsHeadModel *)inform).genderIcon = @"Contact_Female";
    }
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[inform];
    
    SettingModel *label = [SettingArrowModel settingArrowModelWithTitle:@"设置备注和标签" andWithIconName:nil andWithDestinationClass:nil];
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[label];
    
    SettingModel *area = [SettingModel settingModelWithTitle:@"地区" andWithIconName:nil ];
    
    SettingModel *signature = [SettingViewArrowModel settingMeInformArrowModelWithTitle:@"个性签名" andWithIconName:nil andCellHeight:60 andWithDestinationClass:nil];
    
    UILabel *signatureText = [[UILabel alloc] init];
    
    DebugLog(@"个性签名:%@",[NSString replaceUnicode:card.title]);
    signatureText.text = [NSString replaceUnicode:card.title];
    signatureText.font = [UIFont systemFontOfSize:14];
    signatureText.textAlignment = NSTextAlignmentLeft;
    signatureText.numberOfLines = 0;
    
    CGRect textFrame = [signatureText.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:signatureText.font} context:nil];
    signatureText.frame = textFrame;
    
   
    
    signatureText.textColor = [UIColor grayColor];
    
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    
    arrowIcon.frame = CGRectMake(0, 0, 5, 9);
    
    NSArray *ViewImages = @[signatureText,arrowIcon];
    
    ((MeInformArrowModel *)signature).rightItemPadding = 10;
    ((MeInformArrowModel *)signature).rightItemImages = ViewImages;
    ((MeInformArrowModel *)signature).rightItemsType = RightItemsTypeViews;
    
    SettingModel *personInform = [SettingArrowModel settingArrowModelWithTitle:@"社交资料" andWithIconName:nil andWithDestinationClass:nil];
    
    SettingModel *source = [SettingModel settingModelWithTitle:@"来源" andWithIconName:nil ];
    
    SettingGroup *itemGroup2 = [[SettingGroup alloc] init];

    
    itemGroup2.items =@[area,signature,personInform,source];
    
    [self.groupItems addObject:itemGroup0];
    [self.groupItems addObject:itemGroup1];
    [self.groupItems addObject:itemGroup2];
    
    AddFriendsToContactFooterView *view = [[AddFriendsToContactFooterView alloc] init];
    [view setSize:CGSizeMake(self.view.width, 100)];
    [view setProtocal:self];
    
    [self.tableView setTableFooterView:view];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SettingGroup *group = self.groupItems[section];
    
    return group.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    //类名创建控制器
    if(!indexPath.section){
        SettingGroup *group = self.groupItems[indexPath.section];
        cell = [[CardsHeadTableViewCell class] cellWithTableView:tableView];
        CardsHeadModel *model =(CardsHeadModel *)group.items[indexPath.row];
        [(CardsHeadTableViewCell *)cell setModel:model];
        
    }else if((indexPath.section == self.groupItems.count - 1)&&(indexPath.row == 1)){
        SettingGroup *group = self.groupItems[indexPath.section];
        cell = [[MeInformTableViewCell class] cellWithTableView:tableView];
        
        SettingViewArrowModel *model =(SettingViewArrowModel *)group.items[indexPath.row];
        [(MeInformTableViewCell *)cell setModel:model];
    }
    else{
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}
#pragma mark - addFriendsView的代理方法
- (void)addFriendsToContactDidAdd{
    FriendsCheckViewController *resultController = [[FriendsCheckViewController alloc] init];
    
    
    WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:resultController];
    
    //设置导航栏属性
    [(WeChatNavigationController *)controller setWeChatNavigationDefaultStyle];
    
    [self presentViewController:controller animated:YES completion:nil];
}

+ (instancetype)friendsCardViewControllerWithCard:(XMPPvCardTemp *)card{
    FriendsCardViewController *controller = [[self alloc] init];
    [controller setupFriendsCardView:card];
    return controller;
}

@end
