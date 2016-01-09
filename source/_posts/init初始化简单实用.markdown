# init初始化简单实用
title: init初始化简单实用
tags : [IOS开发SDK]
date: 2015-09-16 17:50:07
---

##sinitWithFrame  和   initWithCoder

**当我们所写的程序里没用用Nib文件(XIB)时,用代码控制视图内容，需要调用initWithFrame去初始化**
```python
- (id)initWithFrame:(CGRect)frame
{
    if (self =[superinitWithFrame:frame]) {
        // 初始化代码
    }
    return self;
}
```

**用于视图加载nib文件，从nib中加载对象实例时，使用 initWithCoder初始化这些实例对象**
```python
- (id)initWithCoder:(NSCoder*)coder
{
    if (self =[superinitWithcoder:coder]) {
        // 初始化代码
    }
    return self;
}
```
**Assuming you have storyboard, go to storyboard and give your VC an identifier (inspector), then do:**

```python
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]; UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"IDENTIFIER"]; [self.navigationController pushViewController:vc animated:YES];
```
**Assuming you have a xib file you want to do:**
```python
UIViewController *vc = [[UIViewController alloc] initWithNibName:@"NIBNAME" bundle:nil]; [self.navigationController pushViewController:vc animated:YES];
```
**Without a xib file:**

```python
UIViewController *vc = [[UIViewController alloc] init]; [self.navigationController pushViewController:vc animated:YES];
```
**从xib中加载UIview**
```python
  NSArray *niblets = [[NSBundle mainBundle] loadNibNamed:@"sample" owner:self options:NULL];
for (id theObject in niblets)
    {
        if ([theObject isKindOfClass:[UIViewController class]])
            [self.navigationController pushViewController:theObject animated:YES];
    }
```



