//
//  UISwitch+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

@interface UISwitch (JHCategory)

JH_new_h(UISwitch)
JH_tag_h(UISwitch)
JH_frame_h(UISwitch)
JH_alpha_h(UISwitch)
JH_bgColor_h(UISwitch)
JH_bdColor_h(UISwitch)
JH_bdWidth_h(UISwitch)
JH_cnRadius_h(UISwitch)
JH_mtBounds_h(UISwitch)
JH_addToView_h(UISwitch)

- (UISwitch *(^)(id))jh_tintColor;
- (UISwitch *(^)(id))jh_onTintColor;
- (UISwitch *(^)(id))jh_thTintColor;
- (UISwitch *(^)(id))jh_onImage;
- (UISwitch *(^)(id))jh_offImage;

@end
