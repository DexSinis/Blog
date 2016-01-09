# Git的简单使用

title: Git的简单使用
tags : [Git]
date: 2015-12-7 17:10:07
---

##  git配置
```bash
cd ~/.ssh
mkdir key_backup
cp id_rsa* key_backup
rm id_rsa*
ssh-keygen -t rsa -C "dexsinis343731621@gmail.com"

(多账号配置 gitlab与github) 新建打开config文件
Host git.meiriq.com
    HostName git.meiriq.com
    IdentityFile ~/.ssh/id_rsa_work
Host github.com
    HostName github.com
    IdentityFile ~/.ssh/id_rsa

(添加远程库)
git config --global user.name "DexSinis" 
git config --global user.email "dexinis343731621@gmail.com"
(进入你想上传的文件夹)
git init
touch README.md
git add .
git commit -m "first commit"
git remote add origin git@github.com:DexSinis/DexSinis.github.io.git
git push -u origin master

(从远程库克隆)
git clone git@github.com:DexSinis/DexSinis.github.io.git

```
**git基本常用命令** (http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)
```bash
git checkout -b topic (开始一个分支) == (git branch topic 加 git checkout topic)
git branch (查看分支)
git checkout master (回到主分支)
git merge topic (合并分支)
git branch -d topic (删除分支)



git flog (查看当前的历史版本)
git reflog (查看所有的历史的版本)



git reset --hard commit_id (前进或者回退到特定的版本号)
```

界面配置
![界面配置](/MyImage/Git/git.jpg)


1.使用强制push的方法：

$ git push -u origin master -f 

这样会使远程修改丢失，一般是不可取的，尤其是多人协作开发的时候。

2.push前先将远程repository修改pull下来

$ git pull origin master

$ git push -u origin master

3.若不想merge远程和本地修改，可以先创建新的分支：

$ git branch [name]

然后push

$ git push -u origin [name]


修改上传大小限制
git config http.postBuffer 524288000

git add 后撤销
git reset HEAD a.text

git checkout . #本地所有修改的。没有的提交的，都返回到原来的状态
git stash #把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
git reset --hard HASH #返回到某个节点，不保留修改。
git reset --soft HASH #返回到某个节点。保留修改
