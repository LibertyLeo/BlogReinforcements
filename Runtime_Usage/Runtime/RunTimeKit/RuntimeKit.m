//
//  RuntimeKit.m
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit

/**
 获取类名
 
 @param cls 对应类
 @return 类名
 */
+ (NSString *)captureClassName:(Class)cls {
    const char *className = class_getName(cls);
    return [NSString stringWithUTF8String:className];
}

/**
 获取类的成员变量
 
 @param cls 对应类
 @return 成员变量数组, 由成员变量类型与名称构成的若干个字典
 */
+ (NSArray *)captureIvarList:(Class)cls {
    unsigned int count = 0;
    //  该函数返回一个由Ivar指针组成的数组
    Ivar *ivarList = class_copyIvarList(cls, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        //  分别获取变量名称与变量类型
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        dic[@"ivarType"] = [NSString stringWithUTF8String:ivarType];
        //  添加到可变字典中
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表, 包括公有属性、私有属性、延展中增加的属性
 
 @param cls 对应类
 @return 属性列表数组
 */
+ (NSArray *)capturePropertyList:(Class)cls {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(cls, &count);
    
    NSMutableArray *mutableLlist = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableLlist addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableLlist];
}

/**
 获取类的实例方法列表: 包括setter、getter, 对象方法等, 但不包括类方法
 
 @param cls 对应类
 @return 实例方法数组
 */
+ (NSArray *)captureMethodList:(Class)cls {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的协议列表
 
 @param cls Class
 @return 协议列表数组
 */
+ (NSArray *)captureProtocolList:(Class)cls {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(cls, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:mutableList];
}

/**
 向类添加新的方法与实现
 
 @param cls Class
 @param methodName 方法名
 @param methodIMPName 实现方法的方法名
 */
+ (void)addIntoClass:(Class)cls method:(SEL)methodName methodIMP:(SEL)methodIMPName {
    Method method = class_getInstanceMethod(cls, methodIMPName);
    IMP methodIMP = method_getImplementation(method);
    const char *methodType = method_getTypeEncoding(method);
    class_addMethod(cls, methodName, methodIMP, methodType);
}

/**
 在同一个类中进行方法的替换
 
 @param cls Class
 @param methodAName 待替换A的方法名
 @param methodBName 待替换B的方法名
 */
+ (void)swapMethod:(Class)cls methodA:(SEL)methodAName methodB:(SEL)methodBName {
    Method methodA = class_getInstanceMethod(cls, methodAName);
    Method methodB = class_getInstanceMethod(cls, methodBName);
    method_exchangeImplementations(methodA, methodB);
}

@end
