# StoryBoard简单使用
title: StoryBoard简单使用
tags : [IOS开发SDK]
date: 2015-09-02 11:50:07
---

```bash
KMMovieDetailsViewController* viewController 
= (KMMovieDetailsViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"KMMovieDetailsStoryboard" class:[KMMovieDetailsViewController class]];
```
界面配置
![界面配置](/MyImage/StoryBoard/StoryBoard.png)

### [源代码](/CodeSource/StoryBoard/StoryBoardUtilities.zip) (/CodeSource/StoryBoard/StoryBoardUtilities.zip)

xib加载  建立名字为appxib.xib文件
```object-c
NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"appxib" owner:nil options:nil];
UIView *appview=[apparray firstObject];
```







