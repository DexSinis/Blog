title: IOS学习经验总结
date: 2015-08-27 09:44:36
tags: [ios经验,ios开发]
---
我当时刚学iOS开发的时候一样的感觉 总想知道原理 内部怎么回事 感觉在像在雾里
但是iOS开发就是这样 他是封闭的 本身就是在雾里...

关于iOS开发的学习 打个比方就像把汽车分解

最底层的原料有塑料 钢铁
再用这些底层的东西造出来发动机 座椅
最后再加上写螺丝 胶水等 把汽车就拼起来了
iOS基本都是英文的资料 也由于封闭 文档写的相当好
在遇到新框架的时候

弄明白框架的功能
去文档里搜搜 框架的 Programming Guide 很有用
要弄明白框架类的继承结构
写iOS的程序不一定都是用OBJC 很多框架是用C写的
学习iOS开发基础可以按照下面两个方面学

基础 (原料 钢铁 塑料)
OBJ-C --- 语法弄明白 @interface @property 这些东西总要知道是干嘛的 怎么用
基础库 --- NSString NSArray NSDictionary等 这些东西在所有的框架里都会出现
iOS大部分类都是继承自NSObject (我还没见过不是继承自NSObject的..)
还有一些 像NSCopying的接口(经@李禹龙提醒 应该叫协议) 不是特别用到开始不用了解
NSObject 创建对象的时候用 + (id)alloc 方法 创建后需要init方法初始化 这个init指的是所有前面是init的方法比如UIView的初始化方法是 - (id)initWithFrame:(CGRect)aRect 在Objc里有很多这样关于函数命名的约定 类似于在python中的函数__xxx
NSString 字符串 NSArray 数组 NSDictionary 字典 这些都需要弄很清楚 其他的类都是一个套路
NSMutableArray 这样带Mutable的类代表可变的 继承自相应的不可变类 比如NSMutableArray继承自NSArray 他们都添加了可以改变对象内容的方法比如
- (void)addObject:(id)anObject 添加对象
- (void)removeObject:(id)anObject 删除对象
上面只是一个大概的总结 还有很多东西需要学 iOS5的SDK已经支持ARC 可以自动进行release 但是对iOS4的支持还有一个小问题 现在要开发应用 可能还需要按照之前的MRC的方式alloc release retain autorelease 之类的内存管理方法 不过如果你现在开始学 到编出像样的APP iOS5可能已经普及了 可以直接用ARC (另 之前对ARC的了解很粗浅 现在开发程序完全可以直接ARC iOS4不支持的weak是有办法替代的 用unsafe_unretained 如果同时支持iOS5和iOS4 用宏判断下就可以 当然也可以直接用assign)
还有一点开始学习的时候肯定很疑惑 内存管理是基于函数名称的 比如带alloc copy的函数 用了之后返回的对象一定要release 这个不用疑惑 照做就行了
文档: http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CocoaFundamentals/Introduction/Introduction.html
高级库(发动机)
UIKit --- UI库 OBJC
UIResponder 父类是NSObject UIKit里最底层的库 可以响应一些触摸事件 设置焦点等功能
UIView 父类是UIResponder 所有View的父类 方法太多了 大部分很有用 这个不赘述了 中文的资料也很多了
比如: http://www.cnblogs.com/likwo/archive/2011/06/18/2084192.html
文档: http://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html
关于UIView的子类 有很多 UIButton UITableView 这个都需要各个击破 看看文档从名字上就很容易理解是做什么的
UIViewController 是管理View 和 Model的类 (@张开 说UIViewController是用来管理view的，管理model 的类自己写，当然，model也可以用UIViewController来管理，不过恐怕成为不好的代码。 的确是这样的 Model的改变最好通过Notification来传播 之前吃过这样的亏 最好不要用delegate模式)
UIViewController 管理所有设备发生的事件 比如屏幕旋转 屏幕关闭 或者一些其他的 程序的控制逻辑也应该写在这里
他的初始化函数是- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle 后面那个NibName 是Interface Builder 里设计的界面
现在IB已经集成到XCode里了 打开.xib的文件打开的就是IB
IB和代码交互用的是IBAction IBOutlet 这些标记 这些标记追踪到他们的定义其实对编译器来说什么都不表示 只能IB识别
IB也没那么高深 XIB文件解开之后就是一堆代码
之前面过一家小公司 看我当时写的程序里面用到了IB 一脸不屑 说他们都是用代码控制view 意思他们玩的都是高科技 IB都是垃圾 很多人也纠结到底用不用IB 的确 很多时候IB灵活度不行 但是不需要灵活度的时候还不用IB 那不是装X吗 要是没人用苹果还开发IB干嘛 早去掉了 IB在很多时候节省很多工作量
UINavigationController 再说说NavigationController 
刚接触开发的时候 不明白 View和View之间怎么切换的 最重要的就是UINavigationController 他是一层一层推进view的 打开iPhone里的联系人 每点一个联系人屏幕就会像右推到下一个界面 这就是UINavigationController在做的事
UINavigationController 维护一个堆栈 
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated 是像堆栈里压一个UIViewController
- (UIViewController *)popViewControllerAnimated:(BOOL)animated 是从堆栈里弹出来一个UIViewController
就算你的程序不是像联系人那样 向右推进 也可以用UINavigationController 管理你的ViewController的层次 可以自己写View切换的动画 关掉他默认的动画
文档: http://developer.apple.com/library/ios/#featuredarticles/ViewControllerPGforiPhoneOS/ModalViewControllers/ModalViewControllers.html
UIWindow 还有个蛋疼的UIWindow 都快忘了他了 因为iOS是从Mac os X过来的 很多东西直接拿来用 这个UIWindow就是 在iOS里 每个App独占屏幕 所以同时存在的只有一个UIWindow 除了在程序加载的时候把我的view 加载到他上 目前我还没用到过其他的
苹果一直很推崇MVC的程序结构 视图 模型 控制器 简单说就是 视图负责显示内容 模型负责所有数据的保存结构或者一些其他数据操作 控制器是用来协调 视图和模型 举车的发动机系统的例子 视图是仪表盘 模型是发动机 控制器是控制芯片
Core Data --- 管理数据 OBJC
刚学的时候觉得 CD很高深 其实他是最容易用的库之一 他麻烦之处在于多线程问题 还有胶水代码的问题
建立一个 基于Core Data的工程 你会看到他自动创建3个类的对象
NSManagedObjectModel
管理数据的存储结构文件 扩展名是 xcdatamodeld
NSPersistentStoreCoordinator
用来管理底层数据的存储 用官方的话说
Core Data is not a relational database or a relational database management system (RDBMS).
所以你可以用很多方法存储数据 比如最长用的sqlite 当然如果另类也可以用plist文件 或者其他
NSManagedObjectContext
NSManagedObjectContext 把上面两个对象连在一起 把他们变成一个整体
所有的CD操作都是通过这个类的 这个需要仔细看文档了
举个不恰当的例子 就像三个人收拾衣服 一个人负责衣服的存放位置(NSManagedObjectModel) 一个人负责把衣服分类 冬天穿 夏天穿等(NSPersistentStoreCoordinator) 一个人负责协调他们的工作 并且如果有新增加的衣服或者要移除之前的衣服 通知他俩(NSManagedObjectContext)
NSManagedObject 这个类是具体的数据对象 用上面的例子说就是衣服
一般都是继承这个对象 XCode 可以帮你做 具体搜搜 这种文章很多
NSFetchRequest
用来执行CD请求的 相当与select语句外壳
NSEntityDescription
用来描述实体的 对应sql里的table
NSPredicate
谓语 类似select语句中的条件
上面这三个类就可以用来请求数据了 具体看教程吧
中文介绍:http://c.gzl.name/archives/tag/core-data (访问需要点技术...)
文档: http://developer.apple.com/library/mac/#documentation/cocoa/conceptual/coredata/cdprogrammingguide.html
掌握上面的内容 差不多就能写个APP了 最好的学习方法就是边写边学 自己构想一个小的APP 在做的时候遇到问题 去找找资料 我觉得这样学习比较快 也比较扎实
下面这些库都是有专门功能的库

Core Animation --- 制作动画 很强大 很喜欢的框架 可以用少量的代码写出漂亮的动画 C
Quartz 2D --- 强大的2D绘图库 C
OpenGL --- 不用介绍了 超级强大的3D库 C
Core Image --- 听说 iOS5开始支持Core Image 了 还没去看 Mac 上的CI是很强大的
CFNetwork --- 从来没用过 我一般都会用ASIHttpRequset 封装好的高层网络库 OBJC实现的 CFNetwork 好像是C实现
Core Location --- 获取位置的库 东西很少 很简单 OBJC
AVFoundation --- 播放视频相关的库 最近正在学习
这些算是学iOS开发的一些方法 当时要是有人告诉我这些 估计少走不少弯路
还有提醒各位初学者 刚开始学的时候 会有几个月的低谷期 很容易放弃 如果挺过最开始的几个月 后来就越学越容易了
