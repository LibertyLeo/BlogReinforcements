//
//  RuntimeKit.h
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface RuntimeKit : NSObject

/**
 获取类名
 
 @param cls Class
 @return 类名
 */    
+ (NSString *)captureClassName:(Class)cls;

/**
 获取类的成员变量
 
 @param cls Class
 @return 成员变量数组, 由成员变量类型与名称构成的若干个字典
 */
+ (NSArray *)captureIvarList:(Class)cls;

/**
 获取类的属性列表, 包括公有属性、私有属性、延展中增加的属性
 
 @param cls Class
 @return 属性列表数组
 */
+ (NSArray *)capturePropertyList:(Class)cls;

/**
 获取类的实例方法列表: 包括setter、getter, 对象方法等, 但不包括类方法
 
 @param cls Class
 @return 实例方法数组
 */
+ (NSArray *)captureMethodList:(Class)cls;

/**
 获取类的协议列表
 
 @param cls Class
 @return 协议列表数组
 */
+ (NSArray *)captureProtocolList:(Class)cls;

/**
 向类添加新的方法与实现
 
 @param cls Class
 @param methodName 方法名
 @param methodIMPName 实现方法的方法名
 */
+ (void)addIntoClass:(Class)cls method:(SEL)methodName methodIMP:(SEL)methodIMPName;

/**
 在同一个类中进行方法的替换
 
 @param cls Class
 @param methodAName 待替换A的方法名
 @param methodBName 待替换B的方法名
 */
+ (void)swapMethod:(Class)cls methodA:(SEL)methodAName methodB:(SEL)methodBName;

@end
