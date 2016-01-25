//
//  SJBaseViewController.h
//  SJTabbarProject
//
//  Created by SPIREJ on 16/1/22.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLNavigationController.h"

@interface SJBaseViewController : UIViewController
@property(nonatomic, assign)BOOL showBack; /**是否显示返回按钮，默认 NO*/
@property(nonatomic, assign)BOOL showRedBack; /**是否显示返回按钮，红色的返回按钮*/
@property(nonatomic, assign)BOOL showLeftButton, showRightButton; /**是否显示导航栏左边右边的按钮*/
@property(nonatomic, strong)UIButton *backButton;
@property(nonatomic, strong)UIButton *rightButton;

@property(nonatomic, strong)UILabel *titleViewLB; /** navigationItem.titleView */
@property(nonatomic, copy)NSString *navTitle; /** navigationItem.title */
@property(nonatomic, strong)UIColor *navTitleColor; /** navigationItem.title color */
@property(nonatomic, strong)UIViewController *popToViewController; /**多级跳转时的中介参数*/
/**
 *  返回按钮点击事件
 */
- (void)baseBack;

@end
