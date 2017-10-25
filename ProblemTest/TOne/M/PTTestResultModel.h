//
//  PTTestResultModel.h
//  ProblemTest
//
//  Created by Celia on 2017/10/24.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTTestResultModel : NSObject

@property (nonatomic, copy) NSString *use_time;     //用时
@property (nonatomic, copy) NSString *questionNum;  //问题数
@property (nonatomic, copy) NSString *answerNum;    //答题数
@property (nonatomic, copy) NSString *rightNum;     //正确数
@property (nonatomic, copy) NSString *score;        //得分

@property (nonatomic, copy) NSString *totalScore;   //总分

@end
