//
//  BaseGroupTableViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseGroupTableViewController.h"
#import "BaseWebViewController.h"
#import "WeChatNavigationController.h"
#import "WeChatTabbarController.h"
#import "BaseModelPushUIViewController.h"
#import "MyQRCodeViewController.h"



@interface BaseGroupTableViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseGroupTableViewController

- (NSMutableArray *)datalist{
    if(!_datalist){
        _datalist = [[NSMutableArray alloc] init];
    }
    return _datalist;
}

- (NSMutableArray *)groupItems{
    if(!_groupItems){
        _groupItems = [[NSMutableArray alloc] init];
    }
    return _groupItems;
}

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    
    
    
    // 创建滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTableViewTransition:)];

    // 设置手势代理，拦截手势触发
    pan.delegate = self;

    // 给tableviw添加滑动手势
    [self.tableView  addGestureRecognizer:pan];
    
 
}

- (void)handleTableViewTransition:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
//    DebugLog(@"table view 移动了,x = %0.0f,y = %0.0f",translation.x,translation.y);
}

#pragma mark - 手势冲突检测
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#pragma mark - 控制器代理方法
    if([self.delegate respondsToSelector:@selector(baseGroupTableviewDidAppear:)]){
        [self.delegate baseGroupTableviewDidAppear:self];
    }
#pragma mark - 启用监听TableView的scrollView 

//    [self.view setScorllObserveState:YES];
//    self.view.scrollView = self.tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
#pragma mark - 控制器代理方法
    if([self.delegate respondsToSelector:@selector(baseGroupTableviewWillAppear:)]){
        [self.delegate baseGroupTableviewWillAppear:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.groupItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    SettingGroup *groupItems = self.groupItems[section];
        return groupItems.items.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(self.groupItems.count&&
       [self.groupItems[section] isKindOfClass:[SettingGroup class]]){
        SettingGroup *group = self.groupItems[section];
        return group.headerTitle;
    }else{
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(self.groupItems.count&&
       [self.groupItems[section] isKindOfClass:[SettingGroup class]]){
        SettingGroup *group = self.groupItems[section];
        return group.footerTitle;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [[SettingTableViewCell class] cellWithTableView:tableView];
    
    SettingGroup *group = self.groupItems[indexPath.section];
    SettingModel *model = group.items[indexPath.row];
    [cell  setModel:model];
    
    return cell;
}

#pragma mark - 可以重写父类方法 model方式跳转与push方式 通过不同的控制器类型区分跳转方式
//选中的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //记录选中的indexpath
    if(![self.lastIndexPath isEqual:indexPath]){
        self.lastIndexPath = indexPath;
    }
    
    if(self.groupItems.count&&
       [self.groupItems[indexPath.section] isKindOfClass:[SettingGroup class]]){
        
        SettingGroup *group = self.groupItems[indexPath.section];
        SettingModel *model = group.items[indexPath.row];
        
        if(model.option){
            model.option(model);
            return ;
        }
        
        if(!model.responder){
            [self.view endEditing:YES];
        }
        
        if([model isKindOfClass:[SettingArrowModel class]]){
            SettingArrowModel *modelClass =(SettingArrowModel *)model;
            
            if(modelClass.destinationClass){
                UIViewController * controller = [[modelClass.destinationClass alloc] init];
                controller.title = model.title;
                
                //判断是否需要Model方式加载的view，如果是model态切换控制器
                if([[[modelClass.destinationClass superclass] new]
                    isKindOfClass:[BaseModelPushUIViewController class]]){
                    
                    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] initWithRootViewController:controller];
                    [navigation setWeChatNavigationDefaultStyle];
                    
                    [self presentViewController:navigation animated:YES completion:nil];
                }
                else{
                    
                   
                    //如果是第一个导航控制器，则让tabbar作为他们的代理，否则让她们自己做为自己的代理
                    if([self.navigationController.viewControllers count] == FristViewControllerIndexNumber){
                        //让底层Tabbar做代理
                        [controller setDelegate:(id)self.tabBarController];
                        
                    }else{
                        [controller setDelegate:(id)self];
                        NSLog(@"%@------->%@",[controller class],[self class]);
                    }
                    
                    [self.navigationController pushViewController:controller animated:YES ];
                   
                }
            }
        }
    }
}


#pragma mark - 代理方法 计算行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.groupItems.count&&
       [self.groupItems[indexPath.section] isKindOfClass:[SettingGroup class]]){
        
        SettingGroup *group = self.groupItems[indexPath.section];
        SettingModel *model = group.items[indexPath.row];
        
            return model.cellHeight;
    }
    
    return 44;
}

#pragma mark - 取消选中与恢复


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}


@end
