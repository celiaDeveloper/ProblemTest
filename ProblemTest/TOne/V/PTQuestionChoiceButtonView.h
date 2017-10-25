//
//  PTQuestionChoiceButtonView.h
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ChoiceButtonStatusNormal,   // 没选中 选项白色
    ChoiceButtonStatusSelected, // 用户选中 选项红色
    ChoiceButtonStatusCorrect,  // 正确答案 选项绿色
} ChoiceButtonStatus;

@class PTQuestionChoiceButtonView;
@protocol ChoiceButtonViewDelegate <NSObject>

- (void)touchChoiceButton:(PTQuestionChoiceButtonView *)btnView;

@end

@interface PTQuestionChoiceButtonView : UIView

@property (nonatomic, weak) id <ChoiceButtonViewDelegate>delegate;

/** ChoiceType 决定了按钮是A、B还是C */
@property (nonatomic, assign) NSInteger ChoiceType;

/** 决定了按钮的背景颜色 */
@property (nonatomic, assign) ChoiceButtonStatus status;

/** 选项答案 */
@property (nonatomic, strong) NSString *choiceDesc;

@end
