//
//  PTNavigationController.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTNavigationController.h"

@interface PTNavigationController ()

@end

@implementation PTNavigationController

+ (void)initialize {
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = COLOR_M;
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {  // 非根视图
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:GetImage(@"arrow") forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        
        // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = true;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIButton *)btn {
    [self popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
