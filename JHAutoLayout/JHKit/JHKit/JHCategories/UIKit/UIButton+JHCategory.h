//
//  UIButton+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhButton(type) jh_button(type)

@interface UIButton (JHCategory)

JH_tag_h(UIButton)
JH_frame_h(UIButton)
JH_alpha_h(UIButton)
JH_bgColor_h(UIButton)
JH_bdColor_h(UIButton)
JH_bdWidth_h(UIButton)
JH_cnRadius_h(UIButton)
JH_mtBounds_h(UIButton)
JH_addToView_h(UIButton)

+ (UIButton *(^)(id))jh_button;
- (UIButton *(^)(id))jh_title;
- (UIButton *(^)(id))jh_color;
- (UIButton *(^)(id))jh_font;
- (UIButton *(^)(id))jh_image;
- (UIButton *(^)(id,id,id))jh_target_selector_event;
- (UIButton *(^)(id))jh_bgImage;
- (UIButton *(^)(id))jh_hTitle;
- (UIButton *(^)(id))jh_hColor;
- (UIButton *(^)(id))jh_hImage;
- (UIButton *(^)(id))jh_sTitle;
- (UIButton *(^)(id))jh_sColor;
- (UIButton *(^)(id))jh_sImage;
- (UIButton *(^)(id))jh_tintColor;
- (UIButton *(^)(id))jh_imageUpTitleDown;
- (UIButton *(^)(id))jh_imageDownTitleUp;
- (UIButton *(^)(id))jh_imageRightTitleLeft;
- (UIButton *(^)(id))jh_imageLeftTitleRight;
- (UIButton *(^)())jh_imageCenterTitleCenter; /**< image and title all center*/
- (UIButton *(^)())jh_addUnderLine;
@end
