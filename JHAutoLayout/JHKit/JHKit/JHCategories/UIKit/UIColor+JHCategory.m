//
//  UIColor+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIColor+JHCategory.h"

NSCache *_jhColorCategoryCache;

@implementation UIColor (JHCategory)

+ (UIColor *)jhColor:(id)object{
    //16进制字符串
    if ([object isKindOfClass:[NSString class]]){
        return [self jhColorWithString:(NSString *)object];
    }
    //UIColor
    else if ([object isKindOfClass:[UIColor class]]){
        return (UIColor *)object;
    }
    
    return [UIColor blackColor];
}

+ (UIColor *)jhColorWithString:(NSString *)string{
    
    UIColor *color = [self jhCheckFromCache:string];
    if (color) {
        return color;
    }
    
    //删除字符串两端的空格
    NSString *xxStr = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //长度是 6 或 8
    if ([xxStr length] < 6){
        return [UIColor blackColor];
    }
    
    //0x开头
    if ([xxStr hasPrefix:@"0X"]){
        xxStr = [xxStr substringFromIndex:2];
    }
    
    //#开头
    if ([xxStr hasPrefix:@"#"]){
        xxStr = [xxStr substringFromIndex:1];
    }
    
    if ([xxStr length] != 6){
        return [UIColor blackColor];
    }
    
    //r, g, b
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rStr = [xxStr substringWithRange:range];
    //g
    range.location = 2;
    NSString *gStr = [xxStr substringWithRange:range];
    //b
    range.location = 4;
    NSString *bStr = [xxStr substringWithRange:range];
    
    //
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    UIColor *xxColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    [_jhColorCategoryCache setObject:xxColor forKey:string];
    return xxColor;
}

+ (UIColor *)jhCheckFromCache:(NSString *)string{
    if (!_jhColorCategoryCache) {
        _jhColorCategoryCache = [[NSCache alloc] init];
        _jhColorCategoryCache.totalCostLimit = 15;
    }
    return [_jhColorCategoryCache objectForKey:string];
}

@end
