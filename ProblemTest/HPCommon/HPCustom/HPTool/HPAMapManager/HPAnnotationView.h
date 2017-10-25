//
//  HPAnnotationView.h
//  ZHDJ
//
//  Created by 秦正华 on 2017/9/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface HPAnnotationView : MAAnnotationView

@property (nonatomic, strong) CustomCalloutView *calloutView;

@end
