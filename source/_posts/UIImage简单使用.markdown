# UIImage简单使用
title: UIImage简单使用
tags : [IOS开发SDK]
date: 2015-09-07 11:50:07
---

```bash
//NSData转换为UIImage
NSData *imageData = [NSData dataWithContentsOfFile: imagePath];
UIImage *image = [UIImage imageWithData: imageData]**;

//UIImage转换为NSData
**NSData *imageData = UIImagePNGRepresentation(aimae);
```


IOS中对图片的处理 UIImage
相信做项目时肯定会有用到 UIImage 这个类，那我们就来看一下这个类中都有什么内容。
其实这篇文章就是在看文档的时候想记录一下文档中得方法。
UIImage 继承于NSObject
下面介绍一下UIImage中的方法
首先是我们最常用的

通过图片的文件名来获取这个图片
**+ (UIImage *)imageNamed:(NSString *)name**
//要注意的是这个方法适用于已经导入到工程中的图片

创建新图片


**1、+ (UIImage *)imageWithContentsOfFile:(NSString *)path**
//通过文件加载指定路径下的文件内容获得新图片

**2、+ (UIImage *)imageWithData:(NSData *)data**
//通过一个NSData对象来获得图片
**3、+ (UIImage *)imageWithData:(NSData *)data scale:(CGFloat)scale**
//同上，只是再加上一个图片大小比例，用来改变图片的大小

**4、+ (UIImage *)imageWithCGImage:(CGImageRef)cgImage**
//使用Quartz 2D对象创建UIImage
**5、+ (UIImage *)imageWithCGImage:(CGImageRef)imageRef scale:(CGFloat)scale orientation:(UIImageOrientation)orientation**
//制定图片的比例和方向，其中方向是个枚举类。

**6、+ (UIImage *)imageWithCIImage:(CIImage *)ciImage**
//用一个Core Image 对象创建图像
**7、+ (UIImage *)imageWithCIImage:(CIImage *)ciImage scale:(CGFloat)scale orientation:(UIImageOrientation)orientation**
//再加上比例和图片方向

**8、- (UIImage *)imageWithAlignmentRectInsets:(UIEdgeInsets)alignmentInsets**
//返回指定矩形区域内的图像

**9、+ (UIImage *)animatedImageNamed:(NSString *)name duration:(NSTimeInterval)duration**
//创建一个动态图片，动态图片持续的时间为duration
**10、+ (UIImage *)animatedImageWithImages:(NSArray *)images duration:(NSTimeInterval)duration**
//用一组图片创建一个动态图片，动态持续时间duration

**11、+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets duration:(NSTimeInterval)duration**
//创建一个在可变大小的图片上指定矩形区域内的动态图片
**12、+ (UIImage *)animatedResizableImageNamed:(NSString *)name capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode duration:(NSTimeInterval)duration**
//同上，只是多了一个图片变化的方式，具体来说就是平铺或者拉伸

**13、- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets**
//用制定矩形区域创建图像
**14、- (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode**
//同上，指定图片变化方式

初始化图片


方法的作用在从上面的一些方法中都能找到原型，这里就不一一注释了
**1、– initWithContentsOfFile: //从文件加载图片
2、– initWithData: //用NSData对象初始化图片
3、– initWithData:scale: //用NSData对象,指定的比例，初始化图片
4、– initWithCGImage:
5、– initWithCGImage:scale:orientation:
6、– initWithCIImage:
7、– initWithCIImage:scale:orientation:**


绘画图片

**1、– drawAtPoint:**
//在指定的点开始绘画图片，这个点就是图片的做上角顶点
**2、- (void)drawAtPoint:(CGPoint)point blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha**
//在指定的点绘制整个图片，并使用自定义图片复合模式，并设置透明度

**3、– drawInRect:**
//在指定区域内绘制图片，可根据需要缩放图片
**4、– drawInRect:blendMode:alpha:**
//参照上面第二条
**5、– drawAsPatternInRect:**
//在指定区域内，平铺图片


image的属性
imageOrientation //图片的方向
size //图片的大小size
scale //图片的比例
resizingMode //图片变化方式
CGImage //潜在的Quartz image
CIImage //潜在的Core Image
images //返回一个由图片组成的数组，针对于由一组图片生成的动态图片
duration //返回动态图片持续的时间（即动态图片播放一遍的时间）
capInsets //图片上选定的区域
alignmentRectInsets //图片平铺的区域




