//
//  CFProtocolDispatcher.m
//  CFProtocolDispatcherDemo
//
//  Created by wjc on 2017/5/26.
//  Copyright © 2017年 CityFire. All rights reserved.
//

#import "CFProtocolDispatcher.h"
#import <objc/runtime.h>

struct objc_method_description MethodDescriptionForSELInProtocol(Protocol *protocol, SEL sel) {
    struct objc_method_description description = protocol_getMethodDescription(protocol, sel, YES, YES);
    if (description.types) {
        return description;
    }
    description = protocol_getMethodDescription(protocol, sel, NO, YES);
    if (description.types) {
        return description;
    }
    return (struct objc_method_description){NULL, NULL};
}

BOOL ProtocolContainSel(Protocol *protocol, SEL sel) {
    return MethodDescriptionForSELInProtocol(protocol, sel).types ? YES : NO;
}

@interface ImplementorContext : NSObject

@property (nonatomic, weak) id implementor;

@end

@implementation ImplementorContext

@end

@interface CFProtocolDispatcher ()

@property (nonatomic, strong) Protocol *protocol;

@property (nonatomic, strong) NSArray *implementors;

@property (nonatomic, strong) NSNumber *indexImplementor;

@end

@implementation CFProtocolDispatcher

#pragma mark - Initlized Method

+ (instancetype _Nullable )dispatcherProtocol:(Protocol *_Nullable)protocol toImplementors:(NSArray *_Nullable)implementors {
    return [[CFProtocolDispatcher alloc] initWithProtocol:protocol toImplementors:implementors];
}

+ (instancetype _Nullable )dispatcherProtocol:(nullable Protocol *)protocol withIndexImplementor:(NSNumber *_Nullable)indexImplementor toImplementors:(NSArray *_Nullable)implementors {
    return [[CFProtocolDispatcher alloc] initWithProtocol:protocol withIndexImplementor:indexImplementor toImplemertors:implementors];
}

- (instancetype)initWithProtocol:(Protocol *)protocol toImplementors:(NSArray *)implementors {
    if (self = [super init]) {
        self.protocol = protocol;
        NSMutableArray *implementorContexts = [NSMutableArray arrayWithCapacity:implementors.count];
        [implementors enumerateObjectsUsingBlock:^(id  _Nonnull implementor, NSUInteger idx, BOOL * _Nonnull stop) {
            ImplementorContext *implementorContext = [ImplementorContext new];
            implementorContext.implementor = implementor;
            [implementorContexts addObject:implementorContext];
            //  为什么关联个 ProtocolDispatcher 属性？
            // "自释放"，ProtocolDispatcher 并不是一个单例，而是一个局部变量，当implemertor释放时就会触发ProtocolDispatcher释放。
            // key 需要为随机，否则当有两个分发器是，key 会被覆盖，导致第一个分发器释放。所以 key = _cmd 是不行的。
            void *key = (__bridge void *)([NSString stringWithFormat:@"%p",self]);
            objc_setAssociatedObject(implementor, key, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
        self.implementors = implementorContexts;
    }
    return self;
}

- (instancetype)initWithProtocol:(Protocol *)protocol withIndexImplementor:(NSNumber *)indexImplementor toImplemertors:(NSArray *)implementors {
    if ([self initWithProtocol:protocol toImplementors:implementors]) {
        self.indexImplementor = indexImplementor;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - 重写NSOjbect以下方法

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (!ProtocolContainSel(self.protocol, aSelector)) {
        return [super respondsToSelector:aSelector];
    }
    
    for (ImplementorContext *implementorContext in self.implementors) {
        if ([implementorContext.implementor respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (!ProtocolContainSel(self.protocol, aSelector)) {
        return [super methodSignatureForSelector: aSelector];
    }
    
    struct objc_method_description methodDescription = MethodDescriptionForSELInProtocol(self.protocol, aSelector);
    return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    if (!ProtocolContainSel(self.protocol, aSelector)) {
        [super forwardInvocation: anInvocation];
        return;
    }
    
    if (self.indexImplementor) {
        for (NSInteger i = 0; i < [self.implementors count]; i++) {
            ImplementorContext *implemertorContext = [self.implementors objectAtIndex:i];
            if (i == self.indexImplementor.integerValue && [implemertorContext.implementor respondsToSelector:aSelector]) {
                [anInvocation invokeWithTarget:implemertorContext.implementor];
            }
        }
    }
    else {
        for (ImplementorContext *implementorContext in self.implementors) {
            if ([implementorContext.implementor respondsToSelector:aSelector]) {
                [anInvocation invokeWithTarget:implementorContext.implementor];
            }
        }
    }
}

@end
