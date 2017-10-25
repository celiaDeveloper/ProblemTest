//
//  PTHomeViewController.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTHomeViewController.h"
#import "PTestFuncViewController.h"

@interface PTHomeViewController ()

@end

@implementation PTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton initButtonTitleFont:18 titleColor:[UIColor whiteColor] titleName:@"选项加载到cell上" backgroundColor:[UIColor darkGrayColor] radius:3.0];
    btn.frame = CGRectMake(20, 64 + 50, HPScreenWidth - 40, 50);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction:(UIButton *)btn {
    
    PTestFuncViewController *vc = [[PTestFuncViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
