//
//  ViewController.m
//  socket_tutorial
//
//  Created by xiaoliangwang on 14-7-4.
//  Copyright (c) 2014年 芳仔小脚印. All rights reserved.
//

#import "ViewController.h"

#import "Singleton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///**
	[Singleton sharedInstance].socketHost = @"192.168.1.107";// host设定
    [Singleton sharedInstance].socketPort = 9999;// port设定
    
    // 在连接前先进行手动断开
    [Singleton sharedInstance].socket.userData = SocketOfflineByUser;
    [[Singleton sharedInstance] cutOffSocket];
    
    // 确保断开后再连，如果对一个正处于连接状态的socket进行连接，会出现崩溃
    [Singleton sharedInstance].socket.userData = SocketOfflineByServer;
    [[Singleton sharedInstance] socketConnectHost];
    // **/
}



@end
