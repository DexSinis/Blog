# AFNetworking简单使用
title: AFNetworking简单使用
tags : [IOS开发SDK]
date: 2015-10-09 11:50:07
---
**AFNetworking是一个轻量级的iOS网络通信类库。它建立在NSURLConnection和NSOperation等类库的基础上，让很多网络通信功能的实现变得十分简单。它支持HTTP请求和基于REST的网络服务（包括GET、POST、 PUT、DELETE等）。支持ARC。
Github地址：https://github.com/AFNetworking/AFNetworking**

    //
    //  MJViewController.m
    //  03.AFN演练
    //
    //  Created by apple on 14-4-30.
    //  Copyright (c) 2014年 itcast. All rights reserved.
    //

    #import "MJViewController.h"
    #import "AFNetworking.h"
    @interface MJViewController ()
    @end

    @implementation MJViewController
    /**
    要使用常规的AFN网络访问
 
     1. AFHTTPRequestOperationManager *manager =             [AFHTTPRequestOperationManager manager];
 
    所有的网络请求,均有manager发起
 
     2. 需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
 
    1> 如果提交数据是JSON的,需要将请求格式设置为AFJSONRequestSerializer
    2> 如果返回格式不是JSON的,
 
     3. 请求格式
 
     AFHTTPRequestSerializer            二进制格式
     AFJSONRequestSerializer            JSON
     AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
 
     4. 返回格式
 
     AFHTTPResponseSerializer           二进制格式
     AFJSONResponseSerializer           JSON
     AFXMLParserResponseSerializer          XML,只能返回XMLParser,还需要自己通过代理方法解析
     AFXMLDocumentResponseSerializer (Mac OS X)
     AFPropertyListResponseSerializer   PList
     AFImageResponseSerializer          Image
     AFCompoundResponseSerializer       组合
     */

    - (void)viewDidLoad
    {
    [super viewDidLoad];
    
    [self reach];
    }

    #pragma mark - 演练
    #pragma mark - 检测网络连接
    - (void)reach
    {
        /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%d", status);
    }];
    }

    #pragma mark - Session 下载
    - (void)sessionDownload
    {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = @"http://localhost/itcast/videos/01.C语言-语法预览.mp4";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
    //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
    }];
    
    [task resume];
    }

    #pragma mark - POST JSON
    - (void)postJSON
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dict = @{@"name": @"zhangsan"};
    NSDictionary *dict1 = @{@"name": @"wangwu"};
    NSArray *array = @[dict, dict1];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://localhost/postjson.php" parameters:array success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    }

    #pragma mark - 随机文件名上传
    - (void)postUpload1
    {
    // 本地上传给服务器时,没有确定的URL,不好用MD5的方式处理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://localhost/demo/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        // 要上传保存在服务器中的名称
        // 使用时间来作为文件名 2014-04-30 14:20:57.png
        // 让不同的用户信息,保存在不同目录中
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *fileName = [formatter stringFromDate:[NSDate date]];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" fileName:fileName mimeType:@"image/png" error:NULL];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"OK");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
    }

    #pragma mark - POST上传
    - (void)postUpload
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
    // 例如返回一个html,text...
    //
    // 实际上就是AFN没有对响应数据做任何处理的情况
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // formData是遵守了AFMultipartFormData的对象
    [manager POST:@"http://localhost/demo/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 将本地的文件上传至服务器
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"头像1.png" withExtension:nil];
        
        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"完成 %@", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误 %@", error.localizedDescription);
    }];
    }

    #pragma mark - JSON
    - (void)XMLData
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 返回的数据格式是XML
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    NSDictionary *dict = @{@"format": @"xml"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:@"http://localhost/videos.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 如果结果是XML,同样需要使用6个代理方法解析,或者使用第三方库
        // 第三方库第三方框架,效率低,内存泄漏
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    }

    #pragma mark - JSON
    - (void)JSONData
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 原本需要拼接get访问URL ? & =
    NSDictionary *dict = @{@"format": @"json"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:@"http://localhost/videos.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        NSLog(@"%@", [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    }

    #pragma mark - POST登录
    - (void)postLogin
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 原本需要拼接get访问URL ? & =
    NSDictionary *dict = @{@"username": @"wangwu", @"password" : @"wang"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager POST:@"http://localhost/login.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        NSLog(@"%@", [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    }

    #pragma mark - GET登录
    - (void)getLogin
    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 原本需要拼接get访问URL ? & =
    NSDictionary *dict = @{@"username": @"wangwu", @"password" : @"wang"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:@"http://localhost/login.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        // 提问:NSURLConnection异步方法回调,是在子线程
        // 得到回调之后,通常更新UI,是在主线程
        NSLog(@"%@", [NSThread currentThread]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    }

    @end
    
    
    
    
    
    －－－－－－－－－－－－－－－－－－－－－－－－－－－－－
        镔哥哥做项目，一般的数据请求不管他多复杂，只要自己写好了请求，那么调用永远是那么的简单，那么我介绍一下
    
    一：需要用到第三方框架AFNetworking，直接写在工程pch头文件里就行因为经常用到它，这在网上随便下载就行，最好用cocopod来下载，这样什么都有了，cocopod是什么，我就不说，博客上面有介绍。
    
    开始啦：
    
    1：自定义网络请求 DataRequestManager类专门管理网络用的
    
    朋友们以下代码就可以直接复制来用了
    
    .h文件
    
    //  DataRequestManager.h
    
    //  TestKeyBoard
    
    //  Created by mac on 14-10-21.
    
    //  Copyright (c) 2014 年 mac. All rights reserved.
    
    #import <Foundation/Foundation.h>
    
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
    
    .m文件
    
    //  DataRequestManager.m
    
    //  TestKeyBoard
    
    //
    
    //  Created by mac on 14-10-21.
    
    //  Copyright (c) 2014 年 mac. All rights reserved.
    
    //
    
    #import "DataRequestManager.h"
    
    #import "AFNetworking.h"
    
    @implementation DataRequestManager
    
    //GET 请求
    
    - ( void )methodGetWithURL:( NSString *)urlString
    
    {
    
    // 致空请求
    
    if ( manager ) {
    
    manager = nil ;
    
    }
    
    // 创建请求
    
    manager = [ AFHTTPRequestOperationManager manager ];
    
    // 设置请求的解析器为 AFHTTPResponseSerializer （用于直接解析数据 NSData ），默认为 AFJSONResponseSerializer （用于解析 JSON ）
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 发送 GET 请求
    
    [ manager GET :urlString parameters : nil success :^( AFHTTPRequestOperation *operation, id responseObject) {
    
    // 请求成功（当解析器为 AFJSONResponseSerializer 时）
    
    NSLog ( @"getSuccess: %@" , responseObject);
    
    [ self . delegate passGetValue :responseObject];
    
    // 请求成功（当解析器为 AFHTTPResponseSerializer 时）
    
    //        NSString *JSONString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    //        NSLog(@"success:%@", JSONString);
    
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
    
    // 请求失败
    
    NSLog ( @"Error: %@" , error);
    
    }];
    
    }
    
    #pragma mark - POST Request (iOS 6-7)
    
    //POST 请求
    
    - ( void )methodPostWithURL:( NSString *)urlString parameters:( NSDictionary *)parameters
    
    {
    
    // 致空请求
    
    if ( manager ) {
    
    manager = nil ;
    
    }
    
    // 添加参数
    
    // 创建请求
    
    manager = [ AFHTTPRequestOperationManager manager ];
    
    // 设置请求的解析器为 AFHTTPResponseSerializer （用于直接解析数据 NSData ），默认为 AFJSONResponseSerializer （用于解析 JSON ）
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 发送 POST 请求
    
    [ manager POST :urlString parameters :parameters success :^( AFHTTPRequestOperation *operation, id responseObject) {
    
    // 请求成功（当解析器为 AFJSONResponseSerializer 时）
    
    //        NSLog(@"Success: %@", responseObject);
    
    [ self . delegate passValue :responseObject];
    
    // 请求成功（当解析器为 AFHTTPResponseSerializer 时）
    
    //        NSString *JSONString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    //        NSLog(@"success:%@", JSONString);
    
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
    
    // 请求失败
    
    NSLog ( @"Error: %@" , error);
    
    }];
    
    }
    
    #pragma mark - Upload Request (iOS 6-7)
    
    // 上传（以表单方式上传，以图片为例）
    
    - ( void )methodUploadWithURL:( NSString *)urlString parameters:( NSDictionary *)parameters image:( UIImage *)image
    
    {
    
    // 致空请求
    
    if ( manager ) {
    
    manager = nil ;
    
    }
    
    // 添加参数
    
    // 创建请求
    
    manager = [ AFHTTPRequestOperationManager manager ];
    
    // 设置请求的解析器为 AFHTTPResponseSerializer （用于直接解析数据 NSData ），默认为 AFJSONResponseSerializer （用于解析 JSON ）
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 发送 POST 请求，添加需要发送的文件，此处为图片
    
    [ manager POST :urlString parameters :parameters constructingBodyWithBlock :^( id < AFMultipartFormData > formData) {
    
    // 添加图片，并对其进行压缩（ 0.0 为最大压缩率， 1.0 为最小压缩率）
    
    NSData *imageData = UIImageJPEGRepresentation (image, 1.0 );
    
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    
    // 设置时间格式
    
    formatter. dateFormat = @"yyyyMMddHHmmss" ;
    
    NSString *str = [formatter stringFromDate :[ NSDate date ]];
    
    NSString *fileName = [ NSString stringWithFormat : @"%@.png" , str];
    
    // 添加要上传的文件，此处为图片
    
    [formData appendPartWithFileData :imageData
    
    name : @"uploadFile"
    
    fileName :fileName
    
    mimeType : @"image/jpeg" ];
    
    } success :^( AFHTTPRequestOperation *operation, id responseObject) {
    
    // 请求成功（当解析器为 AFJSONResponseSerializer 时）
    
    NSLog ( @"Success: %@" , responseObject);
    
    [ self . delegate passValue :responseObject];
    
    // 请求成功（当解析器为 AFHTTPResponseSerializer 时）
    
    //        NSString *JSONString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    //        NSLog(@"success:%@", JSONString);
    
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
    
    // 请求失败
    
    NSLog ( @"Error: %@" , error);
    
    }];
    
    }
    
    #pragma mark - Download Request (iOS 6-7)
    
    // 下载
    
    - ( void )methodDownload
    
    {
    
    /*
    
    // 下载进度条
    
    UIProgressView  *downProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    downProgressView.center = CGPointMake(self.view.center.x, 220);
    
    downProgressView.progress = 0;
    
    downProgressView.progressTintColor = [UIColor blueColor];
    
    downProgressView.trackTintColor = [UIColor grayColor];
    
    [self.view addSubview:downProgressView];
    
    // 设置存放文件的位置（此 Demo 把文件保存在 iPhone 沙盒中的 Documents 文件夹中。关于如何获取文件路径，请自行搜索相关资料）
    
    // 方法一
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *cachesDirectory = [paths objectAtIndex:0];
    
    //    NSString *filePath = [cachesDirectory stringByAppendingPathComponent:@" 文件名 "];
    
    // 方法二
    
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/ 文件名（注意后缀名） ", NSHomeDirectory()];
    
    // 打印文件保存的路径
    
    NSLog(@"%@",filePath);
    
    // 创建请求管理
    
    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@" 下载地址 "]]];
    
    // 添加下载请求（获取服务器的输出流）
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    // 设置下载进度条
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
    
    // 显示下载进度
    
    CGFloat progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
    
    [downProgressView setProgress:progress animated:YES];
    
    }];
    
    // 请求管理判断请求结果
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    // 请求成功
    
    NSLog(@"Finish and Download to: %@", filePath);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    // 请求失败
    
    NSLog(@"Error: %@",error);
    
    }];
    
    */
    
    }
    
    #pragma mark - Download Management (iOS 6-7)
    
    // 开始下载（断点续传）
    
    - ( void )downloadStart
    
    {
    
    [ self methodDownload ];
    
    [ operation start ];
    
    }
    
    // 暂停下载（断点续传）
    
    - ( void )downloadPause
    
    {
    
    [ operation pause ];
    
    }
    
    // 继续下载（断点续传）
    
    - ( void )downloadResume
    
    {
    
    [ operation resume ];
    
    }
    
    #pragma mark - Upload Request (iOS 7 only)
    
    // 上传（ iOS7 专用）
    
    - ( void )methodUploadFor7
    
    {
    
    // 致空请求
    
    if ( sessionManager ) {
    
    sessionManager = nil ;
    
    }
    
    // 创建请求（ iOS7 专用）
    
    sessionManager = [[ AFURLSessionManager alloc ] initWithSessionConfiguration :[ NSURLSessionConfiguration defaultSessionConfiguration ]];
    
    // 添加请求接口
    
    NSURLRequest *request = [ NSURLRequest requestWithURL :[ NSURL URLWithString : @" 上传地址 " ]];
    
    // 添加上传的文件
    
    NSURL *filePath = [ NSURL fileURLWithPath : @" 本地文件地址 " ];
    
    // 发送上传请求
    
    NSURLSessionUploadTask *uploadTask = [ sessionManager uploadTaskWithRequest :request fromFile :filePath progress : nil completionHandler :^( NSURLResponse *response, id responseObject, NSError *error) {
    
    if (error) {
    
    // 请求失败
    
    NSLog ( @"Error: %@" , error);
    
    } else {
    
    // 请求成功
    
    NSLog ( @"Success: %@ %@" , response, responseObject);
    
    }
    
    }];
    
    // 开始上传
    
    [uploadTask resume ];
    
    }
    
    #pragma mark - Download Request (iOS 7 only)
    
    // 下载（ iOS7 专用）
    
    - ( void )methodDownloadFor7
    
    {
    
    // 致空请求
    
    if ( sessionManager ) {
    
    sessionManager = nil ;
    
    }
    
    // 创建请求（ iOS7 专用）
    
    sessionManager = [[ AFURLSessionManager alloc ] initWithSessionConfiguration :[ NSURLSessionConfiguration defaultSessionConfiguration ]];
    
    // 添加请求接口
    
    NSURLRequest *request = [ NSURLRequest requestWithURL :[ NSURL URLWithString : @" 下载地址 " ]];
    
    // 发送下载请求
    
    NSURLSessionDownloadTask *downloadTask = [ sessionManager downloadTaskWithRequest :request progress : nil destination :^ NSURL *( NSURL *targetPath, NSURLResponse *response) {
    
    // 设置存放文件的位置（此 Demo 把文件保存在 iPhone 沙盒中的 Documents 文件夹中。关于如何获取文件路径，请自行搜索相关资料）
    
    NSURL *filePath = [ NSURL fileURLWithPath :[ NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory , NSUserDomainMask , YES ) firstObject ]];
    
    return [filePath URLByAppendingPathComponent :[response suggestedFilename ]];
    
    } completionHandler :^( NSURLResponse *response, NSURL *filePath, NSError *error) {
    
    // 下载完成
    
    NSLog ( @"Finish and Download to: %@" , filePath);
    
    }];
    
    // 开始下载
    
    [downloadTask resume ];
    
    }
    
    @end
    
    工程完美，自己复制可用





