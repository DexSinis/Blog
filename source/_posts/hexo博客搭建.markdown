# hexo博客搭建
title: hexo博客搭建
tags : [MarkDown]
date: 2015-08-10 17:10:07
---

##  git配置
```bash
cd ~/.ssh
mkdir key_backup
cp id_rsa* key_backup
rm id_rsa*
ssh-keygen -t rsa -C "dexsinis@gmail.com"

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


##  hexo 配置


基本配置(hexo官网) https://hexo.io/zh-cn/docs/ **(必须看懂搭建好才进行下一步)**
主要修改文件 _config.yml
```bash
deploy:
  type: git
  repository: git@github.com:DexSinis/DexSinis.github.io.git
  branch: master
```

**主题修改**
/themes/lascape/_config.yml
推荐：http://www.zhihu.com/question/24422335

集成多说样式(/themes/lascape/_config.yml中的duoshuo_shortname:)
/Users/a000/IDE/Blog/themes/landscape-plus/layout/_partial/head.ejs
```bash
<head>
  <meta charset="utf-8">
    <script type="text/javascript">
  var duoshuoQuery = {short_name:"<%= theme.duoshuo_shortname %>"};
  (function() {
    var ds = document.createElement('script');
    ds.type = 'text/javascript';ds.async = true;
    ds.src = '//dexsinister.github.io/js/embed.js';
    ds.charset = 'UTF-8';
    (document.getElementsByTagName('head')[0]
    || document.getElementsByTagName('body')[0]).appendChild(ds);
  })();
</script>
```
**多说样式配置(可省略)**
进入 (http://duoshuo.com/) 后台管理-->设置-->自定义CSS
```bash
/*多说UA开始*/
span.ua{
	margin: 0 1px!important;
	color:#FFFFFF!important;
	/*text-transform: Capitalize!important;
	float: right!important;
	line-height: 18px!important;*/
}
.ua_other.os_other{
	background-color: #ccc!important;
	color: #fff;
	border: 1px solid #BBB!important;
	border-radius: 4px;
}
.ua_ie{
	background-color: #428bca!important;
	border-color: #357ebd!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_firefox{
	background-color: #f0ad4e!important;
	border-color: #eea236!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_maxthon{
	background-color: #7373B9!important;
	border-color: #7373B9!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_ucweb{
	background-color: #FF740F!important;
	border-color: #d43f3a!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_sogou{
	background-color: #78ACE9!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_2345explorer{
	background-color: #2478B8!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_2345chrome{
	background-color: #F9D024!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_mi{
	background-color: #FF4A00!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_lbbrowser{
	background-color: #FC9D2E!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_chrome{
	background-color: #EE6252!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_qq{
	background-color: #3D88A8!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_apple{
	background-color: #E95620!important;
	border-color: #4cae4c!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.ua_opera{
	background-color: #d9534f!important;
	border-color: #d43f3a!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
 
 
.os_vista,.os_2000,.os_windows,.os_xp,.os_7,.os_8,.os_8_1 {
	background-color: #39b3d7!important;
	border-color: #46b8da!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
 
.os_android {
	background-color: #98C13D!important;
	border-color: #01B171!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.os_ubuntu{
	background-color: #DD4814!important;
	border-color: #01B171!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.os_linux {
	background-color: #3A3A3A!important;
	border-color: #1F1F1F!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.os_mac{
	background-color: #666666!important;
	border-color: #1F1F1F!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.os_unix{
	background-color: #006600!important;
	border-color: #1F1F1F!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.os_nokia{
	background-color: #014485!important;
	border-color: #1F1F1F!important;
	border-radius: 4px;
	padding: 0 5px!important;
}
.sskadmin{
background-color: #00a67c!important;
	border-color: #01B171!important;
	border-radius: 4px;
	padding: 0 5px!important;
 
}
/*多说UA结束*/
```


**集成谷歌分析(/themes/lascape/_config.yml中的google_analytics:)**
```bash
<!-- Google Analytics -->
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', '<%= theme.google_analytics %>', 'auto');
ga('send', 'pageview');
</script>
```


##  markdown 编辑器推荐

  Ulysses
  飞象markdown
  cmdmarkdown
  
  

  
  











