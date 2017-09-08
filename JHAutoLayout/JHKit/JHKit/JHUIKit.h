//
//  JHUIKit.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategories.h"
#import "JHAlertView.h"


//=============================================================================//
//  define
//=============================================================================//

#define JH_SCALE_W(w) (w)/375.0*[UIScreen mainScreen].bounds.size.width
#define JH_SCALE_H(h) (h)/667.0*[UIScreen mainScreen].bounds.size.height

#define JHWeakSelf(type)    __weak typeof(type) weak##type = type
#define JHStrongSelf(type)  __strong typeof(type) type = weak##type

#define JH_STRONG_P(jhclass,name) @property (strong, nonatomic) jhclass *name;
#define JH_WEAKLY_P(jhclass,name) @property (weak,   nonatomic) jhclass *name;
#define JH_COPYLY_P(jhclass,name) @property (copy,   nonatomic) jhclass *name;
#define JH_ASSIGN_P(jhclass,name) @property (assign, nonatomic) jhclass  name;
#define JH_BLOCKY_P(block,jhclass,name) @property (copy,nonatomic) void (^block)(jhclass name);


#define JH_LAZY_WEAK_UI(UIclass,jhclass,spview,jhdetail) \
- (UIclass *)jhclass{ \
    if (!_##jhclass) { \
        if (!spview) return nil; \
        UIclass *xView = [[UIclass alloc] init]; \
        xView = jhdetail; \
        [spview addSubview:xView]; \
        _##jhclass = xView; \
    } \
    return _##jhclass; \
}

#define JH_LAZY_STRONG_UI(UIclass,jhclass,jhdetail) \
- (UIclass *)jhclass{ \
    if (!_##jhclass) { \
        _##jhclass = jhdetail; \
    } \
    return _##jhclass; \
}

#define JH_LAZY_WEAK_BUTTON(jhclass) \
- (UIButton *)jhclass{ \
    if (!_##jhclass) { \
        UIButton *xButton = [UIButton buttonWithType:1]; \
        [self.view addSubview:xButton]; \
        _button = xButton; \
    } \
    return _button; \
}

#define JH_LAZY_STRONG_BUTTON(jhclass) \
- (UIButton *)button{ \
    if (!_button) { \
        _button = [UIButton buttonWithType:1]; \
    } \
    return _button; \
}

#define JH_CHECK_OBJECT_AND_METHOD(jhobject,jhmethod) \
if ([jhobject isKindOfClass:[NSNull class]]) { \
    if (DEBUG) { \
        NSString *info = [NSString stringWithFormat:@"%s [Line %d] 参数类型是null!",__PRETTY_FUNCTION__,__LINE__]; \
        XX_HUD_SHOW_TEXT_ONLY(info,2,nil) \
    } \
    return; \
} \
if (![jhobject respondsToSelector:@selector(jhmethod)]) { \
    if (DEBUG) { \
        NSString *info = [NSString stringWithFormat:@"%s [Line %d] 参数类型是null!",__PRETTY_FUNCTION__,__LINE__]; \
        XX_HUD_SHOW_TEXT_ONLY(info,2,nil) \
    } \
    return; \
}

//=============================================================================//
//  Somethings
//=============================================================================//
#define force_inline __inline__ __attribute__((always_inline))
force_inline CGFloat jh_screen_width(CGFloat x){
    return [UIScreen mainScreen].bounds.size.width * (x<0?0:x);
}

force_inline CGFloat jh_screen_height(CGFloat x){
    return [UIScreen mainScreen].bounds.size.height * (x<0?0:x);
}

@interface JHCreateUI : NSObject

UIView *xxAddView(CGRect frame,UIColor *bgColor,UIView *superView);
UIView *xxAddView1(CGRect frame,NSString *imageName,UIView *superView);

UILabel *xxAddLabel(CGRect frame,NSString *text,UIColor *color,UIFont *font,NSTextAlignment align,UIView *superView);

UIButton *xxAddButton(CGRect frame,NSString *title,UIColor *color,UIFont *font,UIImage *image,UIImage *bgImage,UIView *superView);
CALayer *xxAddLayer(CGRect frame,UIColor *color,NSString *imageName,UIColor *bdcolor,CGFloat bdWidth,UIView *superView);

@end

@interface ForGame : NSObject
void jhtest(UIView *view);
void jhtest1(UIButton *view);
//遮罩
UIView *jhCoverView(CGRect frame, UIView *spview);
//遮罩 是否 隐藏
void jhShouldShowCover(UIView *coverView,BOOL flag);
//imageView
UIImageView *jhSetupImageView(CGRect frame,NSString *name,UIView *spview);
@end

