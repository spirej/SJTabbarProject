//
//  SJTabBarViewController.m
//  SJTabbarProject
//
//  Created by SPIREJ on 16/1/22.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJTabBarViewController.h"
#import "SJOneViewController.h"
#import "SJTwoViewController.h"
#import "SJThreeViewController.h"

@interface SJTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)NSMutableArray *viewControllers;

@end

@implementation SJTabBarViewController
@synthesize viewControllers;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewControllers = [NSMutableArray arrayWithCapacity:3];
    [self setUpControllers];
    
    //tabbar backgroundColor
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //tabbar的分割线的颜色
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tab_bar_line"]];
    
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

}

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

/**
 *  添加子控制器，初始化tabbarItem
 */
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

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        UIViewController *vc = [nav.viewControllers objectAtIndex:0];
        NSLog(@"current viewcontroller is %@", vc);
    }
    return YES;
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
