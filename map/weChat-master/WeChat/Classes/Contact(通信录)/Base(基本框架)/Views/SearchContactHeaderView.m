//
//  SearchContactHeaderView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchContactHeaderView.h"
#import "UIImage+ColorImage.h"


@interface SearchContactHeaderView ()<UISearchBarDelegate>

@end

@implementation SearchContactHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setSearchContactHeaderView];
    }
    return self;
}



- (void)setSearchContactHeaderView{
    [self setBackgroundColor:[UIColor blueColor]];
}


@end
