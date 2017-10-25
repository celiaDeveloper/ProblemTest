//
//  HPAnnotationView.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPAnnotationView.h"


#define kCalloutWidth       90
#define kCalloutHeight      90

@interface HPAnnotationView ()

@end

@implementation HPAnnotationView

#pragma mark - Override

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            _calloutView.center = CGPointMake(25.5/2, -kCalloutWidth/2+25.5/2);
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

// 重新此函数，用以实现点击calloutView判断为点击该annotationView
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

@end

