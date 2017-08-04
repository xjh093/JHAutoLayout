//
//  UIImageView+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIImageView+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UIImageView (JHCategory)

JH_new_m(UIImageView)
JH_tag_m(UIImageView)
JH_frame_m(UIImageView)
JH_alpha_m(UIImageView)
JH_bgColor_m(UIImageView)
JH_bdColor_m(UIImageView)
JH_bdWidth_m(UIImageView)
JH_cnRadius_m(UIImageView)
JH_mtBounds_m(UIImageView)
JH_addToView_m(UIImageView)

- (UIImageView *(^)(id))jh_image{
    JHLog();
    return ^id(id image){
        if ([image isKindOfClass:[NSString class]]) {
            self.image = [UIImage imageNamed:image];
        }else if ([image isKindOfClass:[UIImage class]]){
            self.image = image;
        }
        return self;
    };
}

- (UIImageView *(^)(id,id))jh_image_tintColor{
    JHLog();
    return ^id(id image,id color){
        self.tintColor = [UIColor jhColor:color];
        if ([image isKindOfClass:[NSString class]]) {
            self.image = [[UIImage imageNamed:image]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }else if ([image isKindOfClass:[UIImage class]]){
            self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        return self;
    };
}

@end
