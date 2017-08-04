//
//  JHTabBar.h
//  JHAutoLayout
//
//  Created by HaoCold on 2017/8/3.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHTabBarDelegate <NSObject>
- (void)tabBarDidClickCenterButton;
@end

@interface JHTabBar : UITabBar
@property (assign,  nonatomic) NSInteger                buttonCount; //按钮数量
@property (weak,    nonatomic) id <JHTabBarDelegate>    tabbarDelegate;
@end
