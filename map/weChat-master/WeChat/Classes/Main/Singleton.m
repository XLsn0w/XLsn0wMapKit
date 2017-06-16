//
//  Singleton.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

//#if __has_feature(objc_arc) //ARC环境下

#if __has_feature(objc_arc)

#define singleton_m(name) static id _instance; \
+ (instancetype)shared##name{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
}

#else  //MRC环境下

#define singleton_m(name) static id _instance; \
+ (instancetype)shared##name{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone{ \
return _instance; \
} \
\
- (oneway void)release{ \
\
} \
\
- (instancetype)retain{ \
return _instance; \
} \
\
- (instancetype)autorelease{ \
return _instance; \
} \
\
- (NSUInteger)retainCount{ \
return 1; \
}

#endif
@end
