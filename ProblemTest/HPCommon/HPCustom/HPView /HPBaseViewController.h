//
//  HPBaseViewController.h
//  HP_iOS_CommonFrame
//
//  Created by Celia on 2017/8/22.
//  Copyright © 2017年 zhijianshangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, HPRequestResultStatus) {
//    
//    HPRequestResultNoNet,
//    HPRequestResultReturnError,
//    HPRequestResultSuccess,
//};

@interface HPBaseViewController : UIViewController

@property (nonatomic, copy) void (^reconnectAPIBlock)();

@end
