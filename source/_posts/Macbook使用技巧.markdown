# Macbook使用技巧
title: Macbook使用技巧
date: 2015-10-06 09:44:36
tags: [IOS开发经验总结]
---

在终端中输入下面一整条命令行，来调整Time Machine备份周期：
```bash
sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 14400
```
复制代码
在这里面，最后的数字是以秒计算的，3600秒就是一个小时，而上面的14400秒就是4个小时。Time Machine默认的备份周期是一个小时，所以你可以根据自己的需要改称其他的时间长度。

所以，想要恢复成默认状态，就可以在终端输入3600秒的命令：
```bash
sudo defaults write /System/Library/LaunchDaemons/com.apple.backupd-auto StartInterval -int 3600
```
复制代码





