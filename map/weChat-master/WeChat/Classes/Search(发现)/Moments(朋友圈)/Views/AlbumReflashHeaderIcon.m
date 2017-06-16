//
//  AlbumReflashHeaderIcon.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AlbumReflashHeaderIcon.h"
#import "MomentsHeaderView.h"

#define RefreshHeaderRotateAnimationKey @"RotateAnimationKey"



@interface AlbumReflashHeaderIcon (){
    //基础核心动画
    CABasicAnimation *_rotateAnimation;
    CGFloat criticalY ;
    CGFloat oldY;
    CGFloat oldState;
    CGFloat maxYoffset;
}

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation AlbumReflashHeaderIcon
@synthesize refreshState = _refreshState;


+ (instancetype)refreshHeaderWithCenter:(CGPoint)center{
    AlbumReflashHeaderIcon *header = [[AlbumReflashHeaderIcon alloc] init];
    DebugLog(@"refresh center no move");
    
    header.center = center;
    header.imageView.transform = CGAffineTransformIdentity;
    
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setAlbumHeaderIcon];
    }
    return self;
}

- (void)setAlbumHeaderIcon{
    criticalY = -60.0f;
    oldY = 0;
    oldState =0;
    maxYoffset = 0;
    
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    self.bounds = imageView.bounds;
    
    [self addSubview:imageView];
    self.imageView = imageView;
    
    [self setUserInteractionEnabled:YES];
    [self.scrollView setUserInteractionEnabled:YES];
    
    weak_self weakSelf = self;
    [self setLongPressActionWithBlock:^{
        weakSelf.refreshingBlock();
    }];
    
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    [_rotateAnimation setKeyPath:@"transform.rotation.z"];
    [_rotateAnimation setFromValue: @0];
    [_rotateAnimation  setToValue:@(M_PI * 6)];
    [_rotateAnimation  setDuration: 2.5];
    [_rotateAnimation  setRepeatCount:1];
    
    
    NSLog(@"----------6------------");
}

- (void)setRefreshState:(RefreshViewState)refreshState{

    _refreshState = refreshState;

    if (refreshState == RefreshViewStateRefreshing) {
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
//        NSLog(@"----------4------------");
        [self.layer addAnimation:_rotateAnimation forKey:RefreshHeaderRotateAnimationKey];
    } else if (refreshState == RefreshViewStateNormal) {
        
        [self.layer removeAnimationForKey:RefreshHeaderRotateAnimationKey];
        [UIView animateWithDuration:0.5 animations:^{
           self.transform = CGAffineTransformIdentity;
        }];
//        NSLog(@"----------5------------");
    }
}


- (void)updateRefreshHeaderWithOffsetY:(CGFloat)y{
    CGFloat rotateValue = 0;
    if(self.tapGesture.state == UIGestureRecognizerStateRecognized){
        if(y * (-criticalY) < (-criticalY)*TopViewOnHeaderViewHeight){
            rotateValue = y *(-criticalY) *(0.1* M_PI) *0.5/TopViewOnHeaderViewHeight;
            
        }
        
        if((y - oldY) < 0){
            rotateValue = -ABS(rotateValue);
        }else{
            rotateValue = ABS(rotateValue);
        }
//        NSLog(@"1 : y = %lf,rotateValue = %lf",y,rotateValue);
    }else{
        if(!y){
            rotateValue = 100 *(-criticalY) *(0.1 * M_PI)*0.5/TopViewOnHeaderViewHeight;
//            NSLog(@"3 : y = %lf,rotateValue = %lf",y,rotateValue);
      
        }else if(y * (-criticalY) < (-criticalY)*TopViewOnHeaderViewHeight){
            rotateValue = y *(-criticalY) *(0.1 * M_PI)*0.5/TopViewOnHeaderViewHeight;
//            NSLog(@"2 : y = %lf,rotateValue = %lf",y,rotateValue);
        }
    }
    
  
    if(oldY != y){
        oldY = y;
    }
    
    
    if ((y - TopViewOnHeaderViewHeight) < criticalY) {
        
        y = criticalY;
        
        if (self.scrollView.isDragging && self.refreshState != RefreshViewStateWillRefresh) {
//            NSLog(@"----------7------------");
            self.refreshState = RefreshViewStateWillRefresh;
        } else if (!self.scrollView.isDragging && self.refreshState == RefreshViewStateWillRefresh) {
            self.refreshState = RefreshViewStateRefreshing;
//            NSLog(@"----------8------------");
        }
    }else{
        if(y >= 0){
           y = (y - TopViewOnHeaderViewHeight);
        }
    }
    
    if (self.refreshState == RefreshViewStateRefreshing) return;
    
//    NSLog(@"4 : y = %lf,rotateValue = %lf",y,rotateValue);
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 1, -y);
    transform = CGAffineTransformRotate(transform, rotateValue);
    
    self.transform = transform;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//     NSLog(@"----------3------------");
    if (![keyPath isEqualToString: BaseRefreshViewObserveKeyPath]&&![keyPath isEqualToString: BaseRefreshViewObserveDragginKeyPath]){
        return;
    }

    
    if((self.scrollView.contentOffset.y - TopViewOnHeaderViewHeight) <= -criticalY){
        
        if(maxYoffset < -criticalY){
            maxYoffset = -(self.scrollView.contentOffset.y - TopViewOnHeaderViewHeight) ;
        }
    
        if(self.scrollView.isDragging){
            if(oldState){
                self.refreshState = RefreshViewStateWillRefresh;
                oldState = 0;
            }
            [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
          }else{
           
              if(!oldState){

            
                  if(maxYoffset >= -criticalY){
                     oldState = 1;
                      [self updateRefreshHeaderWithOffsetY:0];
                    
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                         
                          [UIView animateWithDuration:1.5 animations:^{
     
                          } completion:^(BOOL finished) {
                              if(self.scrollView.isDragging){
                                  [_rotateAnimation  setRepeatCount:MAXFLOAT];
                                  
                              }else{
                                  
                                  if(_rotateAnimation.repeatCount != 1){
                                      [_rotateAnimation  setRepeatCount:1];
                                  }
                                  
                                  [self updateRefreshHeaderWithOffsetY:-criticalY*2];
                                  self.refreshState = RefreshViewStateWillRefresh;
                                  
                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                      [UIView animateWithDuration:0.5 animations:^{
                                          [self updateRefreshHeaderWithOffsetY:-criticalY*2];
                                          self.refreshState = RefreshViewStateNormal;
                                          NSLog(@"...........执行完成........");
                                          maxYoffset = 0;

                                      }];
                                  });
                              }
                              
                          }];
                          
                      });
                  }else{
                      if(_rotateAnimation.repeatCount != 1){
                          [_rotateAnimation  setRepeatCount:1];
                      }
                      
                      self.refreshState = RefreshViewStateWillRefresh;
                      
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          [UIView animateWithDuration:0.5 animations:^{
                              [self updateRefreshHeaderWithOffsetY:-criticalY*2];
                              self.refreshState = RefreshViewStateNormal;
                              maxYoffset = 0;
                          }];
                      });
                  }
               
              }
          }
        
      }else{
          [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
      }
    

}


@end
