//
//  JHImageClipView.m
//  JHLoadingView
//
//  Created by HaoCold on 2016/11/21.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "JHImageClipView.h"

@interface JHImageClipView()

@property (weak,    nonatomic) UIView       *moveView;
@property (weak,    nonatomic) UIImageView  *imageView;

@end

@implementation JHImageClipView

#pragma mark - System
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self jhSetupViews];
    }
    return self;
}

#pragma mark - Private
- (void)jhSetupViews
{
    self.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
    _imageView = imageView;
    
    UIView *moveView = [[UIView alloc] init];
    moveView.frame = CGRectMake(0, 0, 50, 50);
    moveView.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    moveView.layer.borderWidth = 1;
    moveView.layer.borderColor = [UIColor greenColor].CGColor;
    [self addSubview:moveView];
    _moveView = moveView;
    
    //拖动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(jhPan:)];
    [self addGestureRecognizer:pan];
    
    //缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(jhPinch:)];
    [self addGestureRecognizer:pinch];
    
}

- (void)jhPan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:self];
    [self jhSetMoveViewFrame:point];
}

- (void)jhPinch:(UIPinchGestureRecognizer *)pinch
{
    CGFloat scale = pinch.scale;
    if (scale < 1 && scale > 0.1) { //缩小
        [self jhScaleMoveViewFrame:-1];
    }
    else if (scale >= 1) //放大
    {
        [self jhScaleMoveViewFrame:1];
    }
}

- (void)jhSetMoveViewFrame:(CGPoint)point
{
    [UIView animateWithDuration:0.25 animations:^{
        _moveView.center = point;
        [self jhResetMoveViewFrame];
    }];
}

- (void)jhResetMoveViewFrame
{
    if (_moveView.frame.size.width < 20) {
        CGRect frame = _moveView.frame;
        frame.size.width = 20;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.size.height < 20) {
        CGRect frame = _moveView.frame;
        frame.size.height = 20;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.size.width > _imageView.frame.size.width) {
        CGRect frame = _moveView.frame;
        frame.size.width = _imageView.frame.size.width;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.size.height > _imageView.frame.size.height) {
        CGRect frame = _moveView.frame;
        frame.size.height = _imageView.frame.size.height;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.origin.x < _imageView.frame.origin.x) {
        CGRect frame = _moveView.frame;
        frame.origin.x = _imageView.frame.origin.x;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.origin.y < _imageView.frame.origin.y) {
        CGRect frame = _moveView.frame;
        frame.origin.y = _imageView.frame.origin.y;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.origin.x > CGRectGetMaxX(_imageView.frame) - _moveView.frame.size.width) {
        CGRect frame = _moveView.frame;
        frame.origin.x = CGRectGetMaxX(_imageView.frame) - _moveView.frame.size.width;
        _moveView.frame = frame;
    }
    
    if (_moveView.frame.origin.y > CGRectGetMaxY(_imageView.frame) - _moveView.frame.size.height) {
        CGRect frame = _moveView.frame;
        frame.origin.y = CGRectGetMaxY(_imageView.frame) - _moveView.frame.size.height;
        _moveView.frame = frame;
    }
}

- (void)jhScaleMoveViewFrame:(CGFloat)dis
{
    CGPoint center = _moveView.center;
    CGFloat offset = 5;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect  frame  = _moveView.frame;
        if (dis > 0) {
            frame.size.width += offset;
            frame.size.height += offset;
            _moveView.frame = frame;
            _moveView.center = center;
        }else{
            frame.size.width -= offset;
            frame.size.height -= offset;
            _moveView.frame = frame;
            _moveView.center = center;
        }
        [self jhResetMoveViewFrame];
    }];
}

-(UIImage*)jhImage:(UIImage *)image scaleToSize:(CGSize)newSize
{
    newSize = (CGSize){newSize.width, newSize.height};
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    [image drawInRect:(CGRect){CGPointZero, newSize}];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Public
- (UIImage *)jh_clip_image
{
    CGFloat scale  = [UIScreen mainScreen].scale;
    CGRect  frame  = [self convertRect:_moveView.frame toView:_imageView];
    CGRect  frame1 = CGRectMake(frame.origin.x*scale, frame.origin.y*scale, frame.size.width*scale, frame.size.height*scale);
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(_imageView.image.CGImage, frame1)];
}

#pragma mark - Property
- (void)setSourceImage:(UIImage *)sourceImage
{
    if (sourceImage == nil) {
        return;
    }
    
    _sourceImage = sourceImage;
    
    //调整图片尺寸
    CGFloat iW = sourceImage.size.width;
    CGFloat iH = sourceImage.size.height;
    
    if (iW != self.frame.size.width) {
        iW = self.frame.size.width;
    }
    
    iH = sourceImage.size.height / sourceImage.size.width * iW;
    
    if (iH > self.frame.size.height) {
        iH = self.frame.size.height;
    }
    
    iW = sourceImage.size.width / sourceImage.size.height * iH;
    
    //把图片尺寸设置成self.bounds.size
    UIImage *image = [self jhImage:sourceImage scaleToSize:CGSizeMake(iW, iH)];
    _imageView.image = image;
    _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    _imageView.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
}

@end
