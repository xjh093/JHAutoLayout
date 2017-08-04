//
//  UIButton+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIButton+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UIButton (JHCategory)

JH_tag_m(UIButton)
JH_frame_m(UIButton)
JH_alpha_m(UIButton)
JH_bgColor_m(UIButton)
JH_bdColor_m(UIButton)
JH_bdWidth_m(UIButton)
JH_cnRadius_m(UIButton)
JH_mtBounds_m(UIButton)
JH_addToView_m(UIButton)

+ (UIButton *(^)(id))jh_button{
    return ^id(id type){
        if ([type isKindOfClass:[NSNumber class]]) {
            UIButton *button = [UIButton buttonWithType:[type integerValue]];
            return button;
        }
        return nil;
    };
}

- (UIButton *(^)(id))jh_title{
    JHLog();
    return ^id(id title){
        if ([title isKindOfClass:[NSString class]]) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_color{
    JHLog();
    return ^id(id color){
        if ([color isKindOfClass:[UIColor class]]) {
            [self setTitleColor:color forState:UIControlStateNormal];
        }else if ([color isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:color] forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_font{
    JHLog();
    return ^id(id font){
        if ([font isKindOfClass:[UIFont class]]) {
            self.titleLabel.font = font;
        }else if ([font isKindOfClass:[NSString class]]){
            self.titleLabel.font = [UIFont jhFont:font];
        }else if ([font isKindOfClass:[NSNumber class]]){
            self.titleLabel.font = [UIFont jhFont:[NSString stringWithFormat:@"%@",font]];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_image{
    JHLog();
    return ^id(id image){
        if ([image isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }else if ([image isKindOfClass:[UIImage class]]){
            [self setImage:image forState:UIControlStateNormal];
        }
        return self;
    };
}

- (UIButton *(^)(id,id,id))jh_target_selector_event{
    JHLog();
    return ^id(id target,id selector,id event){
        if (([target isKindOfClass:[UIViewController class]] ||
             [target isKindOfClass:[UIView class]]) &&
            [selector isKindOfClass:[NSString class]] &&
            [event isKindOfClass:[NSNumber class]]) {
            [self addTarget:target action:NSSelectorFromString(selector) forControlEvents:[event unsignedIntegerValue]];
        }
        return self;
    };
}

- (UIButton *(^)(id))jh_bgImage{
    JHLog();
    return ^id(id bgImage){
        if ([bgImage isKindOfClass:[NSString class]]) {
            [self setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
        }else if ([bgImage isKindOfClass:[UIImage class]]){
            [self setBackgroundImage:bgImage forState:UIControlStateNormal];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hTitle{
    JHLog();
    return ^id(id hTitle){
        if ([hTitle isKindOfClass:[NSString class]]) {
            [self setTitle:hTitle forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hColor{
    JHLog();
    return ^id(id hColor){
        if ([hColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:hColor forState:UIControlStateHighlighted];
        }else if ([hColor isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:hColor] forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_hImage{
    JHLog();
    return ^id(id hImage){
        if ([hImage isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
        }else if ([hImage isKindOfClass:[UIImage class]]){
            [self setImage:hImage forState:UIControlStateHighlighted];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sTitle{
    JHLog();
    return ^id(id sTitle){
        if ([sTitle isKindOfClass:[NSString class]]) {
            [self setTitle:sTitle forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sColor{
    JHLog();
    return ^id(id sColor){
        if ([sColor isKindOfClass:[UIColor class]]) {
            [self setTitleColor:sColor forState:UIControlStateSelected];
        }else if ([sColor isKindOfClass:[NSString class]]){
            [self setTitleColor:[UIColor jhColor:sColor] forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_sImage{
    JHLog();
    return ^id(id sImage){
        if ([sImage isKindOfClass:[NSString class]]) {
            [self setImage:[UIImage imageNamed:sImage] forState:UIControlStateSelected];
        }else if ([sImage isKindOfClass:[UIImage class]]){
            [self setImage:sImage forState:UIControlStateSelected];
        }
        return self;
    };
}
- (UIButton *(^)(id))jh_tintColor{
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
- (UIButton *(^)(id))jh_imageUpTitleDown
{
    JHLog();
    return ^id(id offsetY){
        CGFloat Y = [offsetY floatValue];
        Y = [offsetY floatValue]>=0?[offsetY floatValue]:3;
        [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-Y,0,0,-self.titleLabel.intrinsicContentSize.width)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-self.imageView.jh_w,-self.imageView.jh_h-Y,0)];
        return self;
    };
}
- (UIButton *(^)(id))jh_imageDownTitleUp
{
    JHLog();
    return ^id(id offsetY){
        CGFloat Y = 3;
        Y = [offsetY floatValue]>=0?[offsetY floatValue]:3;
        [self setImageEdgeInsets:UIEdgeInsetsMake(self.titleLabel.intrinsicContentSize.height+Y,0,0,-self.titleLabel.intrinsicContentSize.width)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-self.imageView.jh_w-Y,-self.imageView.jh_w,0,0)];
        return self;
    };
}
- (UIButton *(^)(id))jh_imageRightTitleLeft
{
    JHLog();
    return ^id(id offsetX){
        CGFloat X = 3;
        X = [offsetX floatValue]>=0?[offsetX floatValue]:3;
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-self.titleLabel.intrinsicContentSize.width-self.imageView.frame.size.width-X)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-self.titleLabel.intrinsicContentSize.width-self.imageView.frame.size.width-X,0,0)];
        return self;
    };
}
- (UIButton *(^)(id))jh_imageLeftTitleRight
{
    JHLog();
    return ^id(id offsetX){
        CGFloat X = 3;
        X = [offsetX floatValue]>=0?[offsetX floatValue]:3;
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,X)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,X,0,0)];
        return self;
    };
}
- (UIButton *(^)())jh_imageCenterTitleCenter
{
    JHLog();
    return ^id(){
        [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-self.titleLabel.intrinsicContentSize.width)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-self.imageView.frame.size.width,0,0)];
        return self;
    };
}
- (UIButton *(^)())jh_addUnderLine
{
    JHLog();
    return ^id(){
        if ([self.currentTitle length] == 0) {
            return self;
        }
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.currentTitle];
        [attr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [self.currentTitle length])];
        [self setAttributedTitle:attr forState:0];
        return self;
    };
}
@end
