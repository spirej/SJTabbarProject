//
//  SJNextViewController.m
//  SJTabbarProject
//
//  Created by SPIREJ on 16/1/22.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "SJNextViewController.h"
#import "SJNext2ViewController.h"

@interface SJNextViewController ()

@end

@implementation SJNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navTitle = @"第二级菜单";
    [self setShowBack:YES];
    [self setUpUI];
}

- (void)setUpUI{
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake((kDeviceWidth-120)/2,KDeviceHeight/2-200, 120, 50);
    [nextBtn setTitle:@"下一级菜单" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextBtn addTarget:self action:@selector(netxBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}
-(void)netxBtnClick{
    SJNext2ViewController *next2VC = [[SJNext2ViewController alloc] init];
    [self.navigationController pushViewController:next2VC animated:YES];
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
