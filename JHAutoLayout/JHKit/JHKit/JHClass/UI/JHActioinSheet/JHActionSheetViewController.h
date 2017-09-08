//
//  JHActionSheetViewController.h
//  OldFriendsTravels
//
//  Created by HaoCold on 16/8/11.
//  Copyright © 2016年 HHSX. All rights reserved.
//

/**< 
     类似系统的 actionSheet
 eg:
 - (void)jhTaptoChangePhoto
 {
    NSLog(@"换头像");
 
    JHActionSheetViewController *actionSheetVC = [[JHActionSheetViewController alloc] initWithMenus:@[@"拍照",@"本地相册"]];
    __weak id weakSelf = self;
    [actionSheetVC setClickBlock:^(NSInteger index,NSString *title) {
        NSLog(@"index:%@,title:%@",@(index),title);
    }];

    [actionSheetVC showIn:self];
 }

 */

#import <UIKit/UIKit.h>

typedef void(^JHClickBlock)(NSInteger index,NSString *title);

@interface JHActionSheetViewController : UIViewController

@property (copy,    nonatomic) JHClickBlock clickBlock ; /**< 点击按钮回调 */

- (instancetype)initWithMenus:(NSArray *)menus;

- (void)showIn:(UIViewController *)vc;

@end

