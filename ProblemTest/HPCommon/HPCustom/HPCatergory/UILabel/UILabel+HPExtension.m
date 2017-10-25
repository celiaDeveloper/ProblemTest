//
//  UILabel+extension.m
//  SLYP
//
//  Created by 秦正华 on 2016/11/18.
//  Copyright © 2016年 马晓明. All rights reserved.
//

#import "UILabel+HPExtension.h"

@implementation UILabel (HPExtension)

+ (instancetype)initLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (void)setLabelTextFont:(CGFloat)font textColor:(UIColor *)textColor title:(NSString *)text {
    
    self.text = text;
    self.font = [UIFont systemFontOfSize:font];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.textColor = textColor;
}

+ (instancetype)initAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = otherColor;
    label.font = [UIFont systemFontOfSize:otherFont];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftText,middleText,rightText];
    long leftLength = [leftText length];
    long middleLength = [middleText length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(leftLength,middleLength)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(leftLength,middleLength)];
    label.attributedText = attributeStr;
    return label;
}

- (void)setAttributeLabelAttributeFont:(CGFloat)font attributeColor:(UIColor *)textColor otherFont:(CGFloat)otherFont otherColor:(UIColor *)otherColor leftText:(NSString *)leftText middleText:(NSString *)middleText rightText:(NSString *)rightText {
    
    self.textColor = otherColor;
    self.font = [UIFont systemFontOfSize:otherFont];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",leftText,middleText,rightText];
    long leftLength = [leftText length];
    long middleLength = [middleText length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(leftLength,middleLength)];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(leftLength,middleLength)];
    self.attributedText = attributeStr;
}

+ (instancetype)initStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text {
    
    UILabel *label = [[UILabel alloc]init];
    NSString *tmp = text == nil ? @"" : text;
    long length = [tmp length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font],
                           NSStrikethroughColorAttributeName : [UIColor blackColor],
                           NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                           NSForegroundColorAttributeName:color,
                           NSBaselineOffsetAttributeName:@(0)};
    [attributeStr addAttributes:dict range:NSMakeRange(0, length)];
    label.attributedText = attributeStr;
    return label;
}

- (void)setStrikethroughLabelTextFont:(CGFloat)font textColor:(UIColor *)color text:(NSString *)text {
    
    NSString *tmp = text == nil ? @"" : text;
    
    long length = [tmp length];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:tmp];
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font],
                           NSStrikethroughColorAttributeName : [UIColor blackColor],
                           NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                           NSForegroundColorAttributeName:color,
                           NSBaselineOffsetAttributeName:@(0)};
    
    [attributeStr addAttributes:dict range:NSMakeRange(0, length)];
    
    self.attributedText = attributeStr;
}


- (CGSize)getLableCGSizeWithString:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}

- (void)addUnderlineColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
        if (color) {
            [attributedString addAttribute:NSUnderlineColorAttributeName value:color range:itemRange];
        }
    }
    
    self.attributedText = attributedString;
}

- (void)addDeletelineColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text) {
        NSRange itemRange = [self.text rangeOfString:text];
        color = color ? : [UIColor blackColor];
        NSDictionary *AttributeDict = @{NSStrikethroughColorAttributeName : color,
                               NSStrikethroughStyleAttributeName :@(NSUnderlineStyleSingle),
                               NSBaselineOffsetAttributeName:@(0)};
        [attributedString addAttributes:AttributeDict range:itemRange];
    }
    
    self.attributedText = attributedString;
}

- (void)changeTextColor:(UIColor *)color toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text && color) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:itemRange];
    }
    self.attributedText = attributedString;
}

- (void)changeTextFontSize:(CGFloat)fontSize toText:(NSString *)text {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    
    if (text && fontSize) {
        NSRange itemRange = [self.text rangeOfString:text];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:itemRange];
    }
    
    self.attributedText = attributedString;
}

- (void)changeLineSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

- (void)changeWordSpace:(float)space {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}




@end
