//
//  XMScrollViewController.m
//  项目初始化模板(TableBarStyle)
//
//  Created by 秦正华 on 2017/1/19.
//  Copyright © 2017年 qinzhenghua. All rights reserved.
//

#import "HPScrollViewController.h"
#define HPMB [UIScreen mainScreen].bounds
@interface HPScrollViewController ()

@end

@implementation HPScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.HPScrollView];
    
}

#pragma mark - 懒加载
- (UIScrollView *)HPScrollView {
    if (!_HPScrollView) {
        _HPScrollView = [[UIScrollView alloc]initWithFrame:HPMB];
        _HPScrollView.alwaysBounceVertical = true;
        _HPScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _HPScrollView;
}

@end
