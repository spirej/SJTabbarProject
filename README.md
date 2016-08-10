# SJTabbarProject
######先来看一下效果图：
>1.支持导航栏颜色自定义
2.支持返回按钮自定义
3.支持导航栏右侧按钮自定义
4.支持导航栏标题自定义
5.支持所有页面手势侧滑
6.支持tabbar item 文字颜色自定义（选中状态和非选中状态）
![](http://upload-images.jianshu.io/upload_images/1276164-5f3f97166d622eca.gif?imageMogr2/auto-orient/strip)

- 1.导入原资源，如tabbar的items图片等
- 2.创建.pch文件
>在项目->Bulid Settings->搜prefix header->在后面加入你的.pch文件的绝对路径
（一个简单方法就是点出prefix header后面的框后，把工程目录里面的.pch文件拖到框里，就自动生成它的绝对路径了）
- 3.导入需要使用的三方库MLNavigationController，这个控制器继承自UINavigationController，加入了返回手势`也可以用系统的导航栏，系统的导航栏现在也自带返回滑动手势`
- 4.创建继承于UITabBarController的tabbar控制器
- 5.AppDelegate中初始化
```
self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
self.window.backgroundColor = [UIColor whiteColor];           
self.window.rootViewController = [[SJTabBarViewController alloc] init];;
[self.window makeKeyAndVisible];
```
- 6.创建基类控制器 如：SJBaseViewController。在基类控制器里面主要设置导航栏及其一些属性
~6.1 基类 .h文件
![](http://upload-images.jianshu.io/upload_images/1276164-e43f123ef2282c59.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
~6.2 基类 .m文件
//设置导航栏颜色
```
 - (void)setNavBarStyle
{
        self.titleViewLB.textColor = color_whiteColor;
        self.navigationController.navigationBar.barTintColor = kNavigationBarColor;
        self.navigationController.navigationBar.translucent = NO;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"account_headBg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [navigationBar setShadowImage:[UIImage new]];
}
```

  //baseBack方法
```
 - (void)baseBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
```

 //setter and getter方法
```
 - (UILabel *)titleViewLB
{
    if (_titleViewLB == nil) {
     _titleViewLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-140, 44)];
     _titleViewLB.backgroundColor = [UIColor clearColor];
     _titleViewLB.textColor = color_whiteColor
     _titleViewLB.font = XSBlodFont(19);
     _titleViewLB.textAlignment = NSTextAlignmentCenter;
    }
    return _titleViewLB;
}

 - (void)setNavTitle:(NSString *)navTitle{
    _titleViewLB.text = navTitle;
}

 - (void)setNavTitleColor:(UIColor *)navTitleColor{
    _titleViewLB.textColor = navTitleColor;
}

 - (void)setShowBack:(BOOL)showBack
{
    if (showBack) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 20, 44);
        [_backButton setImage:[UIImage imageNamed:@"back-white"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(baseBack) forControlEvents:UIControlEventTouchUpInside];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
        backItem.style = UIBarButtonItemStylePlain;
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.hidesBackButton = YES;
    }
    //解决titleView不能居中的问题
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 35, 35);
    button.hidden = YES;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
}

 - (void)setShowLeftButton:(BOOL)showLeftButton
{
    if (showLeftButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 35, 35);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [button addTarget:self action:@selector(leftBarButtonItemTouchedUpInSide) forControlEvents:UIControlEventTouchUpInside];
    }
}

 - (void)setShowRightButton:(BOOL)showRightButton
{
    if (showRightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, -15);
        //可以根据自己想要的图标在目标控制器里设置
//        [_rightButton setImage:[UIImage imageNamed:@"more_icon_forum"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        [_rightButton addTarget:self action:@selector(rightBarButtonItemTouchedUpInSide) forControlEvents:UIControlEventTouchUpInside];
    }
}
```
//touch up inside响应按钮方法
```
 - (void)leftBarButtonItemTouchedUpInSide
{
    //根据自己需要实现
    NSLog(@"leftBarButtonItemTouchedUpInSide未实现");
}

 - (void)rightBarButtonItemTouchedUpInSide
{
    //根据自己需要实现
    NSLog(@"rightBarButtonItemTouchedUpInSide未实现");
}
```
- 7.创建tabbar Items 控制器，tabbar有几个items就创建几个，继承自BaseViewController

- 8.创建tabbar控制器，继承自UITabBarController
~8.1 遵守协议：UITabBarDelegate，UITabBarControllerDelegate
~8.2 items控制器组
  >@property(nonatomic,strong)NSMutableArray *viewControllers; 

 ~8.3 初始化控制器
```
 - (void)setUpControllers
{
    SJOneViewController * oneVC = [[SJOneViewController alloc] init];
    MLNavigationController *oneNav = [[MLNavigationController alloc] initWithRootViewController:oneVC];
    SJTwoViewController * twoVC = [[SJTwoViewController alloc] init];
    MLNavigationController *twoNav = [[MLNavigationController alloc] initWithRootViewController:twoVC];
    SJThreeViewController *threeVC = [[SJThreeViewController alloc] init];
    MLNavigationController *threeNav = [[MLNavigationController alloc] initWithRootViewController:threeVC];
    [self.viewControllers addObject:oneNav];
    [self.viewControllers addObject:twoNav];
    [self.viewControllers addObject:threeNav];
}
```
~8.4 添加子控制器，初始化tabbarItem 方法
```
 - (void)addController:(UIViewController *)viewController title:(NSString *)title normolImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    viewController.tabBarItem.title = title;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    
    UIImage *selectedImage = [UIImage imageNamed:selectImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:viewController];
}
```
~8.5 设置文字不同状态下属性方法
```
 - (void)setUpTabbarItemTextAttributes
{
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.00f green:0.64f blue:0.51f alpha:1.00f];
    //选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *tabbarItem = [UITabBarItem appearance];
    [tabbarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
```
~8.6 UITabBarControllerDelegate代理方法（可选实现）
```
 - (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
     UINavigationController *nav = (UINavigationController *)viewController;
     UIViewController *vc = [nav.viewControllers objectAtIndex:0];
     NSLog(@"current viewcontroller is %@", vc);
    }
    return YES;
}
```
~8.7 tabbar items 各属性赋值（核心代码示例）
```
NSArray *array = @[@{@"title":@"杀敌",@"normalImageName":@"battle_win_kill",@"selectImageName":@"battle_lose_kill"},
                       @{@"title":@"死亡",@"normalImageName":@"battle_win_death",@"selectImageName":@"battle_lose_death"},
                       @{@"title":@"助攻",@"normalImageName":@"battle_win_assist",@"selectImageName":@"battle_lose_assist"}];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        UIViewController *vc = self.viewControllers[idx];
        NSString *title = [dic objectForKey:@"title"];
        NSString *normalImageName = [dic objectForKey:@"normalImageName"];
        NSString *selectImageName = [dic objectForKey:@"selectImageName"];
        
        [self addController:vc title:title normolImageName:normalImageName selectImageName:selectImageName];
    }];
    [self setUpTabbarItemTextAttributes];
    self.delegate = self;
```
- 9.至此基本完毕，在目标控制器里面，可以选择性的实现基类的一些方法来自定义目标控制器，如：
①目标控制器的navTitle
<pre>[self setNavTitle:@"杀敌"];</pre>
②是否有返回按钮，默认无
<pre>[self setShowRightButton:YES];</pre>
③设置navigationItem.rightBarButtonItem的图标
<pre>[self.rightButton setImage:[UIImage imageNamed:@"battle_win_death"] forState:UIControlStateNormal];</pre>
④rightBarButtonItem的点击响应放法
<pre>- (void)rightBarButtonItemTouchedUpInSide{
//your code
}</pre>
#####文章为作者辛苦码出来的，转载请注明出处，喜欢的话请star😍一下。示例代码链接：[https://github.com/SPIREJ/SJTabbarProject](https://github.com/SPIREJ/SJTabbarProject)
