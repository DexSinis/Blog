//
//  NSObject.m
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
#import "NSProperty.h"
#import "NSPropertyType.h"
typedef struct property_t {
    const char *name;
    const char *attributes;
} *propertyStruct;

@implementation NSObject (Property)
//保存foundation框架里面的类
static NSSet *foundationClasses_;
/**
 *  ,很多的类都不止一次调用了获取属性的方法,对于一个类来说,要获取它的全部属性,只要获取一次就够了.获取到后将结果缓存起来,下次就不必进行不必要的计算.
 */
static NSMutableDictionary *cachedProperties_;

+ (void)load
{
    cachedProperties_ = [NSMutableDictionary dictionary];
}

+ (NSSet *)foundationClasses
{
    if (foundationClasses_ == nil) {
        
        foundationClasses_ = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)isClassFromFoundation:(Class)c{
    if (c == [NSObject class]) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

+(NSArray *)properties{
     NSMutableArray *cachedProperties = cachedProperties_[NSStringFromClass(self)];
    if (!cachedProperties) {//没有找到缓存、则初始化
        NSLog(@"%@调用了properties方法",[self class]);
        cachedProperties = [NSMutableArray array];
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSProperty *propertyObj = [NSProperty propertyWithProperty:property];
            [cachedProperties addObject:propertyObj];
            NSLog(@"%@,%@",propertyObj.name,propertyObj.type.typeClass);
        }
        //释放数组，修护内存泄露
        free(properties);
        //把所在对象的属性列表缓存下来
        cachedProperties_[NSStringFromClass(self)] = cachedProperties;
    }
     return cachedProperties;
}

//+ (NSArray *)propertiesTmp{
//    NSArray *propertiesArray = [NSMutableArray array];
//    // 1.获得所有的属性
//    unsigned int outCount = 0;
//    objc_property_t *properties = class_copyPropertyList(self, &outCount);
//    
//    for (int i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
////        NSLog(@"name:%s---attributes:%s",((propertyStruct)property)->name,((propertyStruct)property)->attributes);
//        
//        NSLog(@"name:%s---attributes:%s",property_getName(property),
//              property_getAttributes(property));
//        
//        NSString *name = @(property_getName(property));
//        NSString *attributes = @(property_getAttributes(property));
//        
//        NSUInteger loc = 1;
//        NSUInteger len = [attributes rangeOfString:@","].location - loc;
//        NSString *type = [attributes substringWithRange:NSMakeRange(loc, len)];
//        NSLog(@"type:%@",type);
//    }
//    
//    return propertiesArray;
//}





@end
