//
//  NSDataRequestManager.m
//  iMusic
//
//  Created by DexSinis on 15/10/9.
//  Copyright © 2015年 000. All rights reserved.
//

#import "NSDataRequestManager.h"

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
    
    manager = [AFHTTPRequestOperationManager manager ];
    
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

- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    
    //检查附件是否存在
    if ([fileManager fileExistsAtPath:fileName]) {
        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
        //        [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
    }else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
        }];
        
        
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *audioData = [NSData dataWithContentsOfFile:fileName];
            
            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            //            [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //下载失败
            //            [self requestFailed:aTag];
        }];
        
        [operation start];
    }
}


@end
