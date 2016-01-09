# SDWebImage简单使用

title: SDWebImage简单使用
tags : [IOS开发SDK]
date: 2015-11-22 11:50:07
---
最新版SDWebImage的使用

 
我之前写过一篇博客，介绍缓存处理的三种方式，其中最难，最麻烦，最占内存资源的还是图片缓存，最近做的项目有大量的图片处理，还是采用了SDWebImage来处理，但是发现之前封装好的代码报错了。研究发现，是我用了新版的SDWebImage，好多方法都变了。

现在把代码贴出来，供大家参考。尤其是新手，看完这篇博客，图片缓存so easy。最后有demo供大家下载，先学习。

第一步，下载SDWebImage，导入工程。github托管地址https://github.com/rs/SDWebImage

第二步，在需要的地方导入头文件

1
#import "UIImageView+WebCache.h"
第三步，调用sd_setImageWithURL：方法缓存图片，注意，这就是新版本的新方法，旧方法是setImageWithURL:。下面将几个方法都介绍一下。

1. sd_setImageWithURL：

//图片缓存的基本代码，就是这么简单
    [self.image1 sd_setImageWithURL:imagePath1];
2. sd_setImageWithURL:  completed:

//用block 可以在图片加载完成之后做些事情
    [self.image2 sd_setImageWithURL:imagePath2 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         
        NSLog(@"这里可以在图片加载完成之后做些事情");
         
    }];
3. sd_setImageWithURL:  placeholderImage:

//给一张默认图片，先使用默认图片，当图片加载完成后再替换
    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"]];
4. sd_setImageWithURL:  placeholderImage:  completed:

//使用默认图片，而且用block 在完成后做一些事情
    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         
        NSLog(@"图片加载完成后做的事情");
         
    }];
5. sd_setImageWithURL:  placeholderImage:  options:

//options 选择方式
     
    [self.image1 sd_setImageWithURL:imagePath1 placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageRetryFailed];
其他就不一一介绍了，oc是自文档语言，看方法名就知道干什么的了。除了带options选项的方法，其他的方法都是综合存储，也就是内存缓存和磁盘缓存结合的方式，如果你只需要内存缓存，那么在options这里选择SDWebImageCacheMemoryOnly就可以了。

如果不想深入了解，到这里你已经可以用SDWebimage进行图片缓存了，接下来我要解释options的所有选项，以及SDWebImage内部执行流程。

一、options所有选项：

　　//失败后重试
     SDWebImageRetryFailed = 1 << 0,
      
     //UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
     SDWebImageLowPriority = 1 << 1,
      
     //只进行内存缓存
     SDWebImageCacheMemoryOnly = 1 << 2,
      
     //这个标志可以渐进式下载,显示的图像是逐步在下载
     SDWebImageProgressiveDownload = 1 << 3,
      
     //刷新缓存
     SDWebImageRefreshCached = 1 << 4,
      
     //后台下载
     SDWebImageContinueInBackground = 1 << 5,
      
     //NSMutableURLRequest.HTTPShouldHandleCookies = YES;
      
     SDWebImageHandleCookies = 1 << 6,
      
     //允许使用无效的SSL证书
     //SDWebImageAllowInvalidSSLCertificates = 1 << 7,
      
     //优先下载
     SDWebImageHighPriority = 1 << 8,
      
     //延迟占位符
     SDWebImageDelayPlaceholder = 1 << 9,
      
     //改变动画形象
     SDWebImageTransformAnimatedImage = 1 << 10,
二、SDWebImage内部实现过程

入口 setImageWithURL:placeholderImage:options: 会先把 placeholderImage 显示，然后 SDWebImageManager 根据 URL 开始处理图片。
进入 SDWebImageManager-downloadWithURL:delegate:options:userInfo:，交给 SDImageCache 从缓存查找图片是否已经下载 queryDiskCacheForKey:delegate:userInfo:.
先从内存图片缓存查找是否有图片，如果内存中已经有图片缓存，SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo: 到 SDWebImageManager。
SDWebImageManagerDelegate 回调 webImageManager:didFinishWithImage: 到 UIImageView+WebCache 等前端展示图片。
如果内存缓存中没有，生成 NSInvocationOperation 添加到队列开始从硬盘查找图片是否已经缓存。
根据 URLKey 在硬盘缓存目录下尝试读取图片文件。这一步是在 NSOperation 进行的操作，所以回主线程进行结果回调 notifyDelegate:。
如果上一操作从硬盘读取到了图片，将图片添加到内存缓存中（如果空闲内存过小，会先清空内存缓存）。SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo:。进而回调展示图片。
如果从硬盘缓存目录读取不到图片，说明所有缓存都不存在该图片，需要下载图片，回调 imageCache:didNotFindImageForKey:userInfo:。
共享或重新生成一个下载器 SDWebImageDownloader 开始下载图片。
图片下载由 NSURLConnection 来做，实现相关 delegate 来判断图片下载中、下载完成和下载失败。
connection:didReceiveData: 中利用 ImageIO 做了按图片下载进度加载效果。
connectionDidFinishLoading: 数据下载完成后交给 SDWebImageDecoder 做图片解码处理。
图片解码处理在一个 NSOperationQueue 完成，不会拖慢主线程 UI。如果有需要对下载的图片进行二次处理，最好也在这里完成，效率会好很多。
在主线程 notifyDelegateOnMainThreadWithInfo: 宣告解码完成，imageDecoder:didFinishDecodingImage:userInfo: 回调给 SDWebImageDownloader。
imageDownloader:didFinishWithImage: 回调给 SDWebImageManager 告知图片下载完成。
通知所有的 downloadDelegates 下载完成，回调给需要的地方展示图片。
将图片保存到 SDImageCache 中，内存缓存和硬盘缓存同时保存。写文件到硬盘也在以单独 NSInvocationOperation 完成，避免拖慢主线程。
SDImageCache 在初始化的时候会注册一些消息通知，在内存警告或退到后台的时候清理内存图片缓存，应用结束的时候清理过期图片。
SDWI 也提供了 UIButton+WebCache 和 MKAnnotationView+WebCache，方便使用。
SDWebImagePrefetcher 可以预先下载图片，方便后续使用。
从上面流程可以看出，当你调用setImageWithURL:方法的时候，他会自动去给你干这么多事，当你需要在某一具体时刻做事情的时候，你可以覆盖这些方法。比如在下载某个图片的过程中要响应一个事件，就覆盖这个方法：


//覆盖方法，指哪打哪，这个方法是下载imagePath2的时候响应
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
     
    [manager downloadImageWithURL:imagePath2 options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         
        NSLog(@"显示当前进度");
         
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
        NSLog(@"下载完成");
    }];
对于初级来说，用sd_setImageWithURL:的若干个方法就可以实现很好的图片缓存。




