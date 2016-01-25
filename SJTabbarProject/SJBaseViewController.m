//
//  SJBaseViewController.m
//  SJTabbarProject
//
//  Created by SPIREJ on 16/1/22.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJBaseViewController.h"

@interface SJBaseViewController ()

@end

@implementation SJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kVCViewBGColor;
    self.navigationItem.titleView = self.titleViewLB;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.title = @"";
    
    [self setNavBarStyle];
}

//设置导航栏颜色
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

- (void)baseBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter and getter
- (UILabel *)titleViewLB
{
    if (_titleViewLB == nil) {
        _titleViewLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-140, 44)];
        _titleViewLB.backgroundColor = [UIColor clearColor];
        _titleViewLB.textColor = color_whiteColor;
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
#pragma mark - touch up in side
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
