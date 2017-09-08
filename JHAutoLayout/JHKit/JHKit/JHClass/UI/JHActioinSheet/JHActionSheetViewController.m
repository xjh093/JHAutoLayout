//
//  JHActionSheetViewController.m
//  OldFriendsTravels
//
//  Created by HaoCold on 16/8/11.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import "JHActionSheetViewController.h"

@interface JHActionSheetViewController ()

@property (strong,  nonatomic) NSArray            *menus;      /**< 菜单, array */
@property (weak,    nonatomic) UIView             *menuView;
@property (assign,  nonatomic) CGFloat             vY;
@property (assign,  nonatomic) NSInteger           buttonIndex;
@property (copy,    nonatomic) NSString           *selectedTitle;
@end

@implementation JHActionSheetViewController

- (instancetype)init
{
    if (self = [super init]) {
        
#if 0
        UIViewController *vc = [self jhGetViewControllerOnScreen];
        
        // 1.开启上下文
        UIGraphicsBeginImageContextWithOptions(vc.view.frame.size, NO, 0.0);
        
        // 2.将控制器view的layer渲染到上下文
        [vc.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        // 3.取出图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 4.结束上下文
        UIGraphicsEndImageContext();
        
        // 5.设置view的背景
        self.view.layer.contents = (id)newImage.CGImage;
#endif
    }
    return self;
}

- (UIViewController *)jhGetViewControllerOnScreen
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *twindow in windows) {
            if (twindow.windowLevel == UIWindowLevelNormal) {
                window = twindow;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }
    
    return window.rootViewController;
}

- (instancetype)initWithMenus:(NSArray *)menus
{
    if (self = [super init]) {
        _menus = menus;
        [self jhSetupViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)jhSetupViews
{
    //灰色View
    UIView *grayView = [[UIView alloc] init];
    grayView.frame = self.view.bounds;
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.2;
    [self.view addSubview:grayView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jhTapEvent)];
    [grayView addGestureRecognizer:tap];
    
    //菜单
    [self jhSetupMenuView];

}

- (void)jhTapEvent
{
    _buttonIndex = 0;
    _selectedTitle = @"";
    [self jhHide];
}

- (void)jhHide
{
    CGRect frame = _menuView.frame;
    frame.origin.y = CGRectGetHeight([UIScreen mainScreen].bounds);
    [UIView animateWithDuration:0.25 animations:^{
        _menuView.frame = frame;
    } completion:^(BOOL finished) {
        if (_clickBlock) {
            _clickBlock(_buttonIndex,_selectedTitle);
        }
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)jhSetupMenuView
{
    if (_menus.count == 0) {
        return;
    }
    
    NSInteger count = _menus.count;
    CGFloat   H1 = 40; //单个菜单高度
    CGFloat   H2 = 50; //取消按钮高度
    
    CGFloat H  = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat W  = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat xH = H1*count + 10 + H2;
    CGFloat vH = xH > H*0.5 ? H*0.5: xH;
    CGRect  vframe = CGRectMake(0, H, W, vH);
    
    UIView *view = [[UIView alloc] init];
    view.frame = vframe;
    view.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:243.0/255 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, W, vH-10-H2);
    scrollView.contentSize = CGSizeMake(W, H1*count);
    scrollView.showsVerticalScrollIndicator = NO;
    [view addSubview:scrollView];
    
    [self.view addSubview:view];
    _menuView = view;
    _vY = H - vH;
    
    CGFloat bH = H1;
    for (int i = 0; i < _menus.count; i++) {
        
        NSString *title = _menus[i];
        
        UIButton *button = [self jhSetupButton:title];
        button.tag = i + 1;
        button.frame = CGRectMake(0, bH*i, W, bH);
        [scrollView addSubview:button];
        
        UIView *line = [self jhSetupLine];
        line.frame = CGRectMake(0, bH*(i+1)-1, W, 1);
        [scrollView addSubview:line];
    }
    
    //取消按钮
    CGFloat tH = H2;
    CGFloat tY = CGRectGetMaxY(scrollView.frame) + 10;
    
    UIButton *button = [self jhSetupButton:@"取消"];
    button.tag = 0;
    button.frame = CGRectMake(0, tY, W, tH);
    [view addSubview:button];
}

- (UIButton *)jhSetupButton:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    UIColor *color = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(jhButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIView *)jhSetupLine
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1];
    return line;
}

- (void)jhButtonEvent:(UIButton *)button
{
    _buttonIndex = button.tag;
    if (_buttonIndex == 0) {
        _selectedTitle = @"";
    }else{
        _selectedTitle = _menus[_buttonIndex-1];
    }
    [self jhHide];
}

- (void)showIn:(UIViewController *)vc
{
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self.view setFrame:vc.view.bounds];
    [self didMoveToParentViewController:vc];
    
    [self show];
}

- (void)show
{
    CGRect frame = _menuView.frame;
    frame.origin.y = _vY;
    [UIView animateWithDuration:0.25 animations:^{
        _menuView.frame = frame;
    }];
}

@end
