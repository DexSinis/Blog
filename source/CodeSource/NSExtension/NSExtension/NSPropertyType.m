//
//  NSPropertyType.m
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSPropertyType.h"
#import "NSConst.h"
#import "NSProperty.h"
#import "NSObject+Property.h"
@implementation NSPropertyType
/**
 *  用于缓存一些常用类型的type，避免多次调用
 */
static NSMutableDictionary *cachedTypes_;

+ (void)load
{
    cachedTypes_ = [NSMutableDictionary dictionary];
}

+ (instancetype)propertyTypeWithAttributeString:(NSString *)string
{
    return [[self alloc] initWithTypeString:string];
}

- (instancetype)initWithTypeString:(NSString *)string
{
    NSUInteger loc = 1;
    NSUInteger len = [string rangeOfString:@","].location -loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
    if (!cachedTypes_[typeCode]) {
        self = [super init];
        [self getTypeCode:typeCode];
        cachedTypes_[typeCode] = self;
    }else
    {
        return cachedTypes_[typeCode];
    }
    return self;
    
}

- (void)getTypeCode:(NSString *)code
{
    if ([code isEqualToString:NSPropertyTypeId]) {
        _idType = YES;
    }else if (code.length > 3 && [code hasPrefix:@"@\""])
    {
         _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
                _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
}


@end
