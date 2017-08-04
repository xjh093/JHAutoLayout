//
//  UIActivityIndicatorView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActivityIndicatorView (JHCategory)

/**
 show some message

 @param view super view
 @param text message
 @param type 0~2 0:only message, 1:system IndicatorView, 2:custom view
 @return UIActivityIndicatorView
 */
+ (UIActivityIndicatorView *)jhAIViewInsuperView:(UIView *)view
                                        showInfo:(NSString *)text
                                            type:(int)type;
@end
