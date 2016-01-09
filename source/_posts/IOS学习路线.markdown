# IOS学习路线
title: IOS学习路线
date: 2015-09-09 09:44:36
tags: [IOS开发经验总结]
---
## iOS学习路线
好不容易从网上找着一张系统学习ios的图片,下面再给大家一个框架图.
![iOS学习路线](/MyImage/IOS开发经验总结/iOS学习路线.png)

## UIKit框架
应用程序可以通过三种方式使用UIKit创建界面
1. 在用户界面工具（interface Buidler）从对象库里 拖拽窗口，视图或者其他的对象使用。
2. 用代码创建
3. 通过继承UIView类或间接继承UIView类实现自定义用户界面
**框架类组织架构图：**
![框架类组织架构图](/MyImage/IOS开发经验总结/框架类组织架构图.jpg)
在图中可以看出，responder 类是图中最大分支的根类，UIResponder为处理响应事件和响应链 定义了界面和默认行为。当用户用手指滚动列表或者在虚拟键盘上输入时，UIKit就生成时间传送给UIResponder响应链，直到链中有对象处理这个事件。相应的核心对象，比如：UIApplication  ，UIWindow，UIView都直接或间接的从UIResponder继承。




