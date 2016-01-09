# UIFont简单使用
title: UIFont简单使用
tags : [IOS开发SDK]
date: 2015-09-24 11:50:07
---


UIFont* font = [UIFont fontWithName:@"Arial-ItalicMT" size:21.0]; 
NSDictionary* textAttributes = @{NSFontAttributeName:font, 
NSForegroundColorAttributeName:[UIColor blackColor]}; 

[[UINavigationBar appearance]setTitleTextAttributes:textAttributes]; 




