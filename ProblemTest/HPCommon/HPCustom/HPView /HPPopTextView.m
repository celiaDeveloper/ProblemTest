//
//  QZTopTextView.m
//  circle_iphone
//
//  Created by MrYu on 16/8/17.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import "HPPopTextView.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface HPPopTextView()
{
    UITapGestureRecognizer *_tap;
}
@end

@implementation HPPopTextView

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_backgroundView removeGestureRecognizer:_tap];
}

-(instancetype)init
{
    if (self = [super init]) {
        
        [self createInterface];
    }
    return self;
}

-(void)createInterface
{
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 60);
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.textWriteView];
    [self addSubview:self.issueBtn];
    
    // 添加键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 监听键盘
- (void)keyboardWillAppear:(NSNotification *)notif
{
    
    if ([self.textWriteView isFirstResponder]) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];

        [UIView animateWithDuration:duration animations:^{
            CGRect tempFrame = self.frame;
            tempFrame.origin.y = SCREEN_HEIGHT - keyboardSize.height - self.bounds.size.height;
            self.frame = tempFrame;
        }];
        [self.superview addSubview:self.backgroundView];
        [self.superview addSubview:self];
    }
}
- (void)keyboardWillDisappear:(NSNotification *)notif
{
    NSDictionary *info = [notif userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect tempFrame = self.frame;
        tempFrame.origin.y = SCREEN_HEIGHT;
        self.frame = tempFrame;
    }];
    [self.backgroundView removeFromSuperview];
}

#pragma mark - 非通知调用键盘消失方法
- (void)keyboardWillDisappear
{
    [self.textWriteView resignFirstResponder];
}

#pragma mark - 点击发布按钮
- (void)issueBtnClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendComment:)]) {
        [self.textWriteView resignFirstResponder];
        [self.delegate sendComment:_textWriteView.text];
    }
}

-(void)textWriteViewChanged:(UITextField *)textFiled
{
    _issueBtn.enabled = textFiled.text.length > 0 ? YES : NO;
}

#pragma mark - 懒加载
-(UITextField *)textWriteView
{
    if (!_textWriteView) {
        _textWriteView = [[UITextField alloc]initWithFrame:CGRectMake(10, (self.bounds.size.height-40)/2, self.bounds.size.width-20-50-5, 40)];
        _textWriteView.backgroundColor = HPRGB(247, 247, 247);
        [_textWriteView rounded:5 width:1 color:HPRGB(222, 222, 222)];
        _textWriteView.placeholder = @"评论";
        _textWriteView.font = [UIFont systemFontOfSize:22];
        [_textWriteView addTarget:self action:@selector(textWriteViewChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textWriteView;
}

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _tap = [[UITapGestureRecognizer alloc] init];
        [_tap addTarget:self action:@selector(keyboardWillDisappear)];
        [_backgroundView addGestureRecognizer:_tap];
    }
    return _backgroundView;
}

-(UIButton *)issueBtn
{
    if (!_issueBtn) {
        _issueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _issueBtn.frame = CGRectMake(self.bounds.size.width-50-10, (self.bounds.size.height-30)/2, 50, 30);
        [_issueBtn setTitle:@"发送" forState:UIControlStateNormal];
        _issueBtn.layer.cornerRadius = 5;
        _issueBtn.clipsToBounds = YES;
        [_issueBtn setBackgroundImage:[UIImage imageWithColor:HPRGB(201, 23, 30)] forState:0];
        [_issueBtn setBackgroundImage:[UIImage imageWithColor:HPRGB(240, 240, 240)] forState:UIControlStateDisabled];
        _issueBtn.enabled = NO;
        [_issueBtn addTarget:self action:@selector(issueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _issueBtn;
}

@end
