//
//  UIView+JHRectCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JHRectCategory)

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

@end
