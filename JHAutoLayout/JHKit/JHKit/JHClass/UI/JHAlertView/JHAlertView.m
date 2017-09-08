//
//  JHAlertView.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "JHAlertView.h"
#import "UIActivityIndicatorView+JHCategory.h"

@interface JHAlertView()
@property (strong,  nonatomic)UIActivityIndicatorView   *aiView;
@property (assign,  nonatomic)BOOL                       showing;
@end
@implementation JHAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
#if 0
    UIView *view = [[UIView alloc] init];
    view.frame = [UIScreen mainScreen].bounds;
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [self addSubview:view];
#endif
}

+ (instancetype)alertView
{
    static JHAlertView *alertView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return alertView;
}

- (void)jhShow:(id)info duration:(CGFloat)duration toView:(UIView *)view type:(int)type
{
    if (_showing) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self jhHide];
    }
    
    _showing = YES;
    NSString *msg = @"";
    
    //NSError
    if ([info isKindOfClass:[NSError class]]) {
        NSError *error = (NSError *)info;
        NSDictionary *dic = error.userInfo;
        if (dic.count > 0) {
            msg = [NSString stringWithFormat:@"%@ -> %@",dic.allKeys[0],dic.allValues[0]];
        }
    }
    
    //NSString
    if ([info isKindOfClass:[NSString class]]) {
        msg = info;
    }
    
    UIActivityIndicatorView *aiView = [UIActivityIndicatorView jhAIViewInsuperView:self showInfo:msg type:type];
    [aiView startAnimating];
    _aiView = aiView;
    
    CGFloat time = duration <= 0 ? 2 : duration;

    if (view) { //add to view
        [view addSubview:self];
    }else{ //add to window
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows]reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            if (window.windowLevel == UIWindowLevelNormal)
            {
                [window addSubview:self];
                [window bringSubviewToFront:self];
                break;
            }
        }
    }
    
    //hide after time
    [self performSelector:@selector(jhHide) withObject:nil afterDelay:time];
}

- (void)jhHide
{
    _showing = NO;
    [_aiView stopAnimating];
    [self removeFromSuperview];
}

@end
