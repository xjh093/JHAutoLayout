//
//  UIAlertController+JHCategory.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define jhAlertCtrl(title,message,type)     jh_alertCtrl(title,message,type)

typedef void(^jhAlertAction)();

@interface UIAlertController (JHCategory)

+ (UIAlertController *(^)(id,id,id))jh_alertCtrl;
- (UIAlertController *(^)(id,jhAlertAction))jh_addNormalAction;
- (UIAlertController *(^)(id,jhAlertAction))jh_addCancelAction;
- (UIAlertController *(^)(id,jhAlertAction))jh_addDestructAction;
- (UIAlertController *(^)(id))jh_addTextField;
- (UIAlertController *(^)(id))jh_show;

@end

/**<
 
 UIAlertController
 .jhAlertCtrl(@"Title", @"message", @(1))
 .jh_addNormalAction(@"确定",^{
    //code
 })
 .jh_addCancelAction(@"取消",^{
    //code
 })
 .jh_addDestructAction(@"删除",^{
    //code
 })
 .jh_show(self);
 
 */

