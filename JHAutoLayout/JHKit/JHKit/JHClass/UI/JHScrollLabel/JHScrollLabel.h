//
//  XJHScrollLabel.h
//
//  Created by Lightech on 15-1-10.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHScrollLabel : UIScrollView

@property (copy,    nonatomic) void (^clickBlock)();

@property (copy,    nonatomic) NSString     *text;
@property (strong,  nonatomic) UIColor      *textColor;
@property (strong,  nonatomic) UIFont       *font;

/**
 *@brief title,font,frame参数必须有,textColor,bgcolor可以为空
 *
 */
+(JHScrollLabel *)labelWithTitle:(NSString *)title
                        withFont:(UIFont *)font
                   withTextColor:(UIColor *)textColor
                       withFrame:(CGRect)frame
             withBackgroundColor:(UIColor *)bgcolor;
@end
