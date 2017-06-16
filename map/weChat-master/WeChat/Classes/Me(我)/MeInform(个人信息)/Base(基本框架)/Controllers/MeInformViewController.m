//
//  MeInformViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeInformViewController.h"
#import "MeArrowModel.h"
#import "MeRightItemView.h"
#import "BaseRightItemView.h"
#import "MeInformArrowModel.h"
#import "SettingViewArrowModel.h"
#import "MeInformTableViewCell.h"
#import "NameEditViewController.h"
#import "HeadPictureViewController.h"
#import "MyAdderssViewController.h"
#import "GenderSelectedTableViewController.h"
#import "MyQRCodeViewController.h"
#import "SignatureViewController.h"
#import "XMPPvCardTemp.h"

@interface MeInformViewController ()<UIViewControllerDelegate,GenderSelectedTableViewControllerProtocol>
@end

@implementation MeInformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMeInformView];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatName:) name:@"reflushWechatName" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatSignature:) name:@"reflushWechatSignature" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatHeadIcon:) name:@"reflushWechatHeadIcon" object:nil];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflushWechatGender:) name:@"reflushWechatGender" object:nil];
}

- (void)reflushWechatGender:(NSNotification *)sender{
    [[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] setValue:sender.object forKey:@"detailTitle"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)reflushWechatHeadIcon:(NSNotification *)sender{
    
    
   NSArray *views = ((MeInformArrowModel *)[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row]).rightItemImages;
    
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    
    for(NSInteger index = 0; index < views.count; index++){
        if(index){
            [imageViews addObject:views[index]];
        }else{
            [imageViews addObject:sender.object];
        }
    }

     [[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] setValue:imageViews forKey:@"rightItemImages"];
    
    
    DebugLog(@"更新头像数据%s,%@",__func__,[[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] class]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)reflushWechatName:(NSNotification *)sender{
    
    [[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row] setValue:sender.object forKey:@"detailTitle"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)reflushWechatSignature:(NSNotification *)sender{
    
    NSArray *views = ((MeInformArrowModel *)[self.groupItems[self.lastIndexPath.section] valueForKey:@"items"][self.lastIndexPath.row]).rightItemImages;
    
    [views[0] setValue:sender.object forKey:@"text"];
    
    CGRect textFrame = [((UILabel *)views[0]).text boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:((UILabel *)views[0]).font} context:nil];
    ((UILabel *)views[0]).frame = textFrame;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DebugLog(@"释放了控制器%s",__func__);
}

- (void)setMeInformView{

    SettingModel *headicon = [MeInformArrowModel settingMeInformArrowModelWithTitle:@"头像" andWithIconName:nil andCellHeight:80 andWithDestinationClass:[HeadPictureViewController class]];
    
    UIImage *me = [[UIImage alloc] init];
    PersionModel *data = [PersionModel sharedPersionModel];
    [data asyLocalDataFormServers];
    
    if(data.headIcon){
          me = data.headIcon;
    }else{
          me = [UIImage resizedImageWithName:@"DefaultProfileHead"];
    }
    
  
    UIImage *arrow = [UIImage imageNamed:@"arrow_ico"];
    NSArray *itemImages = @[me,arrow];
    ((MeInformArrowModel *)headicon).rightItemPadding = 10;
    ((MeInformArrowModel *)headicon).rightItemImages = itemImages;
    
    SettingModel *name = [SettingArrowModel settingArrowModelWithTitle:@"名字" andWithIconName:nil andWithDestinationClass:[NameEditViewController class]];
    
    name.detailTitle = data.name;

   
    
    SettingModel *wechat = [SettingModel settingModelWithTitle:@"微信号" andWithIconName:nil];
    wechat.detailTitle = data.wechatID;
    
 
    SettingModel *myQR = [MeInformArrowModel settingMeInformArrowModelWithTitle:@"我的二维码" andWithIconName:nil andCellHeight:40 andWithDestinationClass:[MyQRCodeViewController class]];
   
    UIImage *qr = [UIImage imageNamed:@"setting_myQR"];
    UIImage *arrowQR = [UIImage imageNamed:@"arrow_ico"];
    NSArray *qrItemImages = @[qr,arrowQR];
    ((MeInformArrowModel *)myQR).rightItemPadding = 10;
    ((MeInformArrowModel *)myQR).rightItemImages = qrItemImages;
    
    SettingModel *myAddr = [SettingArrowModel settingArrowModelWithTitle:@"我的地址" andWithIconName:nil andWithDestinationClass:[MyAdderssViewController class]];

    
    SettingGroup *itemGroup0 = [[SettingGroup alloc] init];
    itemGroup0.items =@[headicon,name,wechat,myQR,myAddr];
    
 
    
    SettingModel *gender = [SettingArrowModel settingArrowModelWithTitle:@"性别" andWithIconName:nil andWithDestinationClass:[GenderSelectedTableViewController class]];
    
    gender.detailTitle = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"] intValue] <= 0 ? @"男":@"女";
    
    SettingModel *district = [SettingArrowModel settingArrowModelWithTitle:@"地区" andWithIconName:nil andWithDestinationClass:nil];
    
    if(!data.address){
        district.detailTitle = @"广东 广州";
    }else{
        district.detailTitle = [NSString stringWithFormat:@"%@",data.address];
    }
   
    
    SettingModel *signature = [SettingViewArrowModel settingMeInformArrowModelWithTitle:@"个性签名" andWithIconName:nil andCellHeight:50 andWithDestinationClass:[SignatureViewController class]];
    
    UILabel *signatureText = [[UILabel alloc] init];
    
    signatureText.text = data.signature;
    DebugLog(@"个性签名：%@",data.signature);
    signatureText.font = [UIFont systemFontOfSize:12];
    signatureText.numberOfLines = 0;
    
    CGRect textFrame = [signatureText.text boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:signatureText.font} context:nil];
    signatureText.frame = textFrame;
   
    
    signatureText.textColor = [UIColor grayColor];
    
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_ico"]];
    
    arrowIcon.frame = CGRectMake(0, 0, 5, 9);
    
    NSArray *ViewImages = @[signatureText,arrowIcon];
    
    ((MeInformArrowModel *)signature).rightItemPadding = 10;
    ((MeInformArrowModel *)signature).rightItemImages = ViewImages;
    ((MeInformArrowModel *)signature).rightItemsType = RightItemsTypeViews;
    
    
    SettingGroup *itemGroup1 = [[SettingGroup alloc] init];
    itemGroup1.items =@[gender,district,signature];
    
    
    [self.groupItems addObject:itemGroup0];
    [self.groupItems addObject:itemGroup1];

    
    [self.navigationItem setTitle:@"个人信息"];
}

- (void)viewDidAppear:(BOOL)animated{
        DebugLog(@"加载控制器到界面成功。");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    SettingGroup *group = self.groupItems[indexPath.section];

    //类名创建控制器
    if((!indexPath.section && !indexPath.row)
       ||(!indexPath.section && indexPath.row == (group.items.count - 2))){
        cell = [[MeInformTableViewCell class] cellWithTableView:tableView];
 
        MeInformArrowModel *model =(MeInformArrowModel *)group.items[indexPath.row];
        [(MeInformTableViewCell *)cell setModel:model];
        
    }else if((indexPath.section == self.groupItems.count - 1)&&(indexPath.row == group.items.count - 1)){
        cell = [[MeInformTableViewCell class] cellWithTableView:tableView];
        
        SettingViewArrowModel *model =(SettingViewArrowModel *)group.items[indexPath.row];
        [(MeInformTableViewCell *)cell setModel:model];
    }
    else{
        cell = [[SettingTableViewCell class] cellWithTableView:tableView];
        
        SettingModel *model = group.items[indexPath.row];
        [(SettingTableViewCell *)cell setModel:model];
        
    }
    return cell;
}


- (void)baseUIViewDidListenNavigationShouldPopOnByBackButton{
 
    NSLog(@"自己做自己的代理呵呵哒,");
    NSLog(@"is ------ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"]);
    
}

- (void)genderSelectedTableViewdidSelectedCell{
     NSLog(@"更新数据 %s",__func__);
    
    NSNotification *notice = [NSNotification notificationWithName:@"reflushTableView" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
