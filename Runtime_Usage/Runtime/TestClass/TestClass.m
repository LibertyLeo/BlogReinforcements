//
//  TestClass.m
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import "TestClass.h"
#import "RuntimeKit.h"

@interface ExtClass : NSObject

- (void)extensionMethod:(NSString *)value;

@end

@implementation ExtClass

- (void)extensionMethod:(NSString *)value {
    NSLog(@"ExtClass method: %@", value);
}

@end

@interface TestClass () {
    NSInteger _varA;
    int _varB;
    BOOL _varC;
    float _varD;
    double _varE;
}

@property (nonatomic, strong) NSNumber *privatePropertyA;
@property (nonatomic, strong) NSMutableArray *privatePropertyB;
@property (nonatomic, copy) NSDictionary *privatePropertyC;

@end

@implementation TestClass

+ (void)classMethod:(NSString *)value {
    NSLog(@"publicClassMethodWithValue: <%@>", value);
}

- (void)publicInstanceMethodA:(NSString *)valueA withValueB:(NSString *)valueB {
    NSLog(@"publicInstanceMethodA valueA: <%@> valueB: <%@>", valueA, valueB);
}

- (void)publicInstanceMethodB {
    NSLog(@"publicInstanceMethodB");
}

- (void)privateInstanceMethodA {
    NSLog(@"privateInstanceMethodA");
}

- (void)privateInstanceMetehodB {
    NSLog(@"privateInstanceMethodB");
}

#pragma mark - 动态交换方法时的实现
- (void)exchangeMethodA {
    NSLog(@"exchangeMethodA");
}

#pragma mark - 运行时方法拦截
- (void)unknowMethod:(NSString *)value {
    //  运行时找不到新添加的方法实现, 对其进行拦截, 并进行替换
    NSLog(@"Method is unknown, insert some words here: <%@>", value);
}

/**
 未找到SEL的IML实现时会执行的方法
 
 @param sel 方法选择器, 当前对象调用但是找不到IML的SEL
 @return 找到其他执行方法, 如自定义方法, 会返回YES, 否则返回NO
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //  如果返回NO, 则继续执行forwardingTargetForSelector:方法
    [RuntimeKit addIntoClass:[self class] method:sel methodIMP:@selector(unknowMethod:)];
    return YES;
}

/**
 如果对象不存在SEL而传给其他对象时, 进入消息转发
 
 @param aSelector 当前类中不存在的SEL
 @return 消息转发该SEL所在的类
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    //  如果resolveInstanceMethod:方法中不进行处理, 即返回NO, 此时进入消息转发
    return [ExtClass new];
}

/**
 如果不实现消息转发, 则交由自身进行处理, 即消息转发时返回的是self, 则执行本签名方法
 
 @param aSelector 需要获取参数以及返回数据类型的方法
 @return 方法的签名, 如果返回nil, 则程序崩溃
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //  查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@;"];
    }
    return signature;
}

/**
 消息接收对象无法正常响应消息时会被调用
 
 @param anInvocation 调用者, 即需要响应相应方法的对象
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    ExtClass *forwardClass = [ExtClass new];
    SEL sel = anInvocation.selector;
    /*
     如果消息转发的类响应了实现方法, 则对其调用, 否则,
     发现不了可以实现方法的调用者, 程序崩溃
     */
    if ([forwardClass respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
