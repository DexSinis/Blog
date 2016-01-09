//
//  ViewController.h
//  SocketClient
//
//  Created by 000 on 15/8/31.
//  Copyright (c) 2015年 000. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface ViewController : UIViewController

@property (nonatomic, strong) AsyncSocket  *clientSocket;

@property (strong, nonatomic) IBOutlet UITextField *tbInputMsg;
@property (strong, nonatomic) IBOutlet UITextView *lblOutputMsg;
@end

