//
//  JHLocationManager.h
//  Advise
//
//  Created by Lightech on 16/5/13.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHLocationManager : NSObject

+ (instancetype)manager;

- (void)startLocation:(void(^)(NSString *city))success;

@end
