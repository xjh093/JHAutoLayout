//
//  UIScrollView+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIScrollView+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UIScrollView (JHCategory)

JH_new_m(UIScrollView)
JH_tag_m(UIScrollView)
JH_bind_m(UIScrollView)
JH_frame_m(UIScrollView)
JH_alpha_m(UIScrollView)
JH_bgColor_m(UIScrollView)
JH_bdColor_m(UIScrollView)
JH_bdWidth_m(UIScrollView)
JH_cnRadius_m(UIScrollView)
JH_mtBounds_m(UIScrollView)
JH_delegate_m(UIScrollView)
JH_addToView_m(UIScrollView)

- (UIScrollView *(^)(id))jh_contentSize{
    JHLog();
    return ^id(id contentSize){
        if ([contentSize isKindOfClass:[NSValue class]]) {
            self.contentSize = [contentSize CGSizeValue];
        }else if ([contentSize isKindOfClass:[NSString class]]){
            if ([contentSize hasPrefix:@"{"]) {
                self.contentSize = CGSizeFromString(contentSize);
            }else if ([contentSize hasPrefix:@"["]){
                self.contentSize = [self jhSizeFromString:contentSize];
            }else{
                self.frame = CGRectZero;
            }
        }
        return self;
    };
}
@end
