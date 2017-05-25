//
//  TestClass+AssociatedObejct.m
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import "TestClass+AssociatedObejct.h"
#import "RuntimeKit.h"

@interface TestClass ()

/** 添加的动态属性*/
@property (nonatomic, copy) NSString *dynamicProperty;

@end

static char dynamicKey;

@implementation TestClass (AssociatedObejct)

#pragma mark - 关联动态属性

/**
 setter方法
 
 @param dynamicProperty 需要关联的属性
 */
- (void)setDynamicProperty:(NSString *)dynamicProperty {
    objc_setAssociatedObject(self, &dynamicKey, dynamicProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 getter方法
 
 @return 关联的属性的值
 */
- (NSString *)dynamicProperty {
    return objc_getAssociatedObject(self, &dynamicKey);
}

@end
