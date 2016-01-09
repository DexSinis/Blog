//
//  NSObject+KeyValue2object.m
//  NSExtension
//
//  Created by DexSinis on 15/9/23.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSObject+NSKeyValueObject.h"
#import "NSObject+Property.h"
#import "NSProperty.h"
#import "NSPropertyType.h"
@implementation NSObject (NSKeyValueObject)

+ (instancetype)objectWithKeyValues:(id)keyValues{
    if (!keyValues) return nil;
    return [[[self alloc] init] setKeyValues:keyValues];
}

- (instancetype)setKeyValues:(id)keyValues{
    NSArray *propertiesArray = [self.class properties];
    for (NSProperty *property in propertiesArray) {
        NSPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        if (type.isBoolType) {
            NSLog(@"bool");
        }else if (type.isIdType){
            NSLog(@"ID");
        }else if (type.isNumberType){
            NSLog(@"Number");
        }else{
            NSLog(@"%@",typeClass);
        }
    }
    return self;
}

@end
