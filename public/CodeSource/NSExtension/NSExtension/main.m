//
//  main.m
//  NSExtension
//
//  Created by DexSinis on 15/9/22.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Property.h"
#import "NSObject+NSKeyValueObject.h"
#import "User.h"
void keyValue2object();
void execute(void (*fun)());
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        execute(keyValue2object);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}

//void execute(void (*func)())
//{
//    func();
//    return;
//}

void execute(void (*fun)()){
    fun();
    return;
}

void keyValue2object()
{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @"20",
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"1"
                           };
    
   User *user = [User objectWithKeyValues:dict];
    
 //   NSArray *propertyArray = [User properties];
}