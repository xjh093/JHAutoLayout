//
//  UIView+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"
#import <objc/runtime.h>

@implementation UIView (JHCategory)

- (void)setJh_x:(CGFloat)jh_x{
    CGRect frame = self.frame;
    frame.origin.x = jh_x;
    self.frame = frame;
}

- (CGFloat)jh_x{
    return self.frame.origin.x;
}

- (void)setJh_y:(CGFloat)jh_y{
    CGRect frame = self.frame;
    frame.origin.y = jh_y;
    self.frame = frame;
}

- (CGFloat)jh_y{
    return self.frame.origin.y;
}

- (void)setJh_w:(CGFloat)jh_w{
    CGRect frame = self.frame;
    frame.size.width = jh_w;
    self.frame = frame;
}

- (CGFloat)jh_w{
    return self.frame.size.width;
}

- (void)setJh_h:(CGFloat)jh_h{
    CGRect frame = self.frame;
    frame.size.height = jh_h;
    self.frame = frame;
}

- (CGFloat)jh_h{
    return self.frame.size.height;
}

- (void)setJh_center_x:(CGFloat)jh_center_x{
    CGPoint point = self.center;
    point.x = jh_center_x;
    self.center = point;
}

- (CGFloat)jh_center_x{
    return self.center.x;
}

- (void)setJh_center_y:(CGFloat)jh_center_y{
    CGPoint point = self.center;
    point.y = jh_center_y;
    self.center = point;
}

- (CGFloat)jh_center_y{
    return self.center.y;
}

- (void)setJh_origin:(CGPoint)jh_origin{
    CGRect frame = self.frame;
    frame.origin.x = jh_origin.x;
    frame.origin.y = jh_origin.y;
    self.frame = frame;
}

- (CGPoint)jh_origin{
    return self.frame.origin;
}

- (void)setJh_size:(CGSize)jh_size{
    CGRect frame = self.frame;
    frame.size.width  = jh_size.width;
    frame.size.height = jh_size.height;
    self.frame = frame;
}

- (CGSize)jh_size{
    return self.frame.size;
}

- (CGFloat)jh_mid_x{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)jh_mid_y{
    return CGRectGetMidY(self.frame);
}

- (CGFloat)jh_max_x{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)jh_max_y{
    return CGRectGetMaxY(self.frame);
}

JH_new_m(UIView)
JH_tag_m(UIView)
JH_frame_m(UIView)
JH_alpha_m(UIView)
JH_bgColor_m(UIView)
JH_bdColor_m(UIView)
JH_bdWidth_m(UIView)
JH_cnRadius_m(UIView)
JH_mtBounds_m(UIView)
JH_addToView_m(UIView)

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
    BOOL jh_first_flag = objc_getAssociatedObject(self, "jhFirstFlag");
    /**< 屏蔽是否有旋转过*/
    NSString *jh_rotate = objc_getAssociatedObject(self, "jhScreenRotateFlag");
    /**< 第一次加载，无旋转*/
    if (!jh_first_flag && !jh_rotate) {
        objc_setAssociatedObject(self, "jhFirstFlag", @(YES), OBJC_ASSOCIATION_ASSIGN);
    }else{
        
        /**< 屏幕有旋转过，才进行更新*/
        //NSString *jh_rotate = objc_getAssociatedObject(self, "jhScreenRotateFlag");
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

#pragma mark 通过字符串转成frame
- (CGRect)jhRectFromString:(NSString *)frameStr
{
    NSString *saveFrameStr = frameStr;
    if ([frameStr hasPrefix:@"["] && [frameStr hasSuffix:@"]"] && frameStr.length > 3)
    {
        frameStr = [frameStr substringWithRange:NSMakeRange(1, frameStr.length - 2)];
        frameStr = [frameStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *xFourElementArr = [frameStr componentsSeparatedByString:@","];
        if (xFourElementArr.count != 4) return CGRectZero;
        
        NSString *frameString = objc_getAssociatedObject(self, "jhFrameString");
        if (frameString.length == 0) {
            //首次关联对象
            objc_setAssociatedObject(self, "jhFrameString", saveFrameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }else if (frameString.length > 0 && ![saveFrameStr isEqualToString:frameString]){
            //更换关联对象
            objc_setAssociatedObject(self, "jhFrameString", saveFrameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
            
            //发个通知，重新布局
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jhViewFrameChange" object:nil];
        }
        
        CGFloat X = [self jhFloatFromString:xFourElementArr[0]];
        CGFloat Y = [self jhFloatFromString:xFourElementArr[1]];
        CGFloat W = [self jhFloatFromString:xFourElementArr[2]];
        CGFloat H = [self jhFloatFromString:xFourElementArr[3]];
        
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
        //eg. 2_x(100)+10 or x(100)+10 or x(100) or 10
        //or  2_x(100)+(10-20)*30/40
        
        //first ")"
        NSRange xRange = [subStr rangeOfString:@")"];
        if (xRange.length > 0) {
            //2_x(100
            NSString *leftPart = [subStr substringToIndex:xRange.location];
            CGFloat firstValue = [self jhParseFirstSubStr:leftPart];
            leftPart = [NSString stringWithFormat:@"%.2f",firstValue];
            
            NSRange range = [subStr rangeOfString:[subStr substringToIndex:xRange.location+1]];
            subStr = [subStr stringByReplacingCharactersInRange:range withString:leftPart];
        }
        
        //replace W or H
        //W+10.0,W-10.0,W*10.0,W/10.0,W*200/320,
        if ([subStr containsString:@"W"] || [subStr containsString:@"H"]) {
            CGFloat value = 0;
            NSRange range = [subStr rangeOfString:@"W"];
            if (range.length > 0) {
                value = [UIScreen mainScreen].bounds.size.width;
            }else{
                range = [subStr rangeOfString:@"H"];
                if (range.length > 0) {
                    value = [UIScreen mainScreen].bounds.size.height;
                }
            }
            
            NSString *replaceString = [NSString stringWithFormat:@"%.2f",value];
            subStr = [subStr stringByReplacingOccurrencesOfString:[subStr substringWithRange:range] withString:replaceString];
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

- (CGFloat)jhWorH:(CGFloat)wh str:(NSString *)str1
{
    if (str1.length == 1) {
        return wh;
    }
    else if (str1.length > 2){
        NSString *operation = [str1 substringWithRange:NSMakeRange(1, 1)];
        NSString *value = [str1 substringFromIndex:2];
        if ([self isPureInt:value] || [self isPureFloat:value]) {
            if ([operation isEqualToString:@"+"]) {
                return wh + [value floatValue];
            }else if ([operation isEqualToString:@"-"]) {
                return wh - [value floatValue];
            }else if ([operation isEqualToString:@"*"]) {
                return wh * [value floatValue];
            }else if ([operation isEqualToString:@"/"]) {
                return wh / [value floatValue];
            }
        }
    }
    return 0.0;
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
    NSArray *subArr = [firstStr componentsSeparatedByString:@"("]; // 2_x 100
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

//画直线 - draw line in view.
- (void)jhDrawLineFromPoint:(CGPoint)fPoint
                    toPoint:(CGPoint)tPoint
                  lineColor:(UIColor *)color
                  lineWidth:(CGFloat)width
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    shapeLayer.lineWidth = width;
    [self.layer addSublayer:shapeLayer];
}

//画虚线 - draw dash line.
- (void)jhDrawDashLineFromPoint:(CGPoint)fPoint
                        toPoint:(CGPoint)tPoint
                      lineColor:(UIColor *)color
                      lineWidth:(CGFloat)width
                      lineSpace:(CGFloat)space
                       lineType:(NSInteger)type
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    //第一格虚线缩进多少 - the degree of indent of the first cell
    //shapeLayer.lineDashPhase = 4;
    shapeLayer.lineWidth = width;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineDashPattern = @[@(width),@(space)];
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPattern = @[@(width),@(space+width)];
    }
    [self.layer addSublayer:shapeLayer];
}

- (void)jhDrawPentagram:(CGPoint)center
                 radius:(CGFloat)radius
                  color:(UIColor *)color
                   rate:(CGFloat)rate
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    if (color) {
        shapeLayer.fillColor = color.CGColor;
    }
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        //五角星最上面的点
        CGPoint first  = CGPointMake(center.x, center.y-radius);
        
        [path moveToPoint:first];
        
        //点与点之间点夹角为2*M_PI/5.0,要隔一个点才连线
        CGFloat angle=4*M_PI/5.0;
        if (rate > 1.5) {
            rate = 1.5;
        }
        for (int i= 1; i <= 5; i++) {
            CGFloat x = center.x - sinf(i*angle)*radius;
            CGFloat y = center.y - cosf(i*angle)*radius;
            
            CGFloat midx = center.x - sinf(i*angle-2*M_PI/5.0)*radius*rate;
            CGFloat midy = center.y - cosf(i*angle-2*M_PI/5.0)*radius*rate;
            [path addQuadCurveToPoint:CGPointMake(x, y) controlPoint:CGPointMake(midx, midy)];
        }
        
        path.CGPath;
    });
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:shapeLayer];
}
@end
