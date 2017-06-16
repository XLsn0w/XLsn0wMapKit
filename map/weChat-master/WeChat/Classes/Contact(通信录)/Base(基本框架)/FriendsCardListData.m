//
//  FriendsCardListData.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/2/1.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "FriendsCardListData.h"
#import "ServersConfig.h"

@interface FriendsCardListData ()

@end

@implementation FriendsCardListData

static id _instance;

// 实现创建单例对象的类方法
+ (instancetype)sharedFriendsCardListData {
    
    static dispatch_once_t onceToken;
    
    /**
     dispatch_once  一次性执行
     它是安全的，系统已经自动帮我们加了锁，所以在多个线程抢夺同一资源的时候，也是安全的
     */
    
    dispatch_once(&onceToken, ^{
        NSLog(@"---once---");
        
        // 这里也会调用到 allocWithZone 方法
        _instance = [[self alloc] init];
    });
    return _instance;
}

#warning 一般单例直接share，但是写上 copy 和 alloc 更加严谨
// 利用alloc 创建对象也要返回单例
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
#warning 这里必须调用父类的方法，把空间传给父类，让父类进行空间的分配，若还用[[self allic] init] 则会产生死循环
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

// 遵守NSCopying 协议,ios7 以后不遵守也可以
- (id)copyWithZone:(NSZone *)zone {
    
    // 这里直接返回对象，因为既然是赋值，说明已经通过上面两种方式之一开始创建了
    return _instance;
}

- (void)loadFriendsCardList{
    // 1.上下文
    NSManagedObjectContext *context = [XMPPTools sharedXMPPTools].rosterStorage.mainThreadManagedObjectContext;
    // 2.查询表
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    // 3.设置过滤与排序
    //从服务器抓取数据
    XMPPJID *jid = [XMPPJID jidWithUser:[PersionModel sharedPersionModel].wechatID domain:LOCALHOSTIP resource:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jid];
    request.predicate = predicate;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    
    // 4.执行请求获取数据
    NSArray *friends = [context executeFetchRequest:request error:nil];
    
    DebugLog(@"%@",friends);
    
    for(NSInteger index = 0;index < friends.count;index ++){
        XMPPUserCoreDataStorageObject *friend = friends[index];
        
        DebugLog(@"%@,%@,%lu,%lu,%@,%@",friend.jidStr,friend.nickname,friends.count,friend.section,friend.sectionNum,friend.sectionName);
    }
    
    
}
@end
