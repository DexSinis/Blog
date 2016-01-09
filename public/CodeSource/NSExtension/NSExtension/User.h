//
//  User.h
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    SexMale,
    SexFemale
} Sex;
@interface User : NSObject

/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (assign, nonatomic) unsigned int age;
/** 身高 */
@property (copy, nonatomic) NSString *height;
/** 财富 */
@property (strong, nonatomic) NSNumber *money;
/** 性别 */
@property (assign,nonatomic) Sex sex;

/** 同性恋 */
@property (assign,nonatomic,getter=isGay) BOOL gay;

@property (nonatomic,copy) NSString *test;

@end
