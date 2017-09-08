//
//  UITableView+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCategoriesDeifne.h"

#define jhTableView(type) jh_tableView(type)

@interface UITableView (JHCategory)
+ (UITableView *)jhTableView:(NSString *)frameStr style:(NSInteger)style target:(id)target view:(UIView *)view addToView:(BOOL)flag; /**< style:plain-0,group-1.*/

JH_tag_h(UITableView)
JH_bind_h(UITableView)
JH_frame_h(UITableView)
JH_alpha_h(UITableView)
JH_bgColor_h(UITableView)
JH_bdColor_h(UITableView)
JH_bdWidth_h(UITableView)
JH_cnRadius_h(UITableView)
JH_mtBounds_h(UITableView)
JH_delegate_h(UITableView)
JH_addToView_h(UITableView)

+ (UITableView *(^)(id))jh_tableView;

@end
