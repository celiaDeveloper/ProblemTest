//
//  PTTestWrongModel.h
//  ProblemTest
//
//  Created by Celia on 2017/11/8.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTTestWrongModel : NSObject
@property (nonatomic, strong) NSString *error_id;
@property (nonatomic, strong) NSString *test_id;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;          //题目
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *option;         //选项
@property (nonatomic, strong) NSString *answer;         //正确答案
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *select_answer;
@end
