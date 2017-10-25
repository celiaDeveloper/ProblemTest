//
//  PTTestTopicModel.h
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTTestTopicModel : NSObject

@property (nonatomic, strong) NSString *test_id;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *title;  //题目
@property (nonatomic, strong) NSString *type;   // 0单选
@property (nonatomic, strong) NSArray *option_xuan; //选项
@property (nonatomic, strong) NSString *answer; //正确答案
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *topic_id;

@end
