//
//  UIView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"
#import "NSString+JHCaculationOfStringFormula.h"

#define jhView() jh_new()

@interface UIView (JHCategory)

@property (assign, nonatomic) CGFloat jh_x;                 /**< 原点x*/
@property (assign, nonatomic) CGFloat jh_y;                 /**< 原点y*/
@property (assign, nonatomic) CGFloat jh_w;                 /**< 宽度w*/
@property (assign, nonatomic) CGFloat jh_h;                 /**< 高度h*/

@property (assign, nonatomic) CGFloat jh_center_x;          /**< 中心点x*/
@property (assign, nonatomic) CGFloat jh_center_y;          /**< 中心点y*/

@property (assign, nonatomic) CGPoint jh_origin;            /**< 原点*/
@property (assign, nonatomic) CGSize  jh_size;              /**< 大小*/

@property (assign, nonatomic, readonly) CGFloat jh_mid_x;   /**< 原点x + 宽度w/2*/
@property (assign, nonatomic, readonly) CGFloat jh_mid_y;   /**< 原点y + 宽度h/2*/
@property (assign, nonatomic, readonly) CGFloat jh_max_x;   /**< 原点x + 宽度w*/
@property (assign, nonatomic, readonly) CGFloat jh_max_y;   /**< 原点y + 宽度h*/

JH_new_h(UIView)
JH_tag_h(UIView)
JH_frame_h(UIView)
JH_alpha_h(UIView)
JH_bgColor_h(UIView)
JH_bdColor_h(UIView)
JH_bdWidth_h(UIView)
JH_cnRadius_h(UIView)
JH_mtBounds_h(UIView)
JH_addToView_h(UIView)

- (CGRect)jhRectFromString:(NSString *)frameStr;  /**< frameStr:[x:value,y:value,w:value,h:value] */
- (CGSize)jhSizeFromString:(NSString *)sizeStr;
- (void)jhAddKeyboardHiddenEvent; /**< 添加单击收回键盘事件*/
- (void)jhAutoLayout; /**< 自动布局*/
- (void)jhUpdateLayout; /**< 更新布局*/
- (void)jhEndLayout; /**< 结束布局*/

//画直线 - draw line in view.
- (void)jhDrawLineFromPoint:(CGPoint)fPoint
                    toPoint:(CGPoint)tPoint
                  lineColor:(UIColor *)color
                  lineWidth:(CGFloat)width;

//画虚线 - draw dash line in view.
//type: 0 - cube, 1 - round
- (void)jhDrawDashLineFromPoint:(CGPoint)fPoint
                        toPoint:(CGPoint)tPoint
                      lineColor:(UIColor *)color
                      lineWidth:(CGFloat)width
                      lineSpace:(CGFloat)space
                       lineType:(NSInteger)type;

//画五角星 - draw pentagram in view.
//rate: 0.3 ~ 1.1
- (void)jhDrawPentagram:(CGPoint)center
                 radius:(CGFloat)radius
                  color:(UIColor *)color
                   rate:(CGFloat)rate;
@end
