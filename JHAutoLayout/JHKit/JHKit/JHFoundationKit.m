//
//  JHFoundationKit.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "JHFoundationKit.h"

//=============================================================================//
//  CrashManager
//=============================================================================//
@implementation JHCrashManager

+ (void)jh_startCaughtException
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

void uncaughtExceptionHandler(NSException *exception)
{
#if DEBUG
    NSLog(@"Crash!!!-_-!  here is the info:\n name:%@\n reason:%@\n callStack:%@",exception.name,exception.reason,exception.callStackSymbols);
#elif 0
    NSDictionary *dic = @{@"name":exception.name,
                          @"resaon":exception.reason,
                          @"callStackSysbols":exception.callStackSymbols};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    //[data writeToFile:@"/Users/haocold/Desktop/13726796592.txt" atomically:NO]; //用字典写入文件，会写成plist
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [str writeToFile:@"/Users/haocold/Desktop/CrsahLog.txt" atomically:NO encoding:NSUTF8StringEncoding error:nil];
#endif
}

@end

//=============================================================================//
//  Model
//=============================================================================//
@implementation NSObject (JHModel)

+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    id class = [self new];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        [class setValuesForKeysWithDictionary:dic];
    }
    return class;
}

+ (NSArray *)modelArrayWithDictionaryArray:(NSArray *)arr
{
    NSMutableArray *xArr = @[].mutableCopy;
    for (NSDictionary *dic in arr) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [xArr addObject:[self modelWithDictionary:dic]];
        }
    }
    return xArr;
}

@end



