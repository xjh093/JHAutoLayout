//
//  JHUIKit.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "JHUIKit.h"

@implementation JHCreateUI : NSObject

UIView *xxAddView(CGRect frame,UIColor *bgColor,UIView *superView)
{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = bgColor;
    
    if (superView) {
        [superView addSubview:view];
    }
    return view;
}

UIView *xxAddView1(CGRect frame,NSString *imageName,UIView *superView)
{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        view.layer.contents = (id)[image CGImage];
    }
    
    if (superView) {
        [superView addSubview:view];
    }
    return view;
}

UILabel *xxAddLabel(CGRect frame,NSString *text,UIColor *color,UIFont *font,NSTextAlignment align,UIView *superView)
{
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = frame;
    lable.text = text;
    lable.font = font;
    lable.textAlignment = align;
    lable.textColor = color;
    
    if (superView) {
        [superView addSubview:lable];
    }
    return lable;
}

UIButton *xxAddButton(CGRect frame,NSString *title,UIColor *color,UIFont *font,UIImage *image,UIImage *bgImage,UIView *superView)
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    [button setImage:image forState:0];
    [button setTitle:title forState:0];
    [button setTitleColor:color forState:0];
    [button setBackgroundImage:bgImage forState:0];
    button.titleLabel.font = font;
    
    if (superView) {
        [superView addSubview:button];
    }
    return button;
}

CALayer *xxAddLayer(CGRect frame,UIColor *color,NSString *imageName,UIColor *bdcolor,CGFloat bdWidth,UIView *superView)
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    layer.borderColor = bdcolor.CGColor;
    layer.borderWidth = bdWidth;
    
    if (imageName.length > 0) {
        layer.contents = (id)[UIImage imageNamed:imageName].CGImage;
    }
    
    if (superView) {
        [superView.layer addSublayer:layer];
    }
    return layer;
}

@end

@implementation ForGame

void jhtest(UIView *view)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            view.hidden = YES;
            jhtest(view);
        });
    });
}

void jhtest1(UIButton *view)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.highlighted = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            view.highlighted = NO;
            jhtest1(view);
        });
    });
}

//遮罩
UIView *jhCoverView(CGRect frame, UIView *spview)
{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    view.hidden = YES;
    [spview addSubview:view];
    return view;
}

//遮罩 是否 隐藏
void jhShouldShowCover(UIView *coverView,BOOL flag)
{
    coverView.hidden = !flag;
}

//imageView
UIImageView *jhSetupImageView(CGRect frame,NSString *name,UIView *spview)
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:name];
    [spview addSubview:imageView];
    return imageView;
}

//button
UIButton *jhSetupButton1(CGRect frame,NSString *imageName,UIView *spView)
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:0];
    [spView addSubview:button];
    return button;
}

@end
