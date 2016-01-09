# NSNotification简单使用

title: NSNotification简单使用
tags : [IOS开发SDK]
date: 2015-11-15 11:50:07
---

接着上回说的iOS页面传值问题

传送门---------->iOS页面传值之代理传值

接下来我们说说NSNotificationCenter传值方式

在开始之前，我们首先得知道KVO模式

Key-Value Observing (KVO) 键值监听

就是说当你告诉通知中心一个Key 他会根据Value的变化做些事情，或者是获取一些数据

说上千回，不如用上一回。 

 

我们在B控制器发送一个监听

[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification" object:self userInfo:@{@"name":self.textField.text}];

 

而在A控制器中设置A本身为一个监听者（好比A这时候正在监听它，可以这么理解，一个KVO可以用多个监视者。这里只有一个控制器A）

具体代码

[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"ChangeNameNotification" object:nil];

再在A控制器中实现ChangeNameNotification：方法

-(void)ChangeNameNotification:(NSNotification*)notification{

 

    NSDictionary *nameDictionary = [notification userInfo];

    

    self.textLabel.text = [nameDictionary objectForKey:@"name"];

 

}

 




