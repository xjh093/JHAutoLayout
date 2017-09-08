//
//  UIScrollView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhScrollView() jh_new()

@interface UIScrollView (JHCategory)

JH_new_h(UIScrollView)
JH_tag_h(UIScrollView)
JH_bind_h(UIScrollView)
JH_frame_h(UIScrollView)
JH_alpha_h(UIScrollView)
JH_bgColor_h(UIScrollView)
JH_bdColor_h(UIScrollView)
JH_bdWidth_h(UIScrollView)
JH_cnRadius_h(UIScrollView)
JH_mtBounds_h(UIScrollView)
JH_delegate_h(UIScrollView)
JH_addToView_h(UIScrollView)

- (UIScrollView *(^)(id))jh_contentSize;

@end
