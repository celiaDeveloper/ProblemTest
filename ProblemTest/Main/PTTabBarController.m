//
//  PTTabBarController.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTTabBarController.h"
#import "PTHomeViewController.h"
#import "PTNavigationController.h"

@interface PTTabBarController ()

@end

@implementation PTTabBarController

#pragma mark - 视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 内部逻辑实现
#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
#pragma mark - 视图布局
- (void)createInterface {
    // 设置顶部状态栏为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置TabBarItem选中文字颜色
    UITabBarItem *bar = [UITabBarItem appearance];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    
    PTHomeViewController *homeVC = [[PTHomeViewController alloc] init];
    [self addItemTitle:@"首页" image:@"foota_normal" selectedImage:@"foota_pressed" controller:homeVC];
}

// 添加item和对应的ViewController
- (void)addItemTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage controller:(UIViewController *)VC {
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage originalImageNamed:image] selectedImage:[UIImage originalImageNamed:selectedImage]];
    
    VC.tabBarItem = item;
    VC.title = title;
    PTNavigationController *nav = [[PTNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}

#pragma mark - 懒加载

@end
