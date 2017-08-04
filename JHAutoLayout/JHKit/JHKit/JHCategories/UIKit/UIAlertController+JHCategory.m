//
//  UIAlertController+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIAlertController+JHCategory.h"

@implementation UIAlertController (JHCategory)

+ (UIAlertController *(^)(id,id,id))jh_alertCtrl{
    return ^id(id title,id message,id type){
        if ([type integerValue] == 0 || [type integerValue] == 1) {
            UIAlertController *jhAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:[type integerValue]];
            return jhAlert;
        }
        return nil;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addNormalAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (jhBlock) {
                jhBlock();
            }
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addCancelAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (jhBlock) {
                jhBlock();
            }
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id,jhAlertAction))jh_addDestructAction{
    return ^id(id title,jhAlertAction jhBlock){
        UIAlertAction *jhAction = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (jhBlock) {
                jhBlock();
            }
        }];
        [self addAction:jhAction];
        return self;
    };
}

- (UIAlertController *(^)(id))jh_addTextField{
    return ^id(id title){
        [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = title;
            textField.leftViewMode = UITextFieldViewModeAlways;
            textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        }];
        return self;
    };
}

- (UIAlertController *(^)(id))jh_show{
    return ^id(id vc){
        if ([vc isKindOfClass:[UIViewController class]]) {
            [vc presentViewController:self animated:YES completion:nil];
        }
        return self;
    };
}

@end
