//
//  UIView+JHAutoLayoutCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIView+JHAutoLayoutCategory.h"
#import "UIView+JHRectCategory.h"
#import <objc/runtime.h>

@implementation UIView (JHAutoLayoutCategory)

#pragma mark 添加收回键盘点击事件
- (void)jhAddKeyboardHiddenEvent
{
    UITapGestureRecognizer *xTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer:xTap];
}

- (void)hideKeyboard
{
    [self endEditing:YES];
}

#pragma mark 自动布局
- (void)jhAutoLayout
{
    
    //屏幕旋转通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jhAutoLayoutSubview)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    //view frame 更改通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jhViewFrameChanged)
                                                 name:@"jhViewFrameChange"
                                               object:nil];
}

#pragma mark 当前window内view frame 有改动
- (void)jhViewFrameChanged
{
    if (self.subviews.count > 0) { //有子view
        for (UIView *view in self.subviews) {
            JHLog(@"view tag:%@ - %p",@(view.tag),view);
            NSString *frameString = objc_getAssociatedObject(view, "jhFrameString");
            if (frameString.length > 0) {
                CGRect frame = [view jhRectFromString:frameString];
                if(!CGRectEqualToRect(CGRectZero, frame)) {
                    view.frame = frame;
                    [view jhViewFrameChanged];
                }
            }
        }
    }
}

#pragma mark 布局子view
- (void)jhAutoLayoutSubview
{
    
    //当前视图不在窗口
    if (!self.window) {
        JHLog(@"1");
        
        /**< 设置标志，view需要更新*/
        NSString *jh_rotate = objc_getAssociatedObject(self, "jhScreenRotateFlag");
        if ([jh_rotate isEqualToString:@"YES"]) {
            objc_setAssociatedObject(self, "jhScreenRotateFlag", @"NO", OBJC_ASSOCIATION_COPY_NONATOMIC);
            JHLog(@"flag:NO");
        }else{
            objc_setAssociatedObject(self, "jhScreenRotateFlag", @"YES", OBJC_ASSOCIATION_COPY_NONATOMIC);
            JHLog(@"flag:YES");
        }
        
        return;
    }
    if (self.subviews.count > 0) { //有子view
        for (UIView *view in self.subviews) {
            JHLog(@"view tag:%@ - %p",@(view.tag),view);
            NSString *frameString = objc_getAssociatedObject(view, "jhFrameString");
            if (frameString.length > 0) {
                CGRect frame = [view jhRectFromString:frameString];
                if(!CGRectEqualToRect(CGRectZero, frame)) {
                    view.frame = frame;
                    [view jhAutoLayoutSubview];
                }
            }
        }
    }
}

#pragma mark 更新布局
- (void)jhUpdateLayout
{
    /**< 控制器的view第一次加载的时候，就不用更新了*/
    BOOL jh_first_flag = [objc_getAssociatedObject(self, "jhFirstFlag") boolValue];
    /**< 屏幕是否有旋转过*/
    NSString *jh_rotate = objc_getAssociatedObject(self, "jhScreenRotateFlag");
    /**< 第一次加载，无旋转*/
    if (!jh_first_flag && !jh_rotate) {
        objc_setAssociatedObject(self, "jhFirstFlag", @(YES), OBJC_ASSOCIATION_ASSIGN);
    }else{
        
        /**< 屏幕有旋转过，才进行更新*/
        if ([jh_rotate isEqualToString:@"YES"]) {
            objc_setAssociatedObject(self, "jhScreenRotateFlag", @"NO", OBJC_ASSOCIATION_COPY_NONATOMIC);
            [UIView animateWithDuration:0.25 animations:^{
                [self jhAutoLayoutSubview];
                JHLog(@"jhUpdateLayout");
            }];
        }
    }
}

#pragma mark 结束布局
- (void)jhEndLayout
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidChangeStatusBarOrientationNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"jhViewFrameChange"
                                                  object:nil];
}

#pragma mark 通过字符串转成frame & string -> frame
- (CGRect)jhRectFromString:(NSString *)frameStr
{
    NSString *saveFrameStr = frameStr;
    if ([frameStr hasPrefix:@"["] && [frameStr hasSuffix:@"]"] && frameStr.length > 3)
    {
        frameStr = [frameStr substringWithRange:NSMakeRange(1, frameStr.length - 2)];
        frameStr = [frameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *xFourElementArr = [frameStr componentsSeparatedByString:@","];
        if (xFourElementArr.count != 4) return CGRectZero;
        
        NSString *frameValue;
        const char *Landscape_Portrait;
        
        //横屏 & Landscape
        if ([[UIApplication sharedApplication] statusBarOrientation] == 3 ||
            [[UIApplication sharedApplication] statusBarOrientation] == 4) {
            //Landscape
            Landscape_Portrait = "jhFrameString_Landscape";
        }else{
            //Portrait
            Landscape_Portrait = "jhFrameString_Portrait";
        }
        
        //是否有绑定过 计算好的 frame
        frameValue = objc_getAssociatedObject(self, Landscape_Portrait);
        //NSLog(@"%s,frameVaue:%@",Landscape_Portrait,frameValue);
        if (frameValue) {
            return CGRectFromString(frameValue);
        }
        
        NSString *frameString = objc_getAssociatedObject(self, "jhFrameString");
        if (frameString.length == 0) {
            //首次关联对象
            objc_setAssociatedObject(self, "jhFrameString", saveFrameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }else if (frameString.length > 0 && ![saveFrameStr isEqualToString:frameString]){
            //更换关联对象
            objc_setAssociatedObject(self, "jhFrameString", saveFrameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            //remove
            objc_setAssociatedObject(self, Landscape_Portrait, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            //发个通知，重新布局
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jhViewFrameChange" object:nil];
        }
        
        
        CGFloat W = [self jhFloatFromString:xFourElementArr[2]];
        self.jh_w = W;
        CGFloat H = [self jhFloatFromString:xFourElementArr[3]];
        self.jh_h = H;
        CGFloat X = [self jhFloatFromString:xFourElementArr[0]];
        self.jh_x = X;
        CGFloat Y = [self jhFloatFromString:xFourElementArr[1]];
        self.jh_y = Y;
        
        //
        objc_setAssociatedObject(self, Landscape_Portrait, NSStringFromCGRect(self.frame), OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        return CGRectMake(X, Y, W, H);
    }
    
    return CGRectZero;
}

- (CGFloat)jhFloatFromString:(NSString *)string
{
    if ([string hasPrefix:@"x:"] ||
        [string hasPrefix:@"y:"] ||
        [string hasPrefix:@"w:"] ||
        [string hasPrefix:@"h:"])
    {
        NSString *subStr = [string substringFromIndex:2];
        
        //eg. maxx(100)+10 or midx(100)+10 x(100)+10 or x(100)
        
        //replace maxx(100) to CGRectGetMaxX(view.frame) //view.tag is 100
        //replace midx(100) to CGRectGetMidX(view.frame) //view.tag is 100
        //replace x(100)    to CGRectGetMinX(view.frame) //view.tag is 100
        
        while ([subStr rangeOfString:@")" options:NSBackwardsSearch].length > 0) {
            NSRange xRange = [subStr rangeOfString:@")" options:NSBackwardsSearch];
            NSString *leftPart = [subStr substringToIndex:xRange.location];
            xRange = [subStr rangeOfString:@"(" options:NSBackwardsSearch];
            if (xRange.length < 1) {
                break;
            }
            
            NSUInteger start = 0;
            for (NSInteger i = leftPart.length - 1; i >= 0; --i) {
                unichar c = [leftPart characterAtIndex:i];
                if (c == '+' || c == '-' || c == '*' || c == '/') {
                    start = i + 1;
                    break;
                }
            }
            
            NSString *rightPart = [leftPart substringFromIndex:start];
            CGFloat value = [self jhParseFirstSubStr:rightPart];
            NSString *replacePart = [NSString stringWithFormat:@"%.2f",value];
            
            NSRange range = [leftPart rangeOfString:rightPart];
            range.length += 1;
            subStr = [subStr stringByReplacingCharactersInRange:range withString:replacePart];
        }
        
        //replace W or H
        //W+10.0,W-10.0,W*10.0,W/10.0,W*200/320,
        //W - [UIScreen mainScreen].bounds.size.width
        //H - [UIScreen mainScreen].bounds.size.height
        //w - self.frame.size.width
        //h - self.frame.size.height
        if ([subStr containsString:@"W"] ||
            [subStr containsString:@"H"] ||
            [subStr containsString:@"w"] ||
            [subStr containsString:@"h"]) {
            CGFloat value = 0;
            NSRange range = NSMakeRange(0, 0);
            if ([subStr rangeOfString:@"W" options:NSLiteralSearch].length > 0) {
                range = [subStr rangeOfString:@"W" options:NSLiteralSearch];
                value = [UIScreen mainScreen].bounds.size.width;
                
                subStr = [self jhReplace:value :subStr :range];
            }
            if ([subStr rangeOfString:@"H" options:NSLiteralSearch].length > 0){
                range = [subStr rangeOfString:@"H" options:NSLiteralSearch];
                value = [UIScreen mainScreen].bounds.size.height;
                
                subStr = [self jhReplace:value :subStr :range];
            }
            if ([subStr rangeOfString:@"w" options:NSLiteralSearch].length > 0) {
                range = [subStr rangeOfString:@"w" options:NSLiteralSearch];
                value = self.frame.size.width;
                
                subStr = [self jhReplace:value :subStr :range];
            }
            if ([subStr rangeOfString:@"h" options:NSLiteralSearch].length > 0){
                range = [subStr rangeOfString:@"h" options:NSLiteralSearch];
                value = self.frame.size.height;
                
                subStr = [self jhReplace:value :subStr :range];
            }
        }
        
        if ([subStr containsString:@"+"] ||
            [subStr containsString:@"-"] ||
            [subStr containsString:@"*"] ||
            [subStr containsString:@"/"] ) {
            return [[NSString jh_caculateStringFormula:subStr] floatValue];
        }
        else if ([self isPureInt:subStr] || [self isPureFloat:subStr]) {
            return [subStr floatValue];
        }else{
            return 0.0;
        }
    }
    return 0.0;
}

- (NSString *)jhReplace:(CGFloat)value :(NSString *)subStr :(NSRange)range
{
    NSString *replaceString = [NSString stringWithFormat:@"%.2f",value];
    return [subStr stringByReplacingOccurrencesOfString:[subStr substringWithRange:range] withString:replaceString];
}

#pragma mark 是否为整形
- (BOOL)isPureInt:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 是否为浮点形
- (BOOL)isPureFloat:(NSString*)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (CGFloat)jhParseFirstSubStr:(NSString *)firstStr
{
    NSArray *subArr = [firstStr componentsSeparatedByString:@"("];
    if (subArr.count != 2) return 0.0;
    
    NSString *first  = subArr[0];
    NSString *second = subArr[1];
    
    if (![self isPureInt:second]) return 0.0;
    
    UIView *view = [self.superview viewWithTag:[second integerValue]];
    if (view == nil) {
        view = [self viewWithTag:[second integerValue]];
        if (view == nil) return 0.0;
    }
    
    return [self jhFloatFromView:view withPreID:first];
}

- (CGFloat)jhFloatFromView:(UIView *)view withPreID:(NSString *)first
{
    if ([first isEqualToString:@"x"]) {
        return view.jh_x;
    }else if ([first isEqualToString:@"y"]){
        return view.jh_y;
    }else if ([first isEqualToString:@"w"]){
        return view.jh_w;
    }else if ([first isEqualToString:@"h"]){
        return view.jh_h;
    }else if ([first isEqualToString:@"maxx"]){
        return view.jh_max_x;
    }else if ([first isEqualToString:@"maxy"]){
        return view.jh_max_y;
    }else if ([first isEqualToString:@"midx"]){
        return view.jh_mid_x;
    }else if ([first isEqualToString:@"midy"]){
        return view.jh_mid_y;
    }else{
        return [self jhMultiple:first view:view];
    }
    return 0.0;
}

- (CGFloat)jhMultiple:(NSString *)prefix view:(UIView *)view
{
    /**< prefix: eg: 2_x,3_x,4_x,...*/
    if ([prefix rangeOfString:@"_"].length == 0) {
        return 0.0;
    }
    
    NSArray *arr = [prefix componentsSeparatedByString:@"_"];
    NSString *first = arr[0];
    if (![self isPureInt:first]) return 0.0;
    
    CGFloat floatValue = [self jhFloatFromView:view withPreID:arr[1]];
    return floatValue/[first integerValue];
}

- (CGSize)jhSizeFromString:(NSString *)sizeStr
{
    if ([sizeStr hasPrefix:@"["] && [sizeStr hasSuffix:@"]"] && sizeStr.length > 3)
    {
        sizeStr = [sizeStr substringWithRange:NSMakeRange(1, sizeStr.length - 2)];
        sizeStr = [sizeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *xTwoElementArr = [sizeStr componentsSeparatedByString:@","];
        if (xTwoElementArr.count != 2) return CGSizeZero;
        
        CGFloat X = [self jhFloatFromString:xTwoElementArr[0]];
        CGFloat Y = [self jhFloatFromString:xTwoElementArr[1]];
        
        return CGSizeMake(X, Y);
    }
    
    return CGSizeZero;
}

@end
