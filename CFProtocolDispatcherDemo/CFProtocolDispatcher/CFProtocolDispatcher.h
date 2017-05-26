//
//  CFProtocolDispatcher.h
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ABProtocolDispatcher(__protocol__, index, ...)  \
    [CFProtocolDispatcher dispatcherProtocol:@protocol(__protocol__)  \
        withIndexImplemertor:index \
            toImplemertors:[NSArray arrayWithArray:__VA_ARGS__, nil]]

#define ProtocolDispatcher(__protocol__, ...)  \
    [CFProtocolDispatcher dispatcherProtocol:@protocol(__protocol__)  \
        toImplementors:[NSArray arrayWithObjects:__VA_ARGS__, nil]]

@interface CFProtocolDispatcher : NSObject

+ (instancetype _Nullable )dispatcherProtocol:(Protocol *_Nullable)protocol toImplementors:(NSArray *_Nullable)implementors;

/**
 协议分发器
 @param protocol 遵循的协议;
 @param indexImplementor AB 需要执行的协议实现实例数组下标;
 若传入 对应的 NSNumber 数字, 则调用改实现实例的协议方法;
 若传入 nil,则调用全部的遵循协议的实现实例
 @param implementors 所有需要遵循协议的实现实例;
 @return 协议分发器;
 */
+ (instancetype _Nullable )dispatcherProtocol:(nullable Protocol *)protocol withIndexImplementor:(NSNumber *_Nullable)indexImplementor toImplementors:(NSArray *_Nullable)implementors;

@end
