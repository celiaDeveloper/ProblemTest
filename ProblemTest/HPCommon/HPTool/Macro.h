//
//  Macro.h
//  ZHDJ
//
//  Created by Celia on 2017/8/28.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

// 调试DEBUG
#ifdef DEBUG
#define DEBUGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DEBUGLog(...)
#endif


#define HPWeakSelf(type)  __weak typeof(type) weak##type = type; // weak
#define HPStrongSelf(type)  __strong typeof(type) type = weak##type; // strong


// app主窗口
#define HPKeyWindow     [UIApplication sharedApplication].keyWindow

// 主屏幕大小
#define HPScreenBounds  [UIScreen mainScreen].bounds

#define HPScreenWidth   [UIScreen mainScreen].bounds.size.width
#define HPScreenHeight  [UIScreen mainScreen].bounds.size.height

// 偏好设置
#define HPUserdefault   [NSUserDefaults standardUserDefaults]

// 通知
#define HPNOTIF         [NSNotificationCenter defaultCenter]
#define HPNOTIF_ADD(n, f)     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
#define HPNOTIF_POST(n, o)    [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define HPNOTIF_REMV()        [[NSNotificationCenter defaultCenter] removeObserver:self]


// RGB颜色
#define HPRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HPRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]


// GCD - 一次性执行
#define HP_DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

// GCD - 在Main线程上运行
#define HP_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

// GCD - 开启异步线程
#define HP_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


// 获取temp
#define HPPathTemp NSTemporaryDirectory()

// 获取沙盒 Document
#define HPPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒 Cache
#define HPPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

#define URL(URLName) [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLName]]


// 字体
#define HPFontL(s)             [UIFont systemFontOfSize:s weight:UIFontWeightLight]
#define HPFontR(s)             [UIFont systemFontOfSize:s weight:UIFontWeightRegular]
#define HPFontB(s)             [UIFont systemFontOfSize:s weight:UIFontWeightBold]
#define HPFontT(s)             [UIFont systemFontOfSize:s weight:UIFontWeightThin]
#define HPFont(s)              [UIFont systemFontOfSize:s]

#define HPFORMAT(f, ...)       [NSString stringWithFormat:f, ## __VA_ARGS__]

/*! 屏幕适配（5S标准屏幕：320 * 568） */
#define HPscale_W [UIScreen mainScreen].bounds.size.width/320

CG_INLINE CGFloat HP_SCALE_W(CGFloat width) {
    return width * [UIScreen mainScreen].bounds.size.width/320;
}

CG_INLINE CGFloat HP_SCALE_H(CGFloat height) {
    return height * [UIScreen mainScreen].bounds.size.height/568;
}


#define StringValueFromInt(x) [NSString stringWithFormat:@"%ld",x]


// 设备型号
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

#endif /* Macro_h */
