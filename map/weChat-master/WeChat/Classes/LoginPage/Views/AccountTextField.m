//
//  AccountTextField.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AccountTextField.h"
#import "SplitLineView.h"

@interface AccountTextField ()
@property (nonatomic,weak)SplitLineView *upLine;
@property (nonatomic,weak)SplitLineView *downLine;
@property (nonatomic,weak)UILabel *textArea;
@property (nonatomic,assign)CGFloat textInputX;

@end

@implementation AccountTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (AccountTextField *)accountTextFieldWithText:(NSString *) text andWithPlaceHolderText:(NSString *) placeText andWithTextStartX:(CGFloat) x{
    AccountTextField *textField = [[AccountTextField alloc] init];
    [textField setPhoneNumberTextFieldViewWithText:text andWithPlaceHolderText:placeText andWithTextStartX:(CGFloat) x];
    
    return textField;
}

- (void)setPhoneNumberTextFieldViewWithText:(NSString *) text andWithPlaceHolderText:(NSString *) placeText andWithTextStartX:(CGFloat) x{
    NSLog(@"%f",self.bounds.size.width);
    SplitLineView *upLine = [[SplitLineView alloc] init];
    [self addSubview:upLine];
    self.upLine = upLine;
    
    SplitLineView *downLine = [[SplitLineView alloc] init];
    [self addSubview:downLine];
    self.downLine = downLine;
    
    
    UILabel *textArea = [[UILabel alloc] init];
    [textArea setText:text];
  

    [self addSubview:textArea];
    self.textArea = textArea;
    
    UITextField *textInput = [[UITextField alloc] init];
    [textInput setPlaceholder:placeText];
    [textInput setKeyboardType:UIKeyboardTypeDefault];
    
    [textInput setTintColor:[UIColor greenColor]];
    [self addSubview:textInput];
    self.textInput = textInput;
    self.textInputX = x;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [textArea setFont:[UIFont systemFontOfSize:30.0]];
        [textInput setFont:[UIFont systemFontOfSize:30.0]];
    }else{
        [textArea setFont:[UIFont systemFontOfSize:16.0]];
        [textInput setFont:[UIFont systemFontOfSize:16.0]];
    }
}


- (void)layoutSubviews{
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.upLine setFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
        
        [self.downLine setFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];

        
        [self.textArea setFrame:CGRectMake(20, 0, self.textInputX - 10, self.bounds.size.height)];
        [self.textInput setFrame:CGRectMake(self.textInputX, 0, self.bounds.size.width - self.textInputX, self.bounds.size.height)];
     }else{
         [self.upLine setFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
         
         [self.downLine setFrame:CGRectMake(0, self.height - 1, self.bounds.size.width, 1)];
         
         
         [self.textArea setFrame:CGRectMake(10, 0, self.textInputX - 10, self.bounds.size.height)];
         [self.textInput setFrame:CGRectMake(self.textInputX, 0, self.bounds.size.width - self.textInputX, self.bounds.size.height)];
     }
}

@end
