//
//  JHAlertView.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XX_HUD_SHOW_TEXT_ONLY(info,time,inView) \
XX_HUD_SHOW(info,time,inView,0)

#define XX_HUD_SHOW_SYSTEM_ONLY(info,time,inView) \
XX_HUD_SHOW(info,time,inView,1)

#define XX_HUD_SHOW_CUSTOM_ONLY(info,time,inView) \
XX_HUD_SHOW(info,time,inView,2)

#define XX_HUD_SHOW(info,time,inView,type012) \
[[JHAlertView alertView] jhShow:info duration:time toView:inView type:type012];

#define XX_HUD_HIDE \
[[JHAlertView alertView] jhHide];

@interface JHAlertView : UIView

+ (instancetype)alertView;

/**
 show a HUD

 @param info text to show
 @param duration time
 @param view super view
 @param type 0:only text, 1:system activityIndicator, 2:custom
 */
- (void)jhShow:(id)info duration:(CGFloat)duration toView:(UIView *)view type:(int)type;
- (void)jhHide;

@end



