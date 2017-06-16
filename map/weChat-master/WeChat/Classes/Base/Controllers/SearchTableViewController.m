//
//  SearchTableViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () <UISearchBarDelegate,UIBarPositioningDelegate>
@property (nonatomic,strong)UISearchController *searchController;
@end

@implementation SearchTableViewController

- (UISearchController *)searchController{
    if(!_searchController){
        UIViewController *resultController = [[UIViewController alloc] init];
        [resultController.view setBackgroundColor:[UIColor whiteColor]];
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultController];
        self.resultController = resultController;
        
        [_searchController.searchBar setFrame:CGRectMake(0, 0, 0, 50)];
        [_searchController.searchBar setBackgroundColor:[UIColor clearColor]];
        
        [_searchController.searchBar setDelegate:self];
    
        //是否添加半透明覆盖层
        [_searchController setDimsBackgroundDuringPresentation:YES];
        [_searchController.searchBar sizeToFit];
        [_searchController.searchBar setPlaceholder:@"搜索"];
      
        //删除默认灰色背景
        [_searchController.searchBar.subviews[0].subviews[0] removeFromSuperview];
        
        
        [self.tableView setTableHeaderView:_searchController.searchBar];
    }
    return _searchController;
}

- (void)searchTableViewCustomerTextFieldWithBorderColor:(UIColor *) color andTextFieldStyle:(UISearchTextFieldType) type{
    
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"searchField"];
    
    if(type == UISearchTextFieldDefault){
        return;
    }
    
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 14.0f;
        if(type == UISearchTextFieldBorderColorDarkRed){
            searchField.layer.borderColor = [UIColor colorWithRed:247/255.0 green:75/255.0 blue:31/255.0 alpha:1].CGColor;
        }else if(type == UISearchTextFieldBorderColorDarkGreen){
            searchField.layer.borderColor = [UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0].CGColor;
        }else if(type == UISearchTextFieldBorderColorGray){
            searchField.layer.borderColor = [UIColor grayColor].CGColor;
        }else{
            searchField.layer.borderColor = color.CGColor;
        }
        
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
}

//输入的时候是否隐藏导航栏
- (void)searchTableViewHidesNavigationBarDuringPresentation:(BOOL) state{
      [_searchController setHidesNavigationBarDuringPresentation:state];
}

//修改取消按钮
- (void)searchTableViewCancelButtonWithName:(NSString *) name{
    UIButton *cancelButton = [self.searchController.searchBar valueForKey:@"cancelButton"];
    [cancelButton setTitle:name forState:UIControlStateNormal];
}

//搜索框光标颜色
- (void)searchTableViewTextFieldCursorWithColor:(UIColor *)color{
     [self.searchController.searchBar setTintColor:color];
}
//自定义右边搜索栏

- (void)searchTableViewTextFieldRightButtonNormalImageWithName:(NSString *)normalName andHighledImageName:(NSString *) hightledName andButtonStyle:(UISearchTextFieldRightButtonIconType) type andPlaceHolder:(NSString *) placeText{
    
    
    if(type == UISearchTextFieldRightButtonDefault){
        return;
    }
    //添加右边图标
    if(normalName){
        [self.searchController.searchBar setShowsBookmarkButton:YES];
    }
    
    // 默认字符
    [self.searchController.searchBar setPlaceholder:placeText];
    
    [self.searchController.searchBar setImage:[UIImage imageNamed:normalName] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [self.searchController.searchBar setImage:[UIImage imageNamed:hightledName] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];

}



- (void)searchTableViewClearButton{
    [self.searchController.searchBar setShowsSearchResultsButton:YES];
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES];
    
    if([self.searchBarDelegate respondsToSelector:@selector(searchTableViewSearchBarTextDidBeginEditing:)]){
        [self.searchBarDelegate searchTableViewSearchBarTextDidBeginEditing:searchBar];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

//代理方法
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"语音按钮");
    if([self.searchBarDelegate respondsToSelector:@selector(searchTableViewRightButtonDidClickWith:)]){
        [self.searchBarDelegate searchTableViewRightButtonDidClickWith:searchBar];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
