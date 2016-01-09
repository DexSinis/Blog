//
//  NSProperty.h
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class NSPropertyType;
@interface NSProperty : NSObject

/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;
/** 成员属性的类型 */
@property (nonatomic, readonly) NSPropertyType *type;

+ (instancetype)propertyWithProperty:(objc_property_t)property;
@end
