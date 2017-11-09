//
//  PTQuestionCell.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTQuestionCell.h"
#import "PTQuestionChoiceView.h"

@interface PTQuestionCell () <PTQuestionChoiceViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIView *backView;                     // 白背景
@property (nonatomic, strong) UILabel *titleLabel;                  // 题目
@property (nonatomic, strong) UILabel *typeLabel;                   // 题目类型
@property (nonatomic, strong) UIView *middleLine;                   // 中间灰线
@property (nonatomic, strong) PTQuestionChoiceView *choiceView;     // 选项视图

@property (nonatomic, strong) UIButton *lastBtn;                    //上一题
@property (nonatomic, strong) UIButton *nextBtn;                    //下一题

@property (nonatomic, strong) NSArray *choiceDesc;
@end

@implementation PTQuestionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"f5f5f5"];
        [self createInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}

#pragma mark - 内部逻辑实现
- (void)lastBtnAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(PTQuestionCellTapLastQuestion:)]) {
        [self.delegate PTQuestionCellTapLastQuestion:self];
    }
}

- (void)nextBtnAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(PTQuestionCellTapNextQuestion:)]) {
        [self.delegate PTQuestionCellTapNextQuestion:self];
    }
}

#pragma mark - 代理协议
- (void)updateTheSelectChoice:(NSArray *)choiceArray {
    
    if ([self.delegate respondsToSelector:@selector(PTQuestionCellUpdateSelectChoices:cell:)]) {
        [self.delegate PTQuestionCellUpdateSelectChoices:choiceArray.copy cell:self];
    }
    
    if (choiceArray.count) {
        DEBUGLog(@"选择了 %@",choiceArray);
        self.nextBtn.enabled = true;
        self.nextBtn.backgroundColor = [UIColor whiteColor];
    }else {
        DEBUGLog(@"不可  下一步");
        self.nextBtn.enabled = false;
        self.nextBtn.backgroundColor = [UIColor hex:@"cccccc"];
    }
}


#pragma mark - 数据处理
- (void)setModel:(PTTestTopicModel *)model {
    
    _model = model;
    self.titleLabel.text = [@"        " stringByAppendingString:model.title];
    [_titleLabel changeLineSpace:5.0];
    
    
    // 选项拆分
    NSMutableArray *choiceArr = [NSMutableArray array];
    for (NSArray *opArr in model.option_xuan) {
        if (opArr.count >1) {
            [choiceArr addObject:[opArr objectAtIndex:1]];
        }
    }
    self.choiceDesc = choiceArr.copy;
    
    if (_choiceView && [self.scrollV.subviews containsObject:_choiceView]) {
        [self.choiceView removeFromSuperview];
        self.choiceView = nil;
    }
    [self.scrollV addSubview:self.choiceView];
    [self.choiceView setChoiceData:self.choiceDesc index:[model.topic_id integerValue]];
    
    
    // 选项类型
    NSString *typeString = @"单选";
    if ([model.type integerValue] == 0) {
        typeString = @"单选";
    }else if ([model.type integerValue] == 1) {
        typeString = @"多选";
    }
    self.typeLabel.text = typeString;
    self.choiceView.type = [model.type integerValue];
    
    [self layoutIfNeeded];
}

- (void)setIsFirst:(BOOL)isFirst {
    
    _isFirst = isFirst;
    
    if (_lastBtn && [self.scrollV.subviews containsObject:self.lastBtn]) {
        [self.lastBtn removeFromSuperview];
    }
    if (_nextBtn && [self.scrollV.subviews containsObject:self.nextBtn]) {
        [self.nextBtn removeFromSuperview];
    }
    
    
    if (isFirst) {
        [self.scrollV addSubview:self.nextBtn];
    }else {
        
        [self.scrollV addSubview:self.lastBtn];
        [self.scrollV addSubview:self.nextBtn];
    }
    
    self.nextBtn.enabled = false;
    self.nextBtn.backgroundColor = [UIColor hex:@"cccccc"];
}

- (void)setHaveSelectChoices:(NSArray *)haveSelectChoices {
    
    _haveSelectChoices = haveSelectChoices;
    if (haveSelectChoices.count) {
        if (self.choiceView) {
            self.choiceView.haveSelectChoice = haveSelectChoices;
        }
        self.nextBtn.enabled = true;
        self.nextBtn.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - 视图布局
- (void)createInterface {
    
    [self.contentView addSubview:self.scrollV];
    [self.scrollV addSubview:self.backView];
    [self.scrollV addSubview:self.titleLabel];
    [self.scrollV addSubview:self.typeLabel];
    [self.scrollV addSubview:self.middleLine];
    
}

- (void)setConstraints {
    
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollV).offset(15);
        make.width.mas_equalTo(self.contentView.width - 30);
        make.top.equalTo(self.scrollV).offset(18);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(32, 20));
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(0.5);
    }];
    
    if (_choiceView && [self.scrollV.subviews containsObject:_choiceView]) {
        [self.choiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.middleLine.mas_bottom).offset(5);
            
            make.height.mas_equalTo(HP_SCALE_H(60) * _choiceDesc.count);
        }];
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.choiceView);
        }];
        
    }else {
        
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.middleLine);
        }];
    }
    
    
    
    if (self.lastBtn && [self.scrollV.subviews containsObject:self.lastBtn]) {
        
        [self.lastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(HP_SCALE_W(35));
            make.top.equalTo(self.backView.mas_bottom).offset(50);
            make.size.mas_equalTo(CGSizeMake(HP_SCALE_W(112), HP_SCALE_H(30)));
        }];
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(HP_SCALE_W(-35));
            make.top.equalTo(self.lastBtn);
            make.size.mas_equalTo(CGSizeMake(HP_SCALE_W(112), HP_SCALE_H(30)));
        }];
        
    }else if (self.nextBtn && [self.scrollV.subviews containsObject:self.nextBtn]) {
        
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.backView.mas_bottom).offset(50);
            make.size.mas_equalTo(CGSizeMake(HP_SCALE_W(112), HP_SCALE_H(30)));
        }];
    }
    
    //30+HP_SCALE_H(30)+50+HP_SCALE_H(60) * _choiceDesc.count+25+titleLabelHeight+18
    //123+HP_SCALE_H(30)+HP_SCALE_H(60) * _choiceDesc.count+titleLabelHeight
    self.scrollV.contentSize = CGSizeMake(self.width, 123+HP_SCALE_H(30)+HP_SCALE_H(60) * _choiceDesc.count+self.titleLabel.height);
    
}


#pragma mark - 懒加载
- (UIScrollView *)scrollV {
    
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollV.backgroundColor = [UIColor hex:@"f5f5f5"];
        _scrollV.scrollEnabled = true;
    }
    return _scrollV;
}

- (UIView *)backView {
    
    if (!_backView) {
        _backView = [UIView initViewBackColor:[UIColor whiteColor]];
    }
    return _backView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel initLabelTextFont:26 textColor:[UIColor hex:@"262626"] title:@""];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)typeLabel {
    
    if (!_typeLabel) {
        _typeLabel = [UILabel initLabelTextFont:18 textColor:[UIColor whiteColor] title:@""];
        _typeLabel.backgroundColor = [UIColor hex:@"3f8bf3"];
        _typeLabel.layer.cornerRadius = 2.0;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}

- (UIView *)middleLine {
    
    if (!_middleLine) {
        _middleLine = [UIView initViewBackColor:[UIColor hex:@"ebebeb"]];
    }
    return _middleLine;
}

- (PTQuestionChoiceView *)choiceView {
    
    if (!_choiceView) {
        _choiceView = [[PTQuestionChoiceView alloc] init];
        _choiceView.delegate = self;
    }
    return _choiceView;
}

- (UIButton *)lastBtn {
    
    if (!_lastBtn) {
        _lastBtn = [UIButton initButtonTitleFont:24 titleColor:[UIColor hex:@"858585"] titleName:@"上一题" backgroundColor:[UIColor whiteColor] radius:3.0];
        _lastBtn.layer.borderColor = [UIColor hex:@"b2b2b2"].CGColor;
        _lastBtn.layer.borderWidth = 0.5;
        [_lastBtn addTarget:self action:@selector(lastBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastBtn;
}

- (UIButton *)nextBtn {
    
    if (!_nextBtn) {
        _nextBtn = [UIButton initButtonTitleFont:24 titleColor:[UIColor hex:@"858585"] titleName:@"下一题" backgroundColor:[UIColor hex:@"cccccc"] radius:3.0];
        _nextBtn.layer.borderColor = [UIColor hex:@"b2b2b2"].CGColor;
        _nextBtn.layer.borderWidth = 0.5;
        _nextBtn.enabled = false;
        [_nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
