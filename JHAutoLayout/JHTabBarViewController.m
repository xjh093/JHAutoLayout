//
//  JHTabBarViewController.m
//  JHAutoLayout
//
//  Created by HaoCold on 2017/8/3.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHNavigationController.h"
#import "JHTabBar.h"

@interface JHTabBarViewController ()<JHTabBarDelegate>
@property (strong,  nonatomic) JHTabBar     *tabbar;
@end

@implementation JHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self jhAddChildControllers];
}

#pragma mark - 添加子控制器
- (void)jhAddChildControllers
{
#if 1
    NSArray *controllers = @[@"ViewController",@"ViewController",
                             @"ViewController",@"ViewController"];
    NSArray *titles  = @[@"首页",@"游戏",@"进行",@"设置"];
    NSArray *images  = @[@"tab-home",@"tab-txl",@"tab-xiaox",@"tab-my"];
    NSArray *simages = @[@"tab-home-sel",@"tab-txl-sel",@"tab-xiaox-sel",@"tab-my-sel"];
    for (int i = 0; i < controllers.count; ++i) {
        NSString *className = controllers[i];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *vc = class.new;
            vc.tabBarItem.badgeValue = @"4";
            JHNavigationController *nav = [[JHNavigationController alloc]
                                           initWithRootViewController:vc];
            nav.title = titles[i];
            nav.tabBarItem.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = [[UIImage imageNamed:simages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [self addChildViewController:nav];
        }
    }
#endif
    
    JHTabBar *tabbar = [[JHTabBar alloc] init];
    tabbar.tabbarDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
    _tabbar = tabbar;
    
    self.tabBar.tintColor = [UIColor brownColor];
    
    NSLog(@"1.count.%ld",self.tabBar.subviews.count);
    //1.count.1
}

#pragma mark - 处理tabbar的子视图
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabbar.buttonCount = self.tabBar.subviews.count;
    
    NSLog(@"2.count.%ld",self.tabBar.subviews.count);
    //2.count.5
    
    for (int i = 0; i < self.tabBar.subviews.count; ++i) {
        //NSLog(@"%@",self.tabBar.subviews[i]);
    }
}

#pragma mark --- JHTabBarDelegate
- (void)tabBarDidClickCenterButton
{
    //do something
    
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
