//
//  TOneViewController.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTestFuncViewController.h"
#import "PTQuestionViewController.h"
#import "PTWrongViewController.h"

@interface PTestFuncViewController ()

@end

@implementation PTestFuncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"试题详情";
    [self createInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createInterface {
    
    UIButton *startBtn = [UIButton initButtonTitleFont:18 titleColor:[UIColor whiteColor] titleName:@"开始测试" backgroundColor:[UIColor darkGrayColor] radius:3.0];
    startBtn.tag = 200+1;
    startBtn.frame = CGRectMake(20, 64+50, HPScreenWidth - 40, 50);
    [startBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *checkBtn = [UIButton initButtonTitleFont:18 titleColor:[UIColor whiteColor] titleName:@"查看错题" backgroundColor:[UIColor darkGrayColor] radius:3.0];
    checkBtn.tag = 200+2;
    checkBtn.frame = CGRectMake(startBtn.left, startBtn.bottom + 20, startBtn.width, startBtn.height);
    [checkBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    [self.view addSubview:checkBtn];
}

- (void)btnAction:(UIButton *)btn {
    
    if (btn.tag == 201) {
        PTQuestionViewController *vc = [[PTQuestionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        PTWrongViewController *vc = [[PTWrongViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
