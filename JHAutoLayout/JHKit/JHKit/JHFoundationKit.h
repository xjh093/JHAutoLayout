//
//  JHFoundationKit.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//=============================================================================//
//  define
//=============================================================================//

#define JH_LAZY_MutableArray(jhclass) \
- (NSMutableArray *)jhclass{ \
    if (!_##jhclass) { \
        _##jhclass = @[].mutableCopy; \
    } \
    return _##jhclass; \
}

#define JH_LAZY_MutableArray_With_Arr(jhclass,jhdetail) \
- (NSMutableArray *)jhclass{ \
    if (!_##jhclass) { \
        _##jhclass = @[].mutableCopy; \
        [_##jhclass addObjectsFromArray:jhdetail]; \
    } \
    return _##jhclass; \
}

#define JH_LAZY_MutableDictionary(jhclass) \
- (NSMutableDictionary *)jhclass{ \
    if (!_##jhclass) { \
        _##jhclass = @{}.mutableCopy; \
    } \
    return _##jhclass; \
}

#define JH_LAZY_MutableDictionary_With_Dic(jhclass,jhdetail) \
- (NSMutableDictionary *)jhclass{ \
    if (!_##jhclass) { \
        _##jhclass = @{}.mutableCopy; \
        [_##jhclass addEntriesFromDictionary:jhdetail]; \
    } \
    return _##jhclass; \
}

#define JH_STRING(jhstring) \
({ \
    NSString *string = @""; \
    if (jhstring != nil) { \
        if ([jhstring isKindOfClass:[NSString class]]) { \
            string = jhstring; \
        }else if ([jhstring isKindOfClass:[NSNumber class]]){ \
            string = [NSString stringWithFormat:@"%@",jhstring]; \
        } \
    } \
    string; \
})

#define JH_STRING_VALUE(jhstring,default) \
({ \
    NSString *string = [default length] > 0?default:@""; \
    if (jhstring != nil) { \
        if ([jhstring isKindOfClass:[NSString class]] && [jhstring length] > 0) { \
            string = jhstring; \
        }else if ([jhstring isKindOfClass:[NSNumber class]]){ \
            string = [NSString stringWithFormat:@"%@",jhstring]; \
        } \
    } \
    string; \
})

//=============================================================================//
//  Somethings
//=============================================================================//
#define force_inline __inline__ __attribute__((always_inline))

force_inline NSString *jh_Documents_file(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
}

force_inline NSString *jh_Library_file(){
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
}

force_inline NSString *jh_Caches_files(){
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) lastObject];
}

force_inline NSString *jh_tmp_file(){
    return NSTemporaryDirectory();
}

force_inline NSString *jh_system_version(){
    return [[UIDevice currentDevice] systemVersion];
}

force_inline NSString *jh_system_language(){
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

force_inline BOOL jh_is_iPhone(){
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

force_inline BOOL jh_is_iPad(){
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

/**< 将汉字转换为中文拼音*/
force_inline Boolean jh_pinyin_from_chinese(NSMutableString *string){
    return CFStringTransform((__bridge CFMutableStringRef)string, 0, kCFStringTransformMandarinLatin, NO);
}

/**< 将中文拼音转换为英文字母,其实就是去掉声调*/
force_inline Boolean jh_english_from_pinyin(NSMutableString *string){
    return CFStringTransform((__bridge CFMutableStringRef)string, 0, kCFStringTransformStripDiacritics, NO);
}

/**< 从字符串中去掉想去除的字符*/
force_inline NSString *jh_remove_characters_in_string(NSString *soureString, NSString *removeString){
    return [[soureString componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:removeString]] componentsJoinedByString:@""];
}

//=============================================================================//
//  CrashManager
//=============================================================================//
@interface JHCrashManager : NSObject
+ (void)jh_startCaughtException;
@end


//=============================================================================//
//  Model
//=============================================================================//

/**< 使用示例:
 一般都只替换 id 的多
 JH_SetValue_ForUndefinedKey((@{@"ID":@"id",@"name":@"Name",@"age":@"Age"}))
 */
#define JH_SetValue_ForUndefinedKey(jhdic) \
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{ \
    for (NSString *jhkey in [jhdic allKeys]) { \
        if ([jhdic[jhkey] isEqualToString:key]) { \
            [self setValue:value forKey:jhkey]; \
            break; \
        } \
    } \
}

@interface NSObject (JHModel)

/** dic -> model */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

/** dicArr -> modelArr*/
+ (NSArray *)modelArrayWithDictionaryArray:(NSArray *)arr;

@end




