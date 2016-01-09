# Swift实战之FoodPin(一)
title: Swift实战之FoodPin(一)
tags : [项目,swift]
date: 2015-09-10 17:50:07
---
经过大半年的object-c的项目的积累，觉得将来swift的发展潜力会更大，所以开始准备写一个简单的软件锻炼一下自己，参考了AppCoda Beginning iOS 8 Programming with Swift这本书之后，开始把他上面的项目做下来，当然中间会插入之前自己的实际经验和自己常用的类库

建立一个名字叫FoodPin的项目，然后建立两个自定义的文件
Appdelege 不多说，不懂谷歌
```object-c
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var tableViewController = RestaurantTableViewController()
        var nav = UINavigationController(rootViewController: tableViewController)
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        self.window!.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
```

RestaurantTableViewController(主页面)  继承之 UITableViewController重写这些方法
```object-c
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell",indexPath) as! UITableViewCell
       var cell = CustomTableViewCell().cellWithTableView(tableView)
        // Configure the cell...
        cell.textLabel!.text = "aa"
//            String(format:"%d",indexPath.row)
        cell.backgroundColor = UIColor.redColor();
//        cell.textLabel!.text = self.items[indexPath.row];
        return cell
    }
```

CustomTableViewCell(自定义的cell) 继承之UITableViewCell 添加方法
```object-c
     func cellWithTableView(tableView:UITableView) -> UITableViewCell
    {
                var cell = tableView.dequeueReusableCellWithIdentifier("sub") as? UITableViewCell
                if ((cell) == nil) {
                 cell = CustomTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "sub")
                        //self.init(style: UITableViewStyle.Plain, reuseIdentifier: "sub")
                }
                return cell!;
    }
```  
运行一下吧，主要刚刚开始用swift，这种声明和返回值很少有人说明，自己也浪费一点时间才尝试出来，有错请指正
**func cellWithTableView(tableView:UITableView) -> UITableViewCell**

就先到这里了，浪费两个小时才查到语法，以后熟悉了swift会加快进度的[源码点我](/CodeSource/FoodPin/DayCode/2015.09.10.zip)
9月10号 －－－－－－－－－－－－－－－－－－－－－－－－－－－



