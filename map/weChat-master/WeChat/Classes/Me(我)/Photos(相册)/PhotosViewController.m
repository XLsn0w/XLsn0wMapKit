//
//  PhotosViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "PhotosViewController.h"
#import "MomentsHeaderView.h"
#import "MoreInformViewController.h"

@interface PhotosViewController ()
@property (nonatomic,weak)MomentsHeaderView *headerView;
@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setPhotosView];
    [self.navigationItem setTitle:@"相册"];
}

- (void)setPhotosView{
    
    MomentsHeaderView *headerView = [[MomentsHeaderView alloc] init];
    [headerView setSize:CGSizeMake(self.tableView.width, 260)];
    weak_self weakSelf = self;
    [headerView setIconImageClick:^{
        MoreInformViewController *controller = [[MoreInformViewController alloc] init];
        [controller setDelegate:(id)weakSelf];
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
    
    self.headerView = headerView;
    
    
    [self.tableView setTableHeaderView:headerView];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
    

    [headerView setBackGroudImageClick:^{
        [weakSelf changePhotosCoverImage];
    }];
}

- (void)rightButtonClick{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"消息列表" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changePhotosCoverImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"更换相册封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
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
