//
//  LanguageSelectedViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LanguageSelectedViewController.h"

#import "AppDelegate.h"


@interface LanguageSelectedViewController ()
@property (nonatomic,strong)NSMutableArray *languages;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,strong)UIButton *saveButton;
@property (nonatomic,strong)NSString *selectedLanguage;

@end

@implementation LanguageSelectedViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
    
}

#pragma mark - 懒加载

-(NSMutableArray *)languages{
    if(!_languages){
        _languages = [[NSMutableArray alloc] init];
        NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"language.plist" ofType:nil]];
        for(NSString *name in array){
            [_languages addObject:name];
        }
    }
    return _languages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLanguageSelectView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setLanguageSelectView{
   
    [self.navigationItem setTitle:@"多语言"];
 
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [backButton addTarget:self action:@selector(backToLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    self.backButton = backButton;
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
 
    [saveButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    [saveButton addTarget:self action:@selector(saveLanguageSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [saveButton setEnabled:NO];
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];

    [self.navigationItem setRightBarButtonItem:saveButtonItem];
    self.saveButton = saveButton;
    
    //字体和子控件适配
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.backButton setFrame:CGRectMake(0, 0, 80, 30)];
        [self.saveButton setFrame:CGRectMake(0, 0, 80, 30)];
        
        [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:24.0]];
        [self.saveButton.titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    }else{
        [self.backButton setFrame:CGRectMake(0, 0, 40, 30)];
        [self.saveButton setFrame:CGRectMake(0, 0, 40, 30)];
        
        [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.saveButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }
}

//字体和子控件适配
- (void)viewDidLayoutSubviews{
 
}
#pragma mark - 按键方法
- (void)backToLogin:(UIButton *) button{
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveLanguageSelected:(UIButton *) button{

    [[NSUserDefaults standardUserDefaults] setObject:self.selectedLanguage forKey:@"language"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.languages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"language";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.textLabel setText:self.languages[indexPath.row]];
    
    NSString *index = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    NSIndexPath *selectedLanguage = [NSIndexPath indexPathForRow:[index intValue] inSection:0];
    
    if(indexPath == selectedLanguage){
         [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
         [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
  
    return cell;
}

//选中的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [tableView visibleCells];
    for (UITableViewCell *cell in array) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
//        cell.textLabel.textColor=[UIColor blackColor];
    }
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.textColor=[UIColor blueColor];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    self.selectedLanguage  =[NSString stringWithFormat:@"%ld",indexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
