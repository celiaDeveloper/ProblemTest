//
//  XMTouchScrollView.m
//  SLYP
//
//  Created by 秦正华 on 2017/4/12.
//  Copyright © 2017年 秦正华. All rights reserved.
//

#import "HPTouchScrollView.h"

@implementation HPTouchScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma mark - 开始触碰
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ( !self.dragging )
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
}
#pragma mark - 触碰结束
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if ( !self.dragging )
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
}
#pragma mark - 取消触碰
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if(!self.dragging)
    {
        [[self nextResponder] touchesCancelled:touches withEvent:event];
    }
}
#pragma mark - 滑动
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if(!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
}

@end
