//
//  SearchTableViewController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseGroupTableViewController.h"

typedef enum{
    UISearchTextFieldRightButtonDefault = 0,
    UISearchTextFieldRightButtonCustomer = 1,
}UISearchTextFieldRightButtonIconType;

typedef enum{
    UISearchTextFieldDefault = 0,
    UISearchTextFieldBorderColorGray = 1,
    UISearchTextFieldBorderColorDarkGreen = 2,
    UISearchTextFieldBorderColorDarkRed   = 3,
    UISearchTextFieldCustomer = 4,
}UISearchTextFieldType;

@protocol SearchTableViewControllerDelegate <NSObject>

@optional

- (void)searchTableViewRightButtonDidClickWith:(UISearchBar *)searchBar;
- (void)searchTableViewSearchBarTextDidBeginEditing:(UISearchBar *)searchBar;

@end

@interface SearchTableViewController : BaseGroupTableViewController

@property (nonatomic,weak)id<SearchTableViewControllerDelegate> searchBarDelegate;
@property (nonatomic,strong)UIViewController *resultController;

- (void)searchTableViewClearButton;

- (void)searchTableViewCancelButtonWithName:(NSString *) name;

- (void)searchTableViewTextFieldCursorWithColor:(UIColor *)color;

- (void)searchTableViewHidesNavigationBarDuringPresentation:(BOOL) state;

- (void)searchTableViewCustomerTextFieldWithBorderColor:(UIColor *) color andTextFieldStyle:(UISearchTextFieldType) type;

- (void)searchTableViewTextFieldRightButtonNormalImageWithName:(NSString *)normalName andHighledImageName:(NSString *) hightledName andButtonStyle:(UISearchTextFieldRightButtonIconType) type andPlaceHolder:(NSString *) placeText;
@end
