//
//  PTQuestionChoiceButtonView.m
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTQuestionChoiceButtonView.h"

@interface PTQuestionChoiceButtonView ()
@property (nonatomic, strong) UIButton *choiceBtn;      // 选项按钮
@property (nonatomic, strong) UILabel *answerLabel;     // 答案描述
@end

@implementation PTQuestionChoiceButtonView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, HPScreenWidth, HP_SCALE_H(60));
        [self choiceCreateInterface];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self choiceCreateInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.choiceBtn.mas_right).offset(10);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.choiceBtn);
    }];
}

#pragma mark - 内部逻辑实现
- (void)tapChoiceBtnViewAction {
    
    if (self.status == ChoiceButtonStatusNormal) {
        self.status = ChoiceButtonStatusSelected;
    }else if (self.status == ChoiceButtonStatusSelected) {
        self.status = ChoiceButtonStatusNormal;
    }
    
    if ([self.delegate respondsToSelector:@selector(touchChoiceButton:)]) {
        [self.delegate touchChoiceButton:self];
    }
}

#pragma mark - 数据处理
- (void)setChoiceType:(NSInteger)ChoiceType {
    
    _ChoiceType = ChoiceType;
    switch (ChoiceType) {
        case 0:
            [self.choiceBtn setTitle:@"A" forState:UIControlStateNormal];
            break;
        case 1:
            [self.choiceBtn setTitle:@"B" forState:UIControlStateNormal];
            break;
        case 2:
            [self.choiceBtn setTitle:@"C" forState:UIControlStateNormal];
            break;
        case 3:
            [self.choiceBtn setTitle:@"D" forState:UIControlStateNormal];
            break;
        case 4:
            [self.choiceBtn setTitle:@"E" forState:UIControlStateNormal];
            break;
        case 5:
            [self.choiceBtn setTitle:@"F" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (void)setStatus:(ChoiceButtonStatus)status {
    
    _status = status;
    switch (status) {
        case ChoiceButtonStatusNormal:
        {
            [_choiceBtn setTitleColor:[UIColor hex:@"121212"] forState:UIControlStateNormal];
            [_choiceBtn setBackgroundImage:GetImage(@"study_circle_white") forState:UIControlStateNormal];
        }
            break;
        case ChoiceButtonStatusSelected:
        {
            [_choiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_choiceBtn setBackgroundImage:GetImage(@"study_circle_wrong") forState:UIControlStateNormal];
        }
            break;
        case ChoiceButtonStatusCorrect:
        {
            [_choiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_choiceBtn setBackgroundImage:GetImage(@"study_circle_correct") forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (void)setChoiceDesc:(NSString *)choiceDesc {
    
    _choiceDesc = choiceDesc;
    self.answerLabel.text = choiceDesc;
}

#pragma mark - 视图布局
- (void)choiceCreateInterface {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.choiceBtn];
    [self addSubview: self.answerLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChoiceBtnViewAction)];
    [self addGestureRecognizer:tap];
    
}

#pragma mark - 懒加载
- (UIButton *)choiceBtn {
    
    if (!_choiceBtn) {
        _choiceBtn = [UIButton initButtonTitleFont:20 titleColor:[UIColor hex:@"121212"] titleName:@""];
        _choiceBtn.frame = CGRectMake(15, 10, 20, 20);
        [_choiceBtn setBackgroundImage:GetImage(@"study_circle_white") forState:UIControlStateNormal];
        _choiceBtn.userInteractionEnabled = false;
    }
    return _choiceBtn;
}

- (UILabel *)answerLabel {
    
    if (!_answerLabel) {
        _answerLabel = [UILabel initLabelTextFont:24 textColor:[UIColor hex:@"424242"] title:@""];
        _answerLabel.numberOfLines = 0;
        _answerLabel.frame = CGRectMake(_choiceBtn.right + 10, _choiceBtn.top, self.width - _choiceBtn.right - 25, 20);
    }
    return _answerLabel;
}

@end
