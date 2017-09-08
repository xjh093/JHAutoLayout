//
//  JHFileManager.h
//  JHKit
//
//  Created by HaoCold on 2017/6/23.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHFileManager : NSObject

/**
 当前所在文件的全路径-默认Documents
 2017-08-10 15:39:56
 
 @return 当前所在文件的全路径
 */
+ (NSString *)jh_currentFullPath;


/**
 设置新的路径
 2017-08-10 15:54:00
 
 @param path 新的路径
 */
+ (void)jh_setCurrentFullPath:(NSString *)path;

/**
 创建文件夹
 2017-08-10 15:41:12
 
 @param name 文件夹名称
 @return 创建文件夹是否成功
 */
+ (BOOL)jh_createDocument:(NSString *)name;

/**
 删除文件夹
 2017-08-10 15:41:58
 
 @param name 文件夹名称
 @return 删除文件夹是否成功
 */
+ (BOOL)jh_deleteDocument:(NSString *)name;

/**
 移动文件
 2017-08-10 15:46:34
 
 @param file 文件
 @param des 目的地
 @return 是否成功
 */
+ (BOOL)jh_moveFile:(NSString *)file to:(NSString *)des;

/**
 删除文件
 2017-08-10 16:03:24
 
 @param file 文件
 @return 是否删除成功
 */
+ (BOOL)jh_deleteFile:(NSString *)file;



///创建在Documents下的文件夹
+ (NSString *)jh_createDocumentsDirectory:(NSString *)subPath;
///创建在Library下的文件夹
+ (NSString *)jh_createLibraryDirectory:(NSString *)subPath;
///创建在Caches下的文件夹
+ (NSString *)jh_createCachesDirectory:(NSString *)subPath;
///创建在tmp下的文件夹
+ (NSString *)jh_createTmpDirectory:(NSString *)subPath;

@end

/**< 沙盒目录
 |_ Documents
 |_ Library
    |_ Caches
    |_ Preferences
 |_ tmp
 
 */

/**<
 ---------------Documents
 ①存放内容
 我们可以将应用程序的数据文件保存在该目录下。不过这些数据类型仅限于不可再生的数据，可再生的数据文件应该存放在Library/Cache目录下。
 ②是否会被iTunes同步
 是
 
 ---------------Documents/Inbox
 ①存放内容
 该目录用来保存由外部应用请求当前应用程序打开的文件。
 比如我们的应用叫A，向系统注册了几种可打开的文件格式，B应用有一个A支持的格式的文件F，并且申请调用A打开F。由于F当前是在B应用的沙盒中，我们知道，沙盒机制是不允许A访问B沙盒中的文件，因此苹果的解决方案是讲F拷贝一份到A应用的Documents/Inbox目录下，再让A打开F。
 ②是否会被iTunes同步
 是
 
 ---------------Library
 ①存放内容
 苹果建议用来存放默认设置或其它状态信息。
 ②是否会被iTunes同步
 是，但是要除了Caches子目录外
 
 ---------------Library/Caches
 ①存放内容
 主要是缓存文件，用户使用过程中缓存都可以保存在这个目录中。前面说过，Documents目录用于保存不可再生的文件，那么这个目录就用于保存那些可再生的文件，比如网络请求的数据。鉴于此，应用程序通常还需要负责删除这些文件。
 ②是否会被iTunes同步
 否。
 
 ---------------Library/Preferences
 ①存放内容
 应用程序的偏好设置文件。我们使用NSUserDefaults写的设置数据都会保存到该目录下的一个plist文件中，这就是所谓的写道plist中！
 ②是否会被iTunes同步
 是
 
 ---------------tmp
 ①存放内容
 各种临时文件，保存应用再次启动时不需要的文件。而且，当应用不再需要这些文件时应该主动将其删除，因为该目录下的东西随时有可能被系统清理掉，目前已知的一种可能清理的原因是系统磁盘存储空间不足的时候。
 ②是否会被iTunes同步
 否
 */
