//
//  WeChatCellPhotoView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatCellPhotoView.h"
#import "PhotoBrowser.h"
//#import "UIView+AutoLayout.h"

#define WeChatDefaultMaxPictureNum  9

@interface WeChatCellPhotoView () <PhotoBrowserDelegate>
@property (nonatomic,strong) NSArray *images;
@end

@implementation WeChatCellPhotoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setCellPhotoView];
    }
    return self;
}

- (void)setCellPhotoView{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for(NSInteger index = 0; index < WeChatDefaultMaxPictureNum; index++){
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        [imageView setUserInteractionEnabled:YES];
        [imageView setTag:index];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [images addObject:imageView];
    }
    self.images = [images copy];
}

- (void)setPicPathString:(NSArray *)picPathString{
    _picPathString = picPathString;
    
    for (long index = picPathString.count; index < self.images.count; index++) {
        UIImageView *imageView = [self.images objectAtIndex:index];
        imageView.hidden = YES;
    }
    
    if (picPathString.count == 0) {
        self.height = 0;
        return;
    }
    
    CGFloat width = [self widthForPicturePath:picPathString];
    CGFloat height = 0;
    
    if(picPathString.count == 1){
        UIImage *image = [UIImage imageNamed:picPathString.firstObject];
        //比例缩放
        if(image.size.width){
            height = image.size.height /image.size.width * width;
        }
    }else{
        height = width;
    }
    
    long rowCount = [self rowCountForPicturePath:picPathString];
    CGFloat margin = 5;
    //取出图片
    [picPathString enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columIndex = idx % rowCount;
        long rowIndex = idx / rowCount;
        
        UIImageView *imageView = [self.images objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columIndex * (width + margin), rowIndex * (height + margin), width, height);
    }];
    
    //求得显示内容区大小
    CGFloat contentWidth = rowCount * width + (rowCount - 1) * margin;
    int columCount = ceilf(picPathString.count * 1.0 / rowCount);
    CGFloat contentHeight = columCount * height + (columCount - 1) * margin;
    
    self.width = contentWidth;
    self.height = contentHeight;
    
    [self setHeight:contentHeight];
    [self setWidth:contentWidth];
    //设置图片布局区大小
    DebugLog(@"picture view size %@",NSStringFromCGSize(self.size));
    
}


#define DefaultSinglePictureWidth    120
#define DefaultScreenWidthSize       [UIScreen mainScreen].bounds.size.width
//图片默认宽度适配
- (CGFloat)widthForPicturePath:(NSArray *) path{
    if(path.count == 1){
        return DefaultSinglePictureWidth;
    }else{
        //适配3.5寸屏与其他屏
        return  DefaultScreenWidthSize > 320 ?  80: 70;
    }
}
//一个单元格显示的图片适配
- (CGFloat)rowCountForPicturePath:(NSArray *) path{
    if(path.count < 3){
        return path.count;
    }else if(path.count <= 4){
        return 2;
    }else{
        return 3;
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    PhotoBrowser *browser = [[PhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathString.count;
    browser.delegate = self;
    [browser show];
}

#pragma mark - PhotoBrowserDelegate
- (NSURL *)photoBrowser:(PhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathString[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
