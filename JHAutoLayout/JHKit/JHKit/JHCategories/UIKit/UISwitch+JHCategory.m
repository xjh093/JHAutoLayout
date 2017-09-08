//
//  UISwitch+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UISwitch+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UISwitch (JHCategory)

JH_new_m(UISwitch)
JH_tag_m(UISwitch)
JH_bind_m(UISwitch)
JH_frame_m(UISwitch)
JH_alpha_m(UISwitch)
JH_bgColor_m(UISwitch)
JH_bdColor_m(UISwitch)
JH_bdWidth_m(UISwitch)
JH_cnRadius_m(UISwitch)
JH_mtBounds_m(UISwitch)
JH_addToView_m(UISwitch)

- (UISwitch *(^)(id))jh_tintColor{
    JHLog();
    return ^id(id tintColor){
        if ([tintColor isKindOfClass:[UIColor class]]) {
            self.tintColor = tintColor;
        }else if ([tintColor isKindOfClass:[NSString class]]){
            self.tintColor = [UIColor jhColor:tintColor];
        }
        return self;
    };
}

- (UISwitch *(^)(id))jh_onTintColor{
    JHLog();
    return ^id(id onTintColor){
        if ([onTintColor isKindOfClass:[UIColor class]]) {
            self.onTintColor = onTintColor;
        }else if ([onTintColor isKindOfClass:[NSString class]]){
            self.onTintColor = [UIColor jhColor:onTintColor];
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_thTintColor{
    JHLog();
    return ^id(id thTintColor){
        if ([thTintColor isKindOfClass:[UIColor class]]) {
            self.thumbTintColor = thTintColor;
        }else if ([thTintColor isKindOfClass:[NSString class]]){
            self.thumbTintColor = [UIColor jhColor:thTintColor];
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_onImage{
    JHLog();
    return ^id(id onImage){
        if ([onImage isKindOfClass:[NSString class]]) {
            self.onImage = [UIImage imageNamed:onImage];
        }else if ([onImage isKindOfClass:[UIImage class]]){
            self.onImage = onImage;
        }
        return self;
    };
}
- (UISwitch *(^)(id))jh_offImage{
    JHLog();
    return ^id(id offImage){
        if ([offImage isKindOfClass:[NSString class]]) {
            self.offImage = [UIImage imageNamed:offImage];
        }else if ([offImage isKindOfClass:[UIImage class]]){
            self.offImage = offImage;
        }
        return self;
    };
}

@end
