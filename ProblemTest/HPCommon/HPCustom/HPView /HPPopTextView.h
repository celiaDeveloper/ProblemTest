//
//  QZTopTextView.h
//  circle_iphone
//
//  Created by MrYu on 16/8/17.
//  Copyright © 2016年 ctquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HPPopTextViewDelegate <NSObject>

- (void)sendComment:(NSString *)content;

@end

@interface HPPopTextView : UIView

@property (nonatomic,strong) UITextField *textWriteView;

@property(nonatomic,strong)UIView * backgroundView;

@property(nonatomic,strong)UIButton *issueBtn;

@property (nonatomic,weak) id<HPPopTextViewDelegate> delegate;

@end
