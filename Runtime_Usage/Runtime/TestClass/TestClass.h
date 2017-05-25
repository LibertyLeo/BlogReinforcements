//
//  TestClass.h
//  Runtime
//
//  Created by Leo_Lei on 3/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 遵循了两个协议, 但是不是重点, 故不对协议方法进行实现
 */
@interface TestClass : NSObject<NSCoding, NSCopying>

@property (nonatomic, copy) NSArray *publicPropertyA;
@property (nonatomic, copy) NSString *publicPropertyB;

+ (void)classMethod:(NSString *)value;

- (void)publicInstanceMethodA:(NSString *)valueA withValueB:(NSString *)valueB;
- (void)publicInstanceMethodB;
- (void)exchangeMethodA;

@end
