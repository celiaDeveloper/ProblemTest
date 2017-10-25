//
//  CustomCalloutView.m
//  HelloAmap
//
//  Created by xiaoming han on 14-10-21.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "CustomCalloutView.h"
#import <QuartzCore/QuartzCore.h>

#define kMinWidth  20
#define kMaxWidth  200
#define kHeight    44

#define kHoriMargin 3
#define kVertMargin 3

#define kFontSize   14

#define kArrorHeight        8
#define kBackgroundColor    [UIColor whiteColor]


@interface CustomCalloutView ()

@end

@implementation CustomCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
//    self.layer.contents = (__bridge id)[UIImage imageNamed:@"icon_MapAnnotation"].CGImage;
//    self.layer.contentsGravity = kCAGravityResizeAspect;
    UIImageView *backimage = [UIImageView initImageView:@"icon_MapAnnotation"];
    backimage.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:backimage];
    
    self.member = [UILabel initLabelTextFont:16 textColor:[UIColor whiteColor] title:@"党员  个"];
    self.active = [UILabel initLabelTextFont:16 textColor:[UIColor whiteColor] title:@"活动  个"];
    self.ogrName = [UILabel initLabelTextFont:20 textColor:[UIColor blackColor] title:DJTEST_TITLE];
    self.ogrName.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:_member];
    [self addSubview:_active];
    [self addSubview:_ogrName];
    
    [_member mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-10);
        make.centerX.equalTo(self);
    }];
    [_active mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(-10);
        make.centerX.equalTo(self);
    }];
    [_ogrName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_centerX).offset(15);
    }];
}

#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
//    [self drawInContext:UIGraphicsGetCurrentContext()];
//    
//    self.layer.shadowColor = [[UIColor grayColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, kBackgroundColor.CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


@end
