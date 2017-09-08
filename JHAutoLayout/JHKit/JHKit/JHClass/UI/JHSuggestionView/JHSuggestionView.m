//
//  JHSuggestionView.m
//  BaseProject
//
//  Created by HaoCold on 16/11/2.
//  Copyright © 2016年 HN. All rights reserved.
//

#import "JHSuggestionView.h"
#import "JHCategories.h"

@interface JHSuggestionView()

@property (strong,  nonatomic) NSMutableArray     *imageArray;
@property (assign,  nonatomic) BOOL                flag;

@end

@implementation JHSuggestionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)jhSetupViews:(CGRect)frame
{
    UIView *view =
    UIView
    .jhView()
    .jh_addToView(self)
    .jh_frame(JHFRAME(CGRectMake(0, 0, frame.size.width, frame.size.height)))
    .jh_tag(@(100));
    
    UIButton *button1 =
    UIButton
    .jhButton(@(0))
    .jh_addToView(self)
    .jh_frame(@"[x:15,y:0,w:h(100)*0.8,h:h(100)*0.8]")
    .jh_tag(@(101))
    .jh_target_selector_event(self,@"jhButtonEVent:",@(1<<6));
    button1.jh_center_y = view.center.y;
    
    UIButton *button2 =
    UIButton
    .jhButton(@(0))
    .jh_addToView(self)
    .jh_frame(@"[x:maxx(101)+15,y:y(101),w:w(101),h:h(101)]")
    .jh_tag(@(102))
    .jh_target_selector_event(self,@"jhButtonEVent:",@(1<<6));
    
    UIButton *button3 =
    UIButton
    .jhButton(@(0))
    .jh_addToView(self)
    .jh_frame(@"[x:maxx(102)+15,y:y(101),w:w(101),h:h(101)]")
    .jh_tag(@(103))
    .jh_target_selector_event(self,@"jhButtonEVent:",@(1<<6));
    
    UIButton
    .jhButton(@(0))
    .jh_addToView(self)
    .jh_frame(JHFRAME(button1.frame))
    .jh_image(@"add_photo")
    .jh_tag(@(104))
    .jh_target_selector_event(self,@"jhAddImage",@(1<<6));
    
    button1.hidden = YES;
    button2.hidden = YES;
    button3.hidden = YES;
    
    button1.exclusiveTouch = YES;
    button2.exclusiveTouch = YES;
    button3.exclusiveTouch = YES;
}

- (void)jhButtonEVent:(UIButton *)button
{
    [self jhDeleteImage:button.tag - 101];
}

- (void)jhDeleteImage:(NSInteger)index
{
    //移除的是最后一张
    if (self.imageArray.count == index+1) {
        [self.imageArray removeObjectAtIndex:index];
        
        UIButton *button = (UIButton *)[self viewWithTag:101+index];
        button.jh_bgImage(nil);
        button.hidden = YES;
        
        UIView *view = [self viewWithTag:104];
        view.frame = button.frame;
        view.hidden = NO;
    
    }else{
        [self.imageArray removeObjectAtIndex:index];
        
        for (NSInteger i = index; i < self.imageArray.count; i++) {
            UIButton *button = (UIButton *)[self viewWithTag:101+i];
            button.jh_bgImage(self.imageArray[i]);
            button.hidden = NO;
        }
        
        for (NSInteger i = self.imageArray.count; i < 3; i++) {
            UIView *view = [self viewWithTag:101+i];
            view.hidden = YES;
        }
        
        UIButton *button = (UIButton *)[self viewWithTag:101+self.imageArray.count];
        UIView *view = [self viewWithTag:104];
        view.frame = button.frame;
        view.hidden = NO;
    }
}

- (void)jhAddImage
{
    if (_addImageBlock) {
        _addImageBlock();
    }
}

- (void)addImage:(UIImage *)image
{
    if (image == nil) {
        return;
    }
    
    [self.imageArray addObject:image];
    NSInteger count = self.imageArray.count+100;
    
    UIButton *button = (UIButton *)[self viewWithTag:count];
    button.jh_bgImage(image);
    button.hidden = NO;
    
    if (count + 1 < 104) {
        UIView *view1 = [self viewWithTag:count+1];
        UIView *view2 = [self viewWithTag:104];
        view2.frame = view1.frame;
        view2.hidden = NO;
    }else{
        UIView *view = [self viewWithTag:104];
        view.hidden = YES;
    }
}

- (NSArray *)getAllImage{
    return self.imageArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[].mutableCopy;
    }
    return _imageArray;
}

@end
