//
//  UILabel+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhLabel() jh_new()

@interface UILabel (JHCategory)

JH_new_h(UILabel)
JH_tag_h(UILabel)
JH_bind_h(UILabel)
JH_text_h(UILabel)
JH_font_h(UILabel)
JH_align_h(UILabel)
JH_color_h(UILabel)
JH_frame_h(UILabel)
JH_alpha_h(UILabel)
JH_bgColor_h(UILabel)
JH_bdColor_h(UILabel)
JH_bdWidth_h(UILabel)
JH_cnRadius_h(UILabel)
JH_mtBounds_h(UILabel)
JH_addToView_h(UILabel)

- (UILabel *(^)(id))jh_lines; /**< NSNumber */
- (UILabel *(^)(id))jh_adjust; /**< NSNumber @(YES),@(NO)*/
- (UILabel *(^)(id))jh_autoWidth; /**< NSNumber 自动宽度时设置最大宽度,0表示没有最大宽度*/
- (UILabel *(^)(id))jh_autoHeight; /**< NSNumber 自动高度时设置最大高度,0表示没有最大高度*/
- (void)jhLabelFrame:(id)frame text:(NSString *)text color:(id)color font:(id)font align:(CGFloat)align;
- (void)jhAddAttributeWithSubString:(NSString *)string value:(id)value; /**< 添加富文本属性*/
- (void)jhAddAttributeWithSubString:(NSString *)string value:(id)value range:(NSRange)range; /**< 添加富文本属性*/
- (void)jhAddLineSpace:(CGFloat)space; /**< 设置行间距*/
@end
