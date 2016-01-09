# UIViewController简单使用
title: UIViewController简单使用
tags : [IOS开发SDK]
date: 2015-11-30 11:50:07
---
最新版SDWebImage的使用
UIViewController中loadView, viewDidLoad, viewWillUnload, viewDidUnload, viewWillAppear, viewDidAppear, viewWillLayoutSubviews，viewDidLayoutSubviews，viewWillDisappear, viewDidDisappear方法，按照调用顺序说明如下：

调试日志：



2013-07-14
12:15:49.048
VCTest[13412:907]
initWithNibName:bundle  /  initWithCoder

#如果使用的StoryBoard


2013-07-14
12:15:49.056
VCTest[13412:907]
loadView


2013-07-14
12:15:49.059
VCTest[13412:907]
viewDidLoad


2013-07-14
12:15:49.061
VCTest[13412:907]
viewWillAppear


2013-07-14
12:15:49.078
VCTest[13412:907]
viewWillLayoutSubviews


2013-07-14
12:15:49.083
VCTest[13412:907]
viewDidLayoutSubviews


2013-07-14
12:15:49.445
VCTest[13412:907]
viewDidAppear


2013-07-14
12:16:00.624
VCTest[13412:907]
viewWillDisappear


2013-07-14
12:16:00.997
VCTest[13412:907]
viewDidDisappear

1. initWithNibName:bundle:

初始化UIViewController，执行关键数据初始化操作，注意这里不要做view相关操作，view在loadView方法中才初始化，这时loadView还未调用。如果使用StoryBoard进行视图管理，程序不会直接初始化一个UIViewController，StoryBoard会自动初始化或在segue被触发时自动初始化，因此方法initWithNibName:bundle:不会被调用。如果在代码里面使用instantiateViewControllerWithIdentifier:方法显示初始化一个UIViewController，则initWithCoder方法会被调用。

如果是通过调用initWithNibName:bundle指定nib文件名初始化的话，ViewController会根据此nib来创建View。如果name参数为nil，则ViewController会通过以下两个步骤找到与其关联的nib：
1）如果ViewController的类名以“Controller”结尾，例如ViewController的类名是MyViewController，则查找是否存在MyView.nib；
2）找跟ViewController类名一样的文件，例如MyViewController，则查找是否存在MyViewController.nib

2. loadView

当访问UIViewController的view属性时，view如果此时是nil，那么VC会自动调用loadView方法来初始化一个UIView并赋值给view属性。此方法用在初始化关键view，需要注意的是，在view初始化之前，不能先调用view的getter方法，否则将导致死循环（除非先调用了[supper
 loadView];）。



-(void)loadView{


    NSLog(@"loadView");


    //错误，将导致死循环，因此此时view=nil，VC会再次调用loadView来初始化view


    self.view.backgroundColor
=
[UIColor
greenColor];


}


 


-(void)loadView{


    NSLog(@"loadView");


    //正确，先初始化view


    self.view
=
[[MyView
alloc]
init];


    self.view.backgroundColor
=
[UIColor
greenColor];


}

如果没有重载loadView方法，则UIViewController会从nib或StoryBoard中查找默认的loadView，默认的loadView会返回一个空白的UIView对象。

3. viewDidLoad

当VC的view对象载入内存后调用，用于对view进行额外的初始化操作

4. viewWillAppear

在view即将添加到视图层级中(显示给用户)且任意显示动画切换之前调用(这个时候supperView还是nil)。这个方法中完成任何与视图显示相关的任务，例如改变视图方向、状态栏方向、视图显示样式等

5. viewDidAppear

在view被添加到视图层级中，显示动画切换之后调用(这时view已经添加到supperView中)。在这个方法中执行视图显示相关附件任务，如果重载了这个方法，必须在方法中调用[supper
 viewDidAppear];

6. viewWillLayoutSubviews

view即将布局其Subviews。比如view的bounds改变了(例如状态栏从不显示到显示，视图方向变化)，要调整Subviews的位置，在调整之前要做的一些工作就可以在该方法中实现。

7. viewDidLayoutSubviews

view已经布局其Subviews。比如view的bounds改变了(例如状态栏从不显示到显示，视图方向变化)，已经调整Subviews的位置，在调整完成之后要做的一些工作就可以在该方法中实现。

8. viewWillDisappear

view即将从superView中移除且移除动画切换之前，此时还没有调用removeFromSuperview。

9. viewDidDisappear

view从superView中移除，移除动画切换之后调用，此时已调用removeFromSuperview。

10. viewWillUnload

在VC的view对象从内存中释放之前调用，可以在view被释放前做一些资源清理操作。在iOS6.0开始就废弃了，该方法不再会调用

11. viewDidUnload

在VC的view对象从内存中释放之后调用，可以在view被释放后做一些view相关的引用清理操作，此时view为nil。在iOS6.0开始就废弃了，该方法不再会调用

当一个视图被移除屏幕并且销毁的时候的执行顺序，这个顺序差不多和上面的相反 
1、viewWillDisappear            视图将被从屏幕上移除之前执行 
2、viewDidDisappear             视图已经被从屏幕上移除，用户看不到这个视图了 
3、dealloc                                 视图被销毁，此处需要对你在init和viewDidLoad中创建的对象进行释放 



