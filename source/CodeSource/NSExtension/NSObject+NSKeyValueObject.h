//
//  NSObject+KeyValue2object.h
//  NSExtension
//
//  Created by DexSinis on 15/9/23.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSKeyValueObject)
+ (instancetype)objectWithKeyValues:(id)keyValues;
@end
