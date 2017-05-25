//
//  main.m
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import "TestClass+Category.h"
#import "TestClass+SwapMethod.h"
#import "TestClass+AssociatedObejct.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
#if 0
        NSString *className = [RuntimeKit captureClassName:[TestClass class]];
        NSLog(@"\n测试类的类名为%@\n", className);

        NSArray *ivarList = [RuntimeKit captureIvarList:[TestClass class]];
        NSLog(@"\n测试类的成员变量列表%@\n", ivarList);

        NSArray *propertyList = [RuntimeKit capturePropertyList:[TestClass class]];
        NSLog(@"\n测试类的属性列表%@\n", propertyList);

        NSArray *methodList = [RuntimeKit captureMethodList:[TestClass class]];
        NSLog(@"\n测试类的方法列表%@\n", methodList);

        NSArray *protocolList = [RuntimeKit captureProtocolList:[TestClass class]];
        NSLog(@"\n测试类的协议列表%@\n", protocolList);
#endif
        
#if 1
        TestClass *test = [TestClass new];
//        [TestClass classMethod:@"test"];
//        [test publicInstanceMethodA:@"testA" withValueB:@"testB"];
//        [test publicInstanceMethodB];
//        [test performSelector:@selector(messMethod:) withObject:@"unknown method"];
        
        //  进行方法替换
        [test swapMethod];
        [test exchangeMethodA];
        /*
         如果方法没实现交换, methodWait将一直循环本身, 造成崩溃,
         如果交换成功, 则执行的是被交换过来的方法, 而不是本身,
         故会有终点
         */
        [test replaceMethod];
#endif
    }
    return 0;
}
