//
//  PTQuestionView.h
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTQuestionView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *recordAnswer;     // 记录答案

@property (nonatomic, strong) NSString *timeCounting;           // 计时时间

@property (nonatomic, copy) void (^SubmitAnswerBlock)();        // 交卷

@end
