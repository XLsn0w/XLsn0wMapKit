//
//  SearchViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchViewController.h"
#import "MeInformArrowModel.h"
#import "MeInformTableViewCell.h"
#import "LargeIconArrowModel.h"
#import "WeChatNavigationController.h"
#import "MomentsViewController.h"
#import "ScanViewController.h"
#import "ShoppingViewController.h"
#import "BottleViewController.h"
#import "GamesViewController.h"


@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSearchView];
}

- (void)setSearchView{
    
    SettingModel *moments = [SettingArrowModel settingArrowModelWithTitle:@"朋友圈" andWithIconName:@"ff_IconShowAlbum" andWithDestinationClass:[MomentsViewController class]];
    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[moments];
    
    SettingModel *scan = [SettingArrowModel settingArrowModelWithTitle:@"扫一扫" andWithIconName:@"ff_IconQRCode" andWithDestinationClass:[ScanViewController class]];
    
    SettingModel *shake = [SettingArrowModel settingArrowModelWithTitle:@"摇一摇" andWithIconName:@"ff_IconShake" andWithDestinationClass:nil];
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[scan,shake];
    
 
    SettingModel *nearby = [MeInformArrowModel settingMeInformArrowModelWithTitle:@"附近的人" andWithIconName:@"ff_IconLocationService" andCellHeight:40 andWithDestinationClass:nil];
    
    UIImage *footStep = [UIImage imageNamed:@"FootStep"];
    UIImage *arrow = [UIImage imageNamed:@"arrow_ico"];
    NSArray *itemImages = @[footStep,arrow];
    
    ((MeInformArrowModel *)nearby).rightItemPadding = 10;
    ((MeInformArrowModel *)nearby).rightItemImages = itemImages;
    
    SettingModel *bottle = [SettingArrowModel settingArrowModelWithTitle:@"漂流瓶" andWithIconName:@"ff_IconBottle" andWithDestinationClass:[BottleViewController class]];
    
    SettingGroup *itemGroup2 = [[SettingGroup alloc] init];
    itemGroup2.items =@[nearby,bottle];
    
    
    SettingModel *shopping = [LargeIconArrowModel settingArrowModelWithTitle:@"购物" andWithIconName:@"CreditCard_ShoppingBag" andWithDestinationClass:[ShoppingViewController class]];
    
    SettingModel *games = [SettingArrowModel settingArrowModelWithTitle:@"游戏" andWithIconName:@"MoreGame" andWithDestinationClass:[GamesViewController class]];
    
    SettingGroup *itemGroup3 = [[SettingGroup alloc] init];
    itemGroup3.items =@[shopping,games];
    
    [self.groupItems addObject:itemGroup0];
    [self.groupItems addObject:itemGroup1];
    [self.groupItems addObject:itemGroup2];
    [self.groupItems addObject:itemGroup3];
    
    [self.navigationItem setTitle:@"发现"];
}

#pragma mark - 重写父类方法 实现不同cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    SettingGroup *group = self.groupItems[indexPath.section];
    //类名创建控制器
    if((indexPath.section == self.groupItems.count - 2) && !indexPath.row){
        cell = [[MeInformTableViewCell class] cellWithTableView:tableView];
        
        MeInformArrowModel *model =(MeInformArrowModel *)group.items[indexPath.row];
        [(MeInformTableViewCell *)cell setModel:model];
        
    }else{
        cell = [[SettingTableViewCell class] cellWithTableView:tableView];
        
        SettingModel *model = group.items[indexPath.row];
        [(SettingTableViewCell *)cell setModel:model];
        
    }
    return cell;
}


- (void)dealloc{
    DebugLog(@"释放了控制器%s",__func__);
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
