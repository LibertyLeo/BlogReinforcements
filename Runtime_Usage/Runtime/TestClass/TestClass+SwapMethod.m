//
//  TestClass+SwapMethod.m
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import "TestClass+SwapMethod.h"
#import "RuntimeKit.h"

@implementation TestClass (SwapMethod)

- (void)swapMethod {
    [RuntimeKit swapMethod:[self class]
                   methodA:@selector(exchangeMethodA)
                   methodB:@selector(replaceMethod)];
}

- (void)replaceMethod {
    //  此时调用的不是本身, 而是exchangeMethodA
    [self replaceMethod];
    NSLog(@"Now you can add something in methodA!");
}

@end
