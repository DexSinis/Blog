# NSURL简单使用
title: NSURL简单使用
tags : [IOS开发SDK]
date: 2015-11-15 11:50:07
---

NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/search?id=1"];
    NSLog(@"scheme:%@", [url scheme]); //协议 http
    NSLog(@"host:%@", [url host]);     //域名 www.baidu.com
    NSLog(@"absoluteString:%@", [url absoluteString]); //完整的url字符串http://www.baidu.com:8080/search?id=1
    NSLog(@"relativePath: %@", [url relativePath]); //相对路径 search
    NSLog(@"port :%@", [url port]);  // 端口 8080
    NSLog(@"path: %@", [url path]);  // 路径 search
    NSLog(@"pathComponents:%@", [url pathComponents]); // search
    NSLog(@"Query:%@", [url query]);  //参数 id=1
    
    
http://ubluesky.com/archives/55




