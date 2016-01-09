# cocoapods简单使用
title: cocoapods
tags : [IOS开发SDK]
date: 2015-09-12 09:10:07
---
标签（空格分隔）： 未分类

---

cocoapods出现Unable to satisfy the following requirements: required by `Podfile`的解决方法

1.尝试更新本地仓库：pod update --verbose  如果不行
2.版本号问题
3.pod repo update —verbose 查看缓存  删除本地缓存，重新setup  rm -fr ~/.cocoapods/repos/master  然后运行 $pod setup
如果出现下面错误
git clone error: RPC failed; result=56, HTTP code = 200
错误解决git config --global http.postBuffer 524288000（尽量大）
4.profile锁
5.pod install --verbose --no-repo-update
个人觉得:1、2的可能性大
pod的常用命令
sudo gem install cocoapods
$ gem sources --remove https://rubygems.org/
$ gem sources -a http://ruby.taobao.org/
$ gem sources -l
$ pod search AFNetworking
$ vim Podfile 例子：然后在Podfile文件中输入以下文字： platform :ios, '7.0' pod "AFNetworking", "~> 2.0"
$ pod install
$ pod update
$ pod update --verbose 

http://www.open-open.com/lib/view/open1442462680602.html
http://www.cnblogs.com/wayne23/p/3912882.html
http://www.jianshu.com/p/6e5c0f78200a
http://blog.csdn.net/meegomeego/article/details/24005567
http://blog.csdn.net/totogo2010/article/details/8198694






