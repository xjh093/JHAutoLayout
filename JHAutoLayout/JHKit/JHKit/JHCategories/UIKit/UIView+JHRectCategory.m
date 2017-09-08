//
//  UIView+JHRectCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIView+JHRectCategory.h"

@implementation UIView (JHRectCategory)

- (void)setJh_x:(CGFloat)jh_x{
    CGRect frame = self.frame;
    frame.origin.x = jh_x;
    self.frame = frame;
}

- (CGFloat)jh_x{
    return self.frame.origin.x;
}

- (void)setJh_y:(CGFloat)jh_y{
    CGRect frame = self.frame;
    frame.origin.y = jh_y;
    self.frame = frame;
}

- (CGFloat)jh_y{
    return self.frame.origin.y;
}

- (void)setJh_w:(CGFloat)jh_w{
    CGRect frame = self.frame;
    frame.size.width = jh_w;
    self.frame = frame;
}

- (CGFloat)jh_w{
    return self.frame.size.width;
}

- (void)setJh_h:(CGFloat)jh_h{
    CGRect frame = self.frame;
    frame.size.height = jh_h;
    self.frame = frame;
}

- (CGFloat)jh_h{
    return self.frame.size.height;
}

- (void)setJh_center_x:(CGFloat)jh_center_x{
    CGPoint point = self.center;
    point.x = jh_center_x;
    self.center = point;
}

- (CGFloat)jh_center_x{
    return self.center.x;
}

- (void)setJh_center_y:(CGFloat)jh_center_y{
    CGPoint point = self.center;
    point.y = jh_center_y;
    self.center = point;
}

- (CGFloat)jh_center_y{
    return self.center.y;
}

- (void)setJh_origin:(CGPoint)jh_origin{
    CGRect frame = self.frame;
    frame.origin.x = jh_origin.x;
    frame.origin.y = jh_origin.y;
    self.frame = frame;
}

- (CGPoint)jh_origin{
    return self.frame.origin;
}

- (void)setJh_size:(CGSize)jh_size{
    CGRect frame = self.frame;
    frame.size.width  = jh_size.width;
    frame.size.height = jh_size.height;
    self.frame = frame;
}

- (CGSize)jh_size{
    return self.frame.size;
}

- (CGFloat)jh_mid_x{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)jh_mid_y{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)jh_max_x{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)jh_max_y{
    return CGRectGetMaxY(self.frame);
}

@end
