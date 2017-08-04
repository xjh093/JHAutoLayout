//
//  UITextField+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhTextField() jh_new()

@interface UITextField (JHCategory)

JH_new_h(UITextField)
JH_tag_h(UITextField)
JH_text_h(UITextField)
JH_font_h(UITextField)
JH_align_h(UITextField)
JH_color_h(UITextField)
JH_frame_h(UITextField)
JH_alpha_h(UITextField)
JH_bgColor_h(UITextField)
JH_bdColor_h(UITextField)
JH_bdWidth_h(UITextField)
JH_cnRadius_h(UITextField)
JH_mtBounds_h(UITextField)
JH_delegate_h(UITextField)
JH_addToView_h(UITextField)

- (UITextField *(^)(id))jh_bdStyle;
- (UITextField *(^)(id))jh_pHolder;
- (UITextField *(^)(id))jh_pHColor;
- (UITextField *(^)(id))jh_pHFont;
- (UITextField *(^)(id))jh_cbMode;
- (UITextField *(^)(id))jh_lvMode;
- (UITextField *(^)(id))jh_rvMode;
- (UITextField *(^)(id))jh_lfView;
- (UITextField *(^)(id))jh_rtView;

@end
