//
//  MeViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeViewController.h"
#import "MeArrowModel.h"
#import "MeInformViewController.h"
#import "SettingViewController.h"
#import "PhotosViewController.h"
#import "NameEditViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMeView];
}

- (void)setMeView{
    
    UIImage *image = [[UIImage alloc] init];
    PersionModel *data = [PersionModel sharedPersionModel];
    [data asyLocalDataFormServers];
    if(data.headIcon){
        image = data.headIcon;
    }else{
        image = [UIImage imageNamed:@"DefaultProfileHead"];
    }
    
    SettingModel *me = [MeArrowModel settingMeArrowModelWithTitle:data.name andWithDetailTitel:[NSString stringWithFormat:@"微信号：%@",data.wechatID] andWithIconImage:image andCellHeight:80 andWithDestinationClass:[MeInformViewController class]];

    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[me];
    
    SettingModel *photos = [SettingArrowModel settingArrowModelWithTitle:@"相册" andWithIconName:@"MoreMyAlbum" andWithDestinationClass:[PhotosViewController class]];
    
    SettingModel *save = [SettingArrowModel settingArrowModelWithTitle:@"收藏" andWithIconName:@"MoreMyFavorites" andWithDestinationClass:nil];
    
    SettingModel *wallet = [SettingArrowModel settingArrowModelWithTitle:@"钱包" andWithIconName:@"MoreMyBankCard" andWithDestinationClass:nil];
    
    SettingModel *cards = [SettingArrowModel settingArrowModelWithTitle:@"卡包" andWithIconName:@"MyCardPackageIcon" andWithDestinationClass:nil];
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[photos,save,wallet,cards];
    
    
    SettingModel *expression = [SettingArrowModel settingArrowModelWithTitle:@"表情" andWithIconName:@"MoreExpressionShops" andWithDestinationClass:nil];
    
    SettingGroup *itemGroup2 = [[SettingGroup alloc] init];
    itemGroup2.items =@[expression];
    
    SettingModel *setting = [SettingArrowModel settingArrowModelWithTitle:@"设置" andWithIconName:@"MoreSetting" andWithDestinationClass:[SettingViewController class]];
    
    SettingGroup *itemGroup3 = [[SettingGroup alloc] init];
    itemGroup3.items =@[setting];
    
    [self.groupItems addObject:itemGroup0];
    [self.groupItems addObject:itemGroup1];
    [self.groupItems addObject:itemGroup2];
    [self.groupItems addObject:itemGroup3];
    
    [self.navigationItem setTitle:@"我"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatName:) name:@"reflushWechatName" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatHeadIcon:) name:@"reflushWechatHeadIcon" object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DebugLog(@"释放了控制器%s",__func__);
}

- (void)reflushWechatHeadIcon:(NSNotification *)sender{
    [[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] setValue:sender.object forKey:@"iconImage"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


- (void)reflushWechatName:(NSNotification *)sender{

     [[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] setValue: sender.object forKey:@"title"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
//    DebugLog(@"index path%lu,%lu",indexPath.section,indexPath.row);
    SettingGroup *group = self.groupItems[indexPath.section];
    //类名创建控制器
    if(indexPath.section){
        cell = [[SettingTableViewCell class] cellWithTableView:tableView];
        SettingModel *model = group.items[indexPath.row];
        [(SettingTableViewCell *)cell setModel:model];
        
    }else{
        cell = [[MeTableViewCell class] cellWithTableView:tableView];
        MeArrowModel *model =(MeArrowModel *)group.items[indexPath.row];
        [(MeTableViewCell *)cell setModel:model];

    }
        return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
