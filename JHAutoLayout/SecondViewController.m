//
//  SecondViewController.m
//  JHLayoutUI
//
//  Created by HaoCold on 2016/11/30.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "SecondViewController.h"
#import "JHKit.h"
#import "ViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, assign) BOOL           flag;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self jhAddView];
    [self.view jhAutoLayout]; //自动布局
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view jhUpdateLayout]; //更新布局
}

- (void)jhAddView
{
    [self jhSetupView1];
    [self jhSetupView2];
    [self jhSetupLabel1];
    [self jhSetupLabel2];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jhChangeFrame) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantPast];
}

- (void)jhChangeFrame
{
    _flag = !_flag;
    UIView *view = [self.view viewWithTag:100];
    if (_flag) {
        [UIView animateWithDuration:0.5 animations:^{
            view.jh_frame(@"[x:10,y:80,w:2_w(0)-50,h:110]");
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            view.jh_frame(@"[x:10,y:80,w:2_w(0)-15,h:150]");
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
    [self.view jhEndLayout];
}

- (void)jhSetupView1
{    //view_100
    UIView
    .jhView()
    .jh_addToView(self.view)
    .jh_frame(@"[x:10,y:80,w:2_w(0)-15,h:110]")
    .jh_bgColor(({
        UIColor *color = [UIColor lightGrayColor];
        color;
    })).jh_tag(@(100));
    
    //view_101
    UIView
    .jhView()
    .jh_addToView([self.view viewWithTag:100])
    .jh_frame(@"[x:10,y:10,w:w(100)-20,h:h(100)*0.27]")
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    })).jh_tag(@(101));
    
    //view_1011
    UIView
    .jhView()
    .jh_addToView([self.view viewWithTag:101])
    .jh_frame(@"[x:10,y:10,w:w(101)-20,h:h(101)-20]")
    .jh_bgColor(({
        UIColor *color = [UIColor purpleColor];
        color;
    })).jh_tag(@(1011));
    
    //view_102
    UIView
    .jhView()
    .jh_addToView([self.view viewWithTag:100])
    .jh_frame(@"[x:x(101),y:maxy(101)+10,w:2_w(101)-5,h:h(101)]")
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    })).jh_tag(@(102));
    
    //view_103
    UIView
    .jhView()
    .jh_addToView([self.view viewWithTag:100])
    .jh_frame(@"[x:maxx(102)+10,y:y(102),w:w(102),h:h(102)]")
    .jh_bgColor(({
        UIColor *color = [UIColor orangeColor];
        color;
    })).jh_tag(@(103));
    
    //view_104
    UIView
    .jhView()
    .jh_addToView([self.view viewWithTag:100])
    .jh_frame(@"[x:midx(102),y:maxy(102)+5,w:w(102)+10,h:h(101)*0.5]")
    .jh_bgColor(({
        UIColor *color = [UIColor orangeColor];
        color;
    })).jh_tag(@(104));
    
}

- (void)jhSetupView2
{
    //view_200
    UIView
    .jhView()
    .jh_addToView(self.view)
    .jh_frame(@"[x:maxx(100)+10,y:y(100),w:w(100),h:h(100)]")
    .jh_bgColor(({
        UIColor *color = [UIColor lightGrayColor];
        color;
    }))
    .jh_tag(@(200));
    
    //label_201
    UILabel
    .jhLabel()
    .jh_addToView([self.view viewWithTag:200])
    .jh_frame(@"[x:10,y:5,w:w(200)-20,h:15]")
    .jh_text(@"这是一个居中的标签")
    .jh_color(@"0xffffff")
    .jh_align(@(1))
    .jh_font(@"10")
    .jh_adjust(@(1))
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    }))
    .jh_tag(@(201));
    
    //label_202
    UILabel
    .jhLabel()
    .jh_addToView([self.view viewWithTag:200])
    .jh_frame(@"[x:10,y:maxy(201)+5,w:95,h:h(201)]")
    .jh_text(@"这是一个居左的标签")
    .jh_color(@"0xffffff")
    .jh_align(@(0))
    .jh_font(@"10")
    .jh_adjust(@(1))
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    }))
    .jh_tag(@(202));
    
    //label_203
    UILabel
    .jhLabel()
    .jh_addToView([self.view viewWithTag:200])
    .jh_frame(@"[x:maxx(201)-95,y:maxy(202)+5,w:95,h:h(201)]")
    .jh_text(@"这是一个居右的标签")
    .jh_color(@"0xffffff")
    .jh_align(@(2))
    .jh_font(@"10")
    .jh_adjust(@(1))
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    }))
    .jh_tag(@(203));
    
    //label_204
    UILabel
    .jhLabel()
    .jh_addToView([self.view viewWithTag:200])
    .jh_frame(@"[x:maxx(202)-85,y:maxy(203)+5,w:85,h:h(201)]")
    .jh_text(@"这是一个随左的标签")
    .jh_color(@"0xffffff")
    .jh_align(@(2))
    .jh_font(@"10")
    .jh_adjust(@(1))
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    }))
    .jh_tag(@(204));
    
    //label_205
    UILabel
    .jhLabel()
    .jh_addToView([self.view viewWithTag:200])
    .jh_frame(@"[x:maxx(203)-85,y:maxy(204)+5,w:85,h:h(201)]")
    .jh_text(@"这是一个随右的标签")
    .jh_color(@"0xffffff")
    .jh_align(@(2))
    .jh_font(@"10")
    .jh_adjust(@(1))
    .jh_bgColor(({
        UIColor *color = [UIColor brownColor];
        color;
    }))
    .jh_tag(@(205));
    
}

- (void)jhSetupLabel1
{
    UILabel
    .jhLabel()
    .jh_addToView(self.view)
    .jh_frame(@"[x:x(100),y:maxy(100),w:w(100),h:30]")
    .jh_text(@"Command + <-")
    .jh_font(@"14")
    .jh_tag(@(300));
}

- (void)jhSetupLabel2
{
    UILabel
    .jhLabel()
    .jh_addToView(self.view)
    .jh_frame(@"[x:x(200),y:maxy(200),w:w(200),h:30]")
    .jh_text(@"Command + ->")
    .jh_font(@"14")
    .jh_tag(@(400));
}

//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
//}

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
