//
//  UIImageView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhImageView() jh_new()

@interface UIImageView (JHCategory)

JH_new_h(UIImageView)
JH_tag_h(UIImageView)
JH_frame_h(UIImageView)
JH_alpha_h(UIImageView)
JH_bgColor_h(UIImageView)
JH_bdColor_h(UIImageView)
JH_bdWidth_h(UIImageView)
JH_cnRadius_h(UIImageView)
JH_mtBounds_h(UIImageView)
JH_addToView_h(UIImageView)

- (UIImageView *(^)(id))jh_image;   /**< NSString or UIImage */
- (UIImageView *(^)(id,id))jh_image_tintColor;  /**< NSString or UIImage. UIColor.*/
@end
