//
//  UITextView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhTextView() jh_new()

@interface UITextView (JHCategory)

JH_new_h(UITextView)
JH_tag_h(UITextView)
JH_text_h(UITextView)
JH_font_h(UITextView)
JH_align_h(UITextView)
JH_color_h(UITextView)
JH_frame_h(UITextView)
JH_alpha_h(UITextView)
JH_bgColor_h(UITextView)
JH_bdColor_h(UITextView)
JH_bdWidth_h(UITextView)
JH_cnRadius_h(UITextView)
JH_mtBounds_h(UITextView)
JH_delegate_h(UITextView)
JH_addToView_h(UITextView)

@end
