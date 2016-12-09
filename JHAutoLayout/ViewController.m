//
//  ViewController.m
//  JHAutoLayout
//
//  Created by HaoCold on 2016/12/2.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JHCategory.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"JHAutoLayout";
    
    //开启自动布局-Open AutoLayout
    [self.view jhAutoLayout];
    
    UILabel
    .jhLabel()
    .jh_addToView(self.view)
    .jh_frame(@"[x:0,y:2_h(0)-30,w:W,h:60]")
    .jh_text(@"Control + Command + Z")
    .jh_font(@"25")
    .jh_align(@(1))
    .jh_bgColor([UIColor grayColor]);
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self.view jhUpdateLayout];
}


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[[SecondViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
