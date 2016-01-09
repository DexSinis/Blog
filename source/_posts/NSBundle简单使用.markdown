# NSBundle简单使用

title: NSBundle简单使用
tags : [IOS开发SDK]
date: 2015-11-20 11:50:07
---

在ios开发中为了方便管理资源文件，可以使用bundle的方式来进行管理，比如kkgridview里就是把所需的图片文件全部放在一个bundle来管理的 .

切记目前iOS中只允许使用bundle管理资源文件和国际化信息，不支持代码的打包。

在xcode中只能够创建setting bundle，会默认创建一些配置文件，在xcode中无法直接删除，这也许不是我们需要的。

那么如何使用最简单的方法创建一个bundle呢?

1 创建一个文件夹

2 将该文件夹重命名为a.bundle

3 将a.bundle拖入到xcode中即可

当然这样处理之后，取图片之类的文件，使用的方法就不一样了，以取iphone_52x52.png图片为例：
        NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"My.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        UIImage *(^getBundleImage)(NSString *) = ^(NSString *n) {
            return [UIImage imageWithContentsOfFile:[bundle pathForResource:n ofType:@"png"]];
        };
        UIImage *myImg = getBundleImage(@"iphone_52x52");
 
代码是蛮长一块，为了方便使用，我们可以写一个UIImage的类别，在类别中加入此方法，这样用起来就简单多了：
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"My.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
}

调用方式：
UIImage * img  = [self imagesNamedFromCustomBundle:@"iphone_52x52"];

测试了下，发现一点小问题，为了兼容retina屏，有iphone_52x52.png和iphone_52x52@2x.png，两张图片，
当我们用UIImage * img = [UIImage imageNamed:@"iphone_52x52"];这种方式取图片时，会根据你是不是retina屏
来返回不同的图片，如果这两张图你只提供了一张，那么也可以正常运行，只是图片会按比例进行拉伸。

在测试上面的imagesNamedFromCustomBundle方法时，提供两张图片和只提供iphone_52x52.png时，两种屏下面都正常，但如果只提供了iphone_52x52@2x.png这张图片，那么无论是普通屏还是retina屏，都会找不到图片。

调试分析了下，是在[bundle pathForResource:imgName ofType:@"png"];这里出了问题，返回的path都是nil,把上面的方法改成下面这样：
- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"testLocalVirable.bundle"];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imgName];
    return [UIImage imageWithContentsOfFile:img_path];
}

调用方式改成：UIImage * img  = [self imagesNamedFromCustomBundle:@"iphone_52x52.png"];//把扩展名加上了
这样在来测试，retina屏正常了，普通屏还是找不到图片。
分析了半天也没找到解决方法，知识还是有限啊，看来要去请教下大牛才行了；
现阶段的处理方法就是别偷懒，提供完整的两张图片就ok了。

这里有老外的一篇讲Resource Bundles的文章：http://www.cocoanetics.com/2012/05/resource-bundles/
粗略过了一遍，有些地方也没看懂，记下来，有空花时间好好看看。

bundle的本质就是一个文件夹。当然在iOS中还可以干很多事情，详细资料请参考：
https://developer.apple.com/library/ios/#documentation/CoreFoundation/Conceptual/CFBundles/AboutBundles/AboutBundles.html#//apple_ref/doc/uid/10000123i-CH100-SW7