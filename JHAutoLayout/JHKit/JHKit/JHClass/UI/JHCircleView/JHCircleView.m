//
//  JHCircleView.m
//  JHKit
//
//  Created by HaoCold on 2017/1/22.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHCircleView.h"

@interface JHCircleOutView : UIView
@property (nonatomic, copy)   void (^jhEndBlock)(id obj);
@property (nonatomic, assign) CGFloat  endAngle;
@property (nonatomic, strong) NSTimer   *timer;
- (void)jhStartDraw;
- (void)jhEndDraw;
@end

@implementation JHCircleOutView : UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _endAngle = -90*M_PI/180.0;
    }
    return self;
}

- (void)jhStartDraw
{
    self.timer.fireDate = [NSDate distantPast];
}

- (void)jhEndDraw
{
    [self.timer invalidate];
    self.timer = nil;
    _endAngle = -90*M_PI/180.0;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 8);
    
    CGFloat X = self.bounds.size.width*0.5;
    CGFloat Y = X;
    CGFloat R = X;
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 0.5);//改变画笔颜色
    CGContextAddArc(context, X, Y, R,  -90 * M_PI / 180, _endAngle, 0);
    CGContextStrokePath(context);//绘画路径
}

- (void)setEndAngle:(CGFloat)endAngle
{
    _endAngle = endAngle;
    
    [self setNeedsDisplay];
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(jhDraw) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)jhDraw
{
    _endAngle += 0.1;
    [self setNeedsDisplay];
    //NSLog(@"%f",_endAngle);
    if (_endAngle >= 270*M_PI/180.0) {
        [self setNeedsDisplay];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_jhEndBlock) {
                _jhEndBlock(@"结束了");
            }
        });
    }
}

@end


@interface JHCircleView()

@property (nonatomic, strong) JHCircleOutView *outCircleView;
@property (nonatomic, strong) UIView          *innCircleView;

@end

@implementation JHCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGRectIsEmpty(frame)) {
        frame = CGRectMake(0, 0, 100, 100);
    }
    self = [super initWithFrame:frame];
    if (self) {

        [self jhSetupViews];
    }
    return self;
}

- (void)jhSetupViews
{
    self.backgroundColor = [UIColor clearColor];
    
    JHCircleOutView *view = [[JHCircleOutView alloc] init];
    view.frame = self.bounds;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    view.layer.cornerRadius = view.bounds.size.width*0.5;
    view.layer.masksToBounds = YES;
    __weak typeof(self)ws = self;
    view.jhEndBlock = ^(id obj){
        [ws jhEndScale:obj];
    };
    [self addSubview:view];
    _outCircleView = view;
    
    CGFloat W = self.bounds.size.width*0.5;
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(view.bounds.size.width*0.5-W*0.5, view.bounds.size.height*0.5-W*0.5, W, W);
    view1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    view1.layer.cornerRadius = view1.bounds.size.width*0.5;
    [view addSubview:view1];
    _innCircleView = view1;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(jhLongpress:)];
    [self addGestureRecognizer:longPress];
}

- (void)jhEndScale:(id)obj
{
    [_outCircleView jhEndDraw];
    [UIView animateWithDuration:0.25 animations:^{
        _outCircleView.transform = CGAffineTransformIdentity;
        _innCircleView.transform = CGAffineTransformIdentity;
    }];
}

- (void)jhLongpress:(UIGestureRecognizer *)longpress{
    
    if (longpress.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.15 animations:^{
            _outCircleView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            _innCircleView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        } completion:^(BOOL finished) {
            [_outCircleView jhStartDraw];
        }];
    }else if (longpress.state == UIGestureRecognizerStateEnded){
        [self jhEndScale:nil];
    }
    CGPoint p = [longpress locationInView:_outCircleView];
    NSLog(@"%f-%f",p.x,p.y);
}

@end

