//
//  HPTableView.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/5.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPTableView.h"

@implementation HPTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.backgroundColor = DJCOLOR_Gray_TableBG;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.separatorColor = DJCOLOR_LINE;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
    }
    return self;
}

-(void)setTableFooterHeight:(CGFloat)tableFooterHeight
{
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HPMW, tableFooterHeight)];
    HeaderView.backgroundColor = _HeaderAndFooterBackgroundColor ? : DJCOLOR_Gray_TableBG;
    self.tableFooterView = HeaderView;
}

-(void)setTableHeaderHeight:(CGFloat)tableHeaderHeight
{
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HPMW, tableHeaderHeight)];
    HeaderView.backgroundColor = _HeaderAndFooterBackgroundColor ? : DJCOLOR_Gray_TableBG;
    self.tableHeaderView = HeaderView;
}

@end
