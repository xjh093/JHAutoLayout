//
//  JHFileManager.m
//  JHKit
//
//  Created by HaoCold on 2017/6/23.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHFileManager.h"

NSString *_currentFullPath; //Documents

@implementation JHFileManager

+ (void)initialize{
    if (!_currentFullPath) {
        _currentFullPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    }
}

+ (NSString *)xx_newPath:(NSString *)name{
    if (name.length == 0) {
        return @"";
    }
    
    BOOL flag = [[NSFileManager defaultManager] fileExistsAtPath:_currentFullPath];
    if (!flag) {
        return @"";
    }
    
    return [_currentFullPath stringByAppendingPathComponent:name];
}

+ (NSString *)jh_currentFullPath{
    return _currentFullPath;
}

+ (void)jh_setCurrentFullPath:(NSString *)path{
    if (path.length) {
        _currentFullPath = path;
    }
}

+ (BOOL)jh_createDocument:(NSString *)name{
    NSString *path = [self xx_newPath:name];
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)jh_deleteDocument:(NSString *)name{
    NSString *path = [self xx_newPath:name];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (error) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)jh_moveFile:(NSString *)file to:(NSString *)des{
    NSString *path1 = [self xx_newPath:file];
    NSString *path2 = [self xx_newPath:des];
    NSError *error;
    [[NSFileManager defaultManager] moveItemAtPath:path1 toPath:path2 error:&error];
    if (error) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)jh_deleteFile:(NSString *)file{
    return [self jh_deleteDocument:file];
}

#pragma mark ------

///创建在Documents下的文件夹
+ (NSString *)jh_createDocumentsDirectory:(NSString *)subPath{
    return [self xx_createDirectories:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:subPath]];
}
///创建在Library下的文件夹
+ (NSString *)jh_createLibraryDirectory:(NSString *)subPath{
    return [self xx_createDirectories:[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:subPath]];
}
///创建在Caches下的文件夹
+ (NSString *)jh_createCachesDirectory:(NSString *)subPath{
    return [self xx_createDirectories:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:subPath]];
}
///创建在tmp下的文件夹
+ (NSString *)jh_createTmpDirectory:(NSString *)subPath{
    return [self xx_createDirectories:[NSTemporaryDirectory() stringByAppendingPathComponent:subPath]];
}

+ (NSString *)xx_createDirectories:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"%s:error:%@",__func__,error);
        }else{
            path = nil;
        }
    }
    return path;
}

@end
