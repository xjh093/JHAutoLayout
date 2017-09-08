//
//  JHBaseChildVC.m
//  JHKit
//
//  Created by HaoCold on 2017/8/16.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHBaseChildVC.h"

@interface JHBaseChildVC ()

@end

@implementation JHBaseChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self jh_setupViews];
}

- (void)jh_setupViews
{
    //灰色View
    UIView *grayView = [[UIView alloc] init];
    grayView.frame = self.view.bounds;
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.2;
    [self.view addSubview:grayView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jh_hide)];
    [grayView addGestureRecognizer:tap];
}

- (void)jh_showIn:(UIViewController *)vc
{
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self.view setFrame:vc.view.bounds];
    [self didMoveToParentViewController:vc];
}

- (void)jh_hide
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
