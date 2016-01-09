//
//  NSDataRequestManager.h
//  iMusic
//
//  Created by DexSinis on 15/10/9.
//  Copyright © 2015年 000. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@protocol DataRequestManagerDelegate< NSObject >

// 通过代理传值到需要的地方

- ( void )passValue:( id )value;

@optional

- ( void )passGetValue:( id )getValue;

@end

@interface DataRequestManager : NSObject

{
    
    AFHTTPRequestOperationManager *manager; // 创建请求（ iOS 6-7 ）
    
    AFURLSessionManager *sessionManager;    // 创建请求（ iOS7 专用）
    
    AFHTTPRequestOperation *operation;      // 创建请求管理（用于上传和下载）
    
}

@property ( nonatomic , assign ) id < DataRequestManagerDelegate > delegate;

//GET 请求调用方法

- ( void )methodGetWithURL:( NSString *)urlString;

//POST 请求调用方法

- ( void )methodPostWithURL:( NSString *)urlString parameters:( NSDictionary *)parameters;

// 上传图片

- ( void )methodUploadWithURL:( NSString *)urlString parameters:( NSDictionary *)parameters image:( UIImage *)image;

@end
