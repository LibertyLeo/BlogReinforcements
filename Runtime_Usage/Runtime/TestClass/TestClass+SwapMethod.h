//
//  TestClass+SwapMethod.h
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import "TestClass.h"

@interface TestClass (SwapMethod)

/**
 实现交换方法的方法
 */
- (void)swapMethod;

/**
 将被交换的方法
 */
- (void)replaceMethod;

@end
