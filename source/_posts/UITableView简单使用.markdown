# UITableView简单使用
title: UITableView简单使用
tags : [IOS开发SDK]
date: 2015-09-08 11:50:07
---

标签（空格分隔）： 未分类

---

在此输入正文


cell.selectionStyle = UITableViewCellSelectionStyleNone;  

tableView: cellForRowAtIndexPath:方法中有两个获得重用cell的方法
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
和
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]

请问他们有什么区别？
当我用 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]的时候为什么总报错
reason: 'unable to dequeue a cell with identifier Cell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'

------解决方案--------------------------------------------------------
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
NS_AVAILABLE_IOS(6_0); // newer


区别在这儿

------解决方案--------------------------------------------------------
1 这个方法在SDK5.0是运行不起来的。
2 如果需要使用这个方法，你必须使用配套的方法来一起用，下面两个配套方法：
// Beginning in iOS 6, clients can register a nib or class for each cell.
// If all reuse identifiers are registered, use the newer -dequeueReusableCellWithIdentifier:forIndexPath: to guarantee that a cell instance is returned.
// Instances returned from the new dequeue method will also be properly sized when they are returned.
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);

注意看上面的注释

3 比如你已经用NIB做了一个Cell，或者自定义了一个Cell。我们在你创建UITableView的时候，就可以顺带

self.tableView.backgroundColor = xxxx;
[self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];

这样你在- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath这个方法里，你就可以省下这些代码：

    static NSString *CellIdentifier = @"Cell";
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
      //设置你的cell
｝
而只需要


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];


这样就够了，这下你明白了吗？


