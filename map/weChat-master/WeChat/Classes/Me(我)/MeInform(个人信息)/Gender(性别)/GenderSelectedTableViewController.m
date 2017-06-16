//
//  GenderSelectedTableViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/10.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "GenderSelectedTableViewController.h"

@interface GenderSelectedTableViewController ()
@property (nonatomic,strong)NSArray *gender;

@end

@implementation GenderSelectedTableViewController

- (NSArray *)gender{
    if(!_gender){
        _gender = @[@"男",@"女"];
    }
    return _gender;
}

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGenderSelectedView];
}

- (void)setGenderSelectedView{
      [self.navigationItem setTitle:@"性别"];
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
    return self.gender.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"gender";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.textLabel setText:self.gender[indexPath.row]];
    
    NSString *index = [[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
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
    
    NSString *select  =[NSString stringWithFormat:@"%ld",indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:select forKey:@"gender"];
    
    //返回刷新 跟新数据源
    NSNotification *notice = [NSNotification notificationWithName:@"reflushWechatGender" object:self.gender[indexPath.row]];
    
    //更新数据
    PersionModel *data = [PersionModel sharedPersionModel];
    
    data.gender = self.gender[indexPath.row];
    
    [data updateLocalDataToServers];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    
    [self.navigationController popViewControllerAnimated:YES];
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
