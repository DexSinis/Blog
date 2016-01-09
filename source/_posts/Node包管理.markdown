# Node包管理

title: Node包管理
tags : [Node]
date: 2015-09-08 17:10:07
---

node有一个模块叫n（这名字可够短的。。。），是专门用来管理node.js的版本的。
首先安装n模块：
npm install -g n
第二步：
升级node.js到最新稳定版
n stable
是不是很简单？！
n后面也可以跟随版本号比如：
n v0.10.26
或
n 0.10.26
就这么简单，这可怎么办？？！！
另外分享几个npm的常用命令

npm -v          #显示版本，检查npm 是否正确安装。
 
npm install express   #安装express模块
 
npm install -g express  #全局安装express模块
 
npm list         #列出已安装模块
 
npm show express     #显示模块详情
 
npm update        #升级当前目录下的项目的所有模块
 
npm update express    #升级当前目录下的项目的指定模块
 
npm update -g express  #升级全局安装的express模块
 
npm uninstall express  #删除指定的模块



1.curl https://raw.github.com/creationix/nvm/master/install.sh | sh

2。vi ~/.bash_profile
　　添加：source /Users/dujie/.nvm/nvm.sh

nvm install 0.10.24
nvm use 0.10.24
# 默認使用 0.10.24 版本，否則每次關掉 Terminal 就得重新 nvm use 一次
$ nvm alias default 0.10.24

# 列出所有安裝的版本
$ nvm ls


# 列出總共有哪些版本可以安裝
$ nvm ls-remote


安装常用的工具
npm install -g express 
npm install -g bower
npm install -g fis
