//
//  Singleton.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
#define singleton_h(name) + (instancetype)shared##name;
@end
