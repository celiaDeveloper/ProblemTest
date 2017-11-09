//
//  PTWrongView.m
//  ProblemTest
//
//  Created by Celia on 2017/11/8.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "PTWrongView.h"
#import "PTWrongCell.h"

static NSString *const cellIDTestWrongCell = @"TestWrongCellID";

@interface PTWrongView() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PTWrongView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [NSArray array];
        [self createInterface];
    }
    return self;
}


#pragma mark - 代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PTWrongCell *cell = [PTWrongCell cellWithTableView:tableView cellID:cellIDTestWrongCell];
    cell.indexPathRow = indexPath.row;
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - 数据处理
- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    [self.tableView reloadData];
}


#pragma mark - 视图布局
- (void)createInterface {
    [self addSubview:self.tableView];
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor hex:@"f0f2f5"];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsZero;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.estimatedRowHeight = 215*HPscale_W;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
