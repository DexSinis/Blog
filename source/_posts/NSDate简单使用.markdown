# NSDate简单使用
title: NSDate简单使用
tags : [IOS开发SDK]
date: 2015-09-08 11:50:07
---


// 获取系统当前时间  dasdasd
NSDate * date = [NSDate date];  
NSTimeInterval sec = [date timeIntervalSinceNow];  
NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];  
  
//设置时间输出格式：  
NSDateFormatter * df = [[NSDateFormatter alloc] init ];  
[df setDateFormat:@"yyyy年MM月dd日 HH小时mm分ss秒"];  
NSString * na = [df stringFromDate:currentDate];  
  
NSLog(@"系统当前时间为：%@",na);  