//
//  JHTabBar.m
//  JHAutoLayout
//
//  Created by HaoCold on 2017/8/3.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHTabBar.h"
#include <objc/message.h>

@interface JHTabBar()
@property (strong,  nonatomic) UIButton     *button;
@end

@implementation JHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jhSetupViews];
    }
    return self;
}

- (void)jhSetupViews
{
    UIButton *button = [UIButton buttonWithType:1]; //用系统样式，self.tabBar.tintColor 会影响图片颜色
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"addition"] forState:0];
    [button addTarget:self action:@selector(jhButtonEvent) forControlEvents:1<<6];
    [self addSubview:button];
    _button = button;
}

- (void)jhButtonEvent
{
    NSLog(@"%s",__func__);
    if (_tabbarDelegate &&
        [_tabbarDelegate respondsToSelector:@selector(tabBarDidClickCenterButton)]) {
        [_tabbarDelegate tabBarDidClickCenterButton];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"3.count.%ld,_buttonCount:%@",self.subviews.count,@(_buttonCount));
    //3.count.7,_buttonCount:5
    //3.count.7,_buttonCount:5
    
    //如果没有文字，只有图片，则通过下面的方法来使用图片居中
#if 0
    for (UITabBarItem *item in self.items) {
        [item setImageInsets:UIEdgeInsetsMake(6,0,-6,0)];
    }
#endif
    
    CGFloat buttonW = self.frame.size.width / _buttonCount;
    //设置Button的位置和尺寸
    CGFloat buttonIndex = 0;
    for (UIView *view in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            // 设置宽度
            CGRect frame = view.frame;
            frame.size.width = buttonW;
            frame.origin.x = buttonIndex * buttonW;
            view.frame = frame;
            // 增加索引
            buttonIndex++;
            if (buttonIndex == (_buttonCount - 1)/2) {
                //设置中间按钮的位置
                _button.frame = CGRectMake(buttonIndex * buttonW,
                                           frame.origin.y,
                                           buttonW,
                                           view.frame.size.height);
                
                
                buttonIndex++;
            }
        }
    }
}

@end
