//
//  PTQuestionBottomView.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTQuestionBottomView.h"

@interface PTQuestionBottomView ()
@property (nonatomic, strong) UIView *lineView;         // 灰线条
@property (nonatomic, strong) UIButton *submitBtn;      // 交卷
@property (nonatomic, strong) UIButton *timeBtn;        // 计时
@property (nonatomic, strong) UIButton *countBtn;       // 计题
@property (nonatomic, assign) NSInteger suitFont;       //
@end

@implementation PTQuestionBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}


#pragma mark - 内部逻辑实现
- (void)submitBtnAction:(UIButton *)btn {
    
    if (self.PTQuestionBottomViewSubmitBlock) {
        self.PTQuestionBottomViewSubmitBlock();
    }
}

#pragma mark - 代理协议
#pragma mark - 数据处理
- (void)setTimeString:(NSString *)timeString {
    
    [self.timeBtn setTitle:timeString forState:UIControlStateNormal];
}

- (void)setCountString:(NSString *)countString {
    
    [self.countBtn setTitle:countString forState:UIControlStateNormal];
    NSString *str = [[countString componentsSeparatedByString:@"/"] lastObject];
    NSString *changeStr = [NSString stringWithFormat:@"/%@",str];
    [_countBtn.titleLabel changeTextColor:[UIColor hex:@"858585"] toText:changeStr];
}


#pragma mark - 视图布局
- (void)createInterface {
    
    CGFloat btnW = self.width / 3;
    CGFloat btnH = self.height;
    
    self.suitFont = 16;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        self.suitFont = 14;
    }
    
    [self addSubview:self.lineView];
    [self addSubview:self.submitBtn];
    [self addSubview:self.timeBtn];
    [self addSubview:self.countBtn];
    
    self.lineView.frame = CGRectMake(0, 0, self.width, 0.8);
    self.submitBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.timeBtn.frame = CGRectMake(btnW, 0, btnW, btnH);
    self.countBtn.frame = CGRectMake(btnW *2, 0, btnW, btnH);
    
    [self.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.timeBtn.userInteractionEnabled = false;
    self.countBtn.userInteractionEnabled = false;
}


#pragma mark - 懒加载
- (UIButton *)submitBtn {
    
    if (!_submitBtn) {
        _submitBtn = [UIButton initButtonTitleFont:_suitFont titleColor:[UIColor hex:@"121212"] backgroundColor:nil imageName:@"study_test_a" titleName:@"交卷"];
        [_submitBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    }
    return _submitBtn;
}

- (UIButton *)timeBtn {
    
    if (!_timeBtn) {
        _timeBtn = [UIButton initButtonTitleFont:_suitFont titleColor:[UIColor hex:@"3f8bf3"] backgroundColor:nil imageName:@"study_test_b" titleName:@"00:00"];
        _timeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:_suitFont];
        [_timeBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    }
    return _timeBtn;
}

- (UIButton *)countBtn {
    
    if (!_countBtn) {
        _countBtn = [UIButton initButtonTitleFont:_suitFont titleColor:[UIColor hex:@"262626"] backgroundColor:nil imageName:@"study_test_c" titleName:@"0/0"];
        [_countBtn layoutButtonWithEdgeInsetsStyle:HPButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        [_countBtn.titleLabel changeTextColor:[UIColor hex:@"858585"] toText:@"/0"];
    }
    return _countBtn;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [UIView initViewBackColor:[UIColor hex:@"e3e3e3"]];
    }
    return _lineView;
}

@end
