//
//  UIFont+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIFont+JHCategory.h"

NSCache *_jhFontCategoryCache;

@implementation UIFont (JHCategory)

+ (UIFont *)jhFont:(id)object{
    //字符串 例如：17,s17,b17,i17
    if ([object isKindOfClass:[NSString class]]){
        return [self jhFontWithString:(NSString *)object];
    }
    //UIFont
    else if ([object isKindOfClass:[UIFont class]]){
        return (UIFont *)object;
    }
    
    return [UIFont systemFontOfSize:17.0];
}

+ (UIFont *)jhFontWithString:(NSString *)string{
    UIFont *font = [self jhCheckFromCache:string];
    if (font) {
        return font;
    }
    
    font = [UIFont systemFontOfSize:17.0];
    
    if ([self jhIsPureInt:string] || [self jhIsPureFloat:string]){
        font = [UIFont systemFontOfSize:[string floatValue]];
    }else if ([string hasPrefix:@"s"]){
        if ([self jhFontWithSubstr:string]) {
            font =  [UIFont systemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }
    }else if ([string hasPrefix:@"b"]){
        if ([self jhFontWithSubstr:string]) {
            font =  [UIFont boldSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }
    }else if ([string hasPrefix:@"i"]){
        if ([self jhFontWithSubstr:string]) {
            font =  [UIFont italicSystemFontOfSize:[[string substringFromIndex:1] floatValue]];
        }
    }
    
    [_jhFontCategoryCache setObject:font forKey:string];
    
    //默认
    return font;
}

+ (BOOL)jhFontWithSubstr:(NSString *)string
{
    NSString *subStr = [string substringFromIndex:1];
    if ([self jhIsPureInt:subStr] || [self jhIsPureFloat:subStr]){
        return YES;
    }
    return NO;
}

//判断是否为整形
+ (BOOL)jhIsPureInt:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
+ (BOOL)jhIsPureFloat:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (UIFont *)jhCheckFromCache:(NSString *)string{
    if (!_jhFontCategoryCache) {
        _jhFontCategoryCache = [[NSCache alloc] init];
        _jhFontCategoryCache.totalCostLimit = 15;
    }
    return [_jhFontCategoryCache objectForKey:string];
}

@end
