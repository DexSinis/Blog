# 教你如何获取ios系统信息
title: 教你如何获取ios系统信息
tags : [IOS开发SDK]
date: 2015-12-10 11:50:07
---

教你如何获取ios系统信息
NSString *deviceID  =  ［UIDevice currentDevice] uniqueIdentifier];//设备id
// NSString *deviceID   =   ［UIApplication sharedApplication] uuid];
NSString *systemVersion   =   ［UIDevice currentDevice] systemVersion];//系统版本
NSString *systemModel    =   ［UIDevice currentDevice] model];//是iphone 还是 ipad
NSDictionary *dic    =   ［NSBundle mainBundle] infoDictionary];//获取info－plist
NSString *appName  =   [dic objectForKey:@"CFBundleIdentifier"];//获取Bundle identifier
NSString *appVersion   =   [dic valueForKey:@"CFBundleVersion"];//获取Bundle Version    
NSDictionary *userInfo = ［NSDictionary alloc] initWithObjectsAndKeys:
    deviceID, @"deviceID",
    systemVersion, @"systemVersion",
    systemModel, @"systemModel",
    appName, @"appName",
    appVersion, @"appVersion",nil];
