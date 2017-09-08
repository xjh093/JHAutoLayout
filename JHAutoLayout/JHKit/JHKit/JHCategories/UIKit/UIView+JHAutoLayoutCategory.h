//
//  UIView+JHAutoLayoutCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+JHCaculationOfStringFormula.h"

@interface UIView (JHAutoLayoutCategory)

- (CGRect)jhRectFromString:(NSString *)frameStr;  /**< frameStr:[x:value,y:value,w:value,h:value] */
- (CGSize)jhSizeFromString:(NSString *)sizeStr;
- (void)jhAddKeyboardHiddenEvent; /**< 添加单击收回键盘事件*/
- (void)jhAutoLayout; /**< 自动布局*/
- (void)jhUpdateLayout; /**< 更新布局*/
- (void)jhEndLayout; /**< 结束布局*/

@end
