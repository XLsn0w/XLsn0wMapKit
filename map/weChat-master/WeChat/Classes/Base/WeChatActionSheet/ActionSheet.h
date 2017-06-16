//
//  ActionSheet.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/25.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActionSheet;

@protocol ActionSheetDelegate <NSObject>

@optional;
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)actionSheet:(ActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)actionSheet:(ActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

typedef   void(^ActionSheetEndDismissBlock)();
@interface ActionSheet : UIView

@property(nonatomic, assign, readonly) NSInteger numberOfButtons;

@property(nonatomic, assign, readonly) NSInteger cancelButtonIndex;

@property(nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

@property (nonatomic, weak) id<ActionSheetDelegate> delegate;

@property (nonatomic,copy)ActionSheetEndDismissBlock block;

- (id)initWithTitle:(NSString *)title
           delegate:(id<ActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)show;

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end
