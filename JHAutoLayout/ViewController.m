//
//  ViewController.m
//  JHAutoLayout
//
//  Created by HaoCold on 2016/12/2.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHKit.h"
#import "SecondViewController.h"

@interface ViewController ()

JH_STRONG_P(UILabel, detailLabel)

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.jh_bgColor(@"0xffffff");
    
    //自定义返回按钮
#if 0
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"返回";
    self.navigationItem.backBarButtonItem = back;
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"gift_arrow"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *backImage = [[UIImage imageNamed:@"gift_arrow"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 26, 26, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
#endif
    
    self.navigationItem.title = @"JHAutoLayout";
    
    //开启自动布局-Open AutoLayout
    [self.view jhAutoLayout];
    
    UILabel
    .jhLabel()
    .jh_addToView(self.view)
    .jh_frame(@"[x:0,y:2_h(0)-30,w:W,h:60]")
    .jh_text(@"Control + Command + Z")
    .jh_font(@"25")
    .jh_align(@(1))
    .jh_bgColor([UIColor grayColor])
    .jh_tag(@(100));
    
    self.detailLabel.jh_addToView(self.view)
    .jh_frame(@"[x:10,y:maxy(100)+10,w:W-20,h:h(100)*0.5]")
    .jh_tag(@(200));
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view jhUpdateLayout];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

JH_LAZY_STRONG_UI(UILabel, detailLabel, ({
    UILabel
    .jhLabel()
    .jh_text(@"会有动画")
    .jh_color(@"0x000000")
    .jh_font(@(16))
    .jh_align(@(1))
    .jh_bgColor([UIColor lightGrayColor]);
}))

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
