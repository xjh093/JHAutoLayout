//
//  UITableView+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UITableView+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UITableView (JHCategory)
+ (UITableView *)jhTableView:(NSString *)frameStr style:(NSInteger)style target:(id)target view:(UIView *)view addToView:(BOOL)flag
{
    UITableView *xTableView = nil;
    if (style == 0 || style == 1)
        xTableView = [[UITableView alloc] initWithFrame:[view jhRectFromString:frameStr] style:style];
    
    xTableView.delegate = target;
    xTableView.dataSource = target;
    xTableView.tableFooterView = [[UIView alloc] init];
    xTableView.showsVerticalScrollIndicator = NO;
    xTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (view && flag) [view addSubview:xTableView];
    
    return xTableView;
}

JH_tag_m(UITableView)
JH_bind_m(UITableView)
JH_frame_m(UITableView)
JH_alpha_m(UITableView)
JH_bgColor_m(UITableView)
JH_bdColor_m(UITableView)
JH_bdWidth_m(UITableView)
JH_cnRadius_m(UITableView)
JH_mtBounds_m(UITableView)
JH_delegate_m(UITableView)
JH_addToView_m(UITableView)

+ (UITableView *(^)(id))jh_tableView{
    return ^id(id type){
        if ([type isKindOfClass:[NSNumber class]]) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:[type integerValue]];
            return tableView;
        }
        return nil;
    };
}

@end
