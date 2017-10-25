//
//  PTTestChoiceButtonView.h
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTQuestionChoiceViewDelegate <NSObject>

// 更新用户的选择
- (void)updateTheSelectChoice:(NSArray *)choiceArray;

@end

@interface PTQuestionChoiceView : UIView

@property (nonatomic, weak) id <PTQuestionChoiceViewDelegate>delegate;

/** 之前已选中的选项  数组中存A、B、C等数据 */
@property (nonatomic, strong) NSArray *haveSelectChoice;

/** 正确答案  我的错题页面使用 */
@property (nonatomic, strong) NSArray *correctChoice;

/** 类型： 单选/多选 */
@property (nonatomic, assign) NSInteger type;

/** 设置各个选项 */
- (void)setChoiceData:(NSArray *)array index:(NSInteger)index;

@end
