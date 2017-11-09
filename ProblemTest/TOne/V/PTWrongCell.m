//
//  PTWrongCell.m
//  ProblemTest
//
//  Created by Celia on 2017/11/8.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTWrongCell.h"
#import "PTQuestionChoiceView.h"

@interface PTWrongCell()
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *titleLabel;                  // 题目
@property (nonatomic, strong) UILabel *typeLabel;                   // 题目类型
@property (nonatomic, strong) UIView *line;                         // 灰线
@property (nonatomic, strong) PTQuestionChoiceView *choiceView;

@property (nonatomic, strong) NSArray *choiceDesc;
@end

@implementation PTWrongCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID {
    
    PTWrongCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PTWrongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _choiceDesc = [NSArray array];
        [self createInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}


#pragma mark - 数据处理
- (void)setModel:(PTTestWrongModel *)model {
    
    _model = model;
    self.titleLabel.text = [@"        " stringByAppendingString:model.title];
    [_titleLabel changeLineSpace:5.0];
    
    NSString *opString = model.option;
    // 去掉字符串末尾的","
    if ([model.option hasSuffix:@","]) {
        NSInteger opLen = model.option.length;
        opString = [model.option substringToIndex:opLen-1];
    }
    self.choiceDesc = [opString componentsSeparatedByString:@","];
    DEBUGLog(@"我的错题-选项数据：%@",self.choiceDesc);
    
    if (_choiceView && [self.contentView.subviews containsObject:_choiceView]) {
        [self.choiceView removeFromSuperview];
        self.choiceView = nil;
    }
    [self.contentView addSubview:self.choiceView];
    
    // 我的错题，不可编辑
    self.choiceView.userInteractionEnabled = false;
    
    [self.choiceView setChoiceData:self.choiceDesc index:self.indexPathRow+1];
    self.choiceView.correctChoice = @[model.answer];
    self.choiceView.haveSelectChoice = @[model.select_answer];
    DEBUGLog(@"%ld answer -- %@,%@",self.indexPathRow, model.answer, model.select_answer);
    
    
    NSString *typeString = @"单选";
    if ([model.type integerValue] == 0) {
        typeString = @"单选";
    }else if ([model.type integerValue] == 1) {
        typeString = @"多选";
    }
    self.typeLabel.text = typeString;
    
    [self layoutSubviews];
}

#pragma mark - 视图布局
- (void)createInterface {
    
    [self.contentView addSubview:self.grayView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.line];
}

- (void)setConstraints {
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(11);
    }];
    
    if (_choiceView && [self.contentView.subviews containsObject:_choiceView]) {
        
        [self.choiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(HP_SCALE_H(60) * _choiceDesc.count);
            make.bottom.equalTo(self.contentView);
        }];
        
        DEBUGLog(@"choiceViewHeight == %f",HP_SCALE_H(60) * _choiceDesc.count);
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.choiceView.mas_top).offset(-20);
            make.height.mas_equalTo(0.5);
        }];
    }else {
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(0.5);
        }];
        DEBUGLog(@"line bottom == %f",self.line.bottom);
    }
    
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.grayView.mas_bottom).offset(15);
        make.bottom.equalTo(self.line.mas_top).offset(-20);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(32, 20));
    }];
    
}

#pragma mark - 懒加载
- (UIView *)grayView {
    
    if (!_grayView) {
        _grayView = [UIView initViewBackColor:[UIColor hex:@"f0f2f5"]];
    }
    return _grayView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel initLabelTextFont:22 textColor:[UIColor hex:@"262626"] title:@""];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)typeLabel {
    
    if (!_typeLabel) {
        _typeLabel = [UILabel initLabelTextFont:18 textColor:[UIColor whiteColor] title:@"单选"];
        _typeLabel.backgroundColor = [UIColor hex:@"3f8bf3"];
        _typeLabel.layer.cornerRadius = 2.0;
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}

- (UIView *)line {
    
    if (!_line) {
        _line = [UIView initViewBackColor:[UIColor hex:@"ebebeb"]];
    }
    return _line;
}

- (PTQuestionChoiceView *)choiceView {
    
    if (!_choiceView) {
        _choiceView = [[PTQuestionChoiceView alloc] init];
    }
    return _choiceView;
}

@end
