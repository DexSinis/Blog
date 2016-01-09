//
//  NSProperty.m
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSProperty.h"
#import "NSPropertyType.h"

@implementation NSProperty
+ (instancetype)propertyWithProperty:(objc_property_t)property{
    return  [[NSProperty alloc] initWithProperty:property];
}


- (instancetype)initWithProperty:(objc_property_t)property{
    if (self = [super init]) {
        _name = @(property_getName(property));
        
        _type = [NSPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];;
    }
    return self;
}
@end
