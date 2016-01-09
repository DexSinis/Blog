# GCD简单使用
title: GCD简单使用
tags : [IOS开发SDK]
date: 2015-11-15 11:50:07
---


Grand Central Dispatch (GCD)是Apple开发的一个多核编程的解决方法。

dispatch queue分成以下三种：

1）运行在主线程的Main queue，通过dispatch_get_main_queue获取。

复制代码
/*!
* @function dispatch_get_main_queue
*
* @abstract
* Returns the default queue that is bound to the main thread.
*
* @discussion
* In order to invoke blocks submitted to the main queue, the application must
* call dispatch_main(), NSApplicationMain(), or use a CFRunLoop on the main
* thread.
*
* @result
* Returns the main queue. This queue is created automatically on behalf of
* the main thread before main() is called.
*/
__OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_4_0)
DISPATCH_EXPORT struct dispatch_queue_s _dispatch_main_q;
#define dispatch_get_main_queue() \
DISPATCH_GLOBAL_OBJECT(dispatch_queue_t, _dispatch_main_q)
复制代码
可以看出，dispatch_get_main_queue也是一种dispatch_queue_t。

2）并行队列global dispatch queue，通过dispatch_get_global_queue获取，由系统创建三个不同优先级的dispatch queue。并行队列的执行顺序与其加入队列的顺序相同。

3）串行队列serial queues一般用于按顺序同步访问，可创建任意数量的串行队列，各个串行队列之间是并发的。

当想要任务按照某一个特定的顺序执行时，串行队列是很有用的。串行队列在同一个时间只执行一个任务。我们可以使用串行队列代替锁去保护共享的数据。和锁不同，一个串行队列可以保证任务在一个可预知的顺序下执行。

serial queues通过dispatch_queue_create创建，可以使用函数dispatch_retain和dispatch_release去增加或者减少引用计数。

GCD的用法：

复制代码
 //  后台执行：
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
      // something
 });

 // 主线程执行：
 dispatch_async(dispatch_get_main_queue(), ^{
      // something
 });

 // 一次性执行：
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
     // code to be executed once
 });

 // 延迟2秒执行：
 double delayInSeconds = 2.0;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
     // code to be executed on the main queue after delay
 });

 // 自定义dispatch_queue_t
 dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", NULL);
 dispatch_async(urls_queue, ^{  
　 　// your code 
 });
 dispatch_release(urls_queue);

 // 合并汇总结果
 dispatch_group_t group = dispatch_group_create();
 dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
      // 并行执行的线程一
 });
 dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
      // 并行执行的线程二
 });
 dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
      // 汇总结果
 });
复制代码
一个应用GCD的例子：

复制代码
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSError * error;
        NSString * data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"call back, the data is: %@", data);
            });
        } else {
            NSLog(@"error when download:%@", error);
        }
    });
复制代码
GCD的另一个用处是可以让程序在后台较长久的运行。

在没有使用GCD时，当app被按home键退出后，app仅有最多5秒钟的时候做一些保存或清理资源的工作。但是在使用GCD后，app最多有10分钟的时间在后台长久运行。这个时间可以用来做清理本地缓存，发送统计数据等工作。

让程序在后台长久运行的示例代码如下：

复制代码
// AppDelegate.h文件
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

// AppDelegate.m文件
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self beingBackgroundUpdateTask];
    // 在这里加上你需要长久运行的代码
    [self endBackgroundUpdateTask];
}

- (void)beingBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void)endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}
复制代码
 




