//
//  UILabel+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UILabel+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UILabel (JHCategory)

JH_new_m(UILabel)
JH_tag_m(UILabel)
JH_text_m(UILabel)
JH_font_m(UILabel)
JH_align_m(UILabel)
JH_color_m(UILabel)
JH_frame_m(UILabel)
JH_alpha_m(UILabel)
JH_bgColor_m(UILabel)
JH_bdColor_m(UILabel)
JH_bdWidth_m(UILabel)
JH_cnRadius_m(UILabel)
JH_mtBounds_m(UILabel)
JH_addToView_m(UILabel)

- (UILabel *(^)(id))jh_lines{
    JHLog();
    return ^id(id lines){
        if ([lines isKindOfClass:[NSNumber class]]) {
            self.numberOfLines = [lines integerValue];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_adjust{
    JHLog();
    return ^id(id adjust){
        if ([adjust isKindOfClass:[NSNumber class]]) {
            self.adjustsFontSizeToFitWidth = [adjust boolValue];
        }
        return self;
    };
}

- (UILabel *(^)(id))jh_autoWidth{
    JHLog();
    return ^id(id maxWidth){
        if (self.text.length == 0) {
            NSLog(@"%s,text length is 0",__FUNCTION__);
            return self;
        }
        
        CGRect frame = self.frame;
        self.numberOfLines = 1;
        [self sizeToFit];
        
        if ([maxWidth floatValue] > 0 &&
            self.frame.size.width > [maxWidth floatValue])
        {
            frame.size.width = [maxWidth floatValue];
        }else{
            frame.size.width = self.frame.size.width;
        }
        self.frame = frame;
        return self;
    };
}

- (UILabel *(^)(id))jh_autoHeight{
    JHLog();
    return ^id(id maxHeight){
        if (self.text.length == 0) {
            NSLog(@"%s,text length is 0",__FUNCTION__);
            return self;
        }
        
        CGRect frame = self.frame;
        self.numberOfLines = 0;
        [self sizeToFit];
        
        if ([maxHeight floatValue] > 0 &&
            self.frame.size.width > [maxHeight floatValue]) {
            frame.size.height = [maxHeight floatValue];
        }else{
            frame.size.height = self.frame.size.height;
        }
        self.frame = frame;
        return self;
    };
}

- (void)jhLabelFrame:(id)frame text:(NSString *)text color:(id)color font:(id)font align:(CGFloat)align
{
    self.jh_frame(({
        NSString *frameString = @"";
        if ([frame isKindOfClass:[NSString class]]) {
            frameString = frame;
        }else if ([frame isKindOfClass:[NSValue class]]){
            frameString = NSStringFromCGRect([frame CGRectValue]);
        }
        frameString;
    }))
    .jh_text(text)
    .jh_color([UIColor jhColor:color])
    .jh_font([UIFont jhFont:font])
    .jh_align(@(align));
}

- (void)jhAddAttributeWithSubString:(NSString *)string value:(id)value
{
    //颜色
    if ([value isKindOfClass:[UIColor class]]) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr addAttribute:NSForegroundColorAttributeName value:value range:[self.text rangeOfString:string]];
        self.attributedText = attStr;
    }
    //字体
    else if ([value isKindOfClass:[UIFont class]]){
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr addAttribute:NSFontAttributeName value:value range:[self.text rangeOfString:string]];
        self.attributedText = attStr;
    }
}
- (void)jhAddAttributeWithSubString:(NSString *)string value:(id)value range:(NSRange)range
{
    //颜色
    if ([value isKindOfClass:[UIColor class]]) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr addAttribute:NSForegroundColorAttributeName value:value range:range];
        self.attributedText = attStr;
    }
    //字体
    else if ([value isKindOfClass:[UIFont class]]){
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attStr addAttribute:NSFontAttributeName value:value range:range];
        self.attributedText = attStr;
    }
}
@end
