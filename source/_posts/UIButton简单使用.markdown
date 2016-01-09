# UIButton简单使用
title: UIButton简单使用
tags : [IOS开发SDK]
date: 2015-09-09 17:50:07
---
```bash
self.DemoOne = [[UIButton alloc] init];
self.DemoOne.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height/2 -200, 100, 40);
    [self.DemoOne setTitle:@"DemoOne" forState:UIControlStateNormal];
    [self.view addSubview:self.DemoOne];
```
 **(错误，不同于UILabel) // self.DemoOne.titleLabel.text = @"DemoOne";**




