//
//  UIView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"
#import "UIView+JHRectCategory.h"
#import "UIView+JHDrawCategory.h"
#import "UIView+JHAutoLayoutCategory.h"

#define jhView() jh_new()

@interface UIView (JHCategory)

JH_new_h(UIView)
JH_tag_h(UIView)
JH_bind_h(UIView)
JH_frame_h(UIView)
JH_alpha_h(UIView)
JH_bgColor_h(UIView)
JH_bdColor_h(UIView)
JH_bdWidth_h(UIView)
JH_cnRadius_h(UIView)
JH_mtBounds_h(UIView)
JH_addToView_h(UIView)

@end
