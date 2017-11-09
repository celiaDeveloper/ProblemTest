//
//  PTWrongCell.h
//  ProblemTest
//
//  Created by Celia on 2017/11/8.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTestWrongModel.h"

@interface PTWrongCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID;

@property (nonatomic, assign) NSInteger indexPathRow;
@property (nonatomic, strong) PTTestWrongModel *model;
@end
