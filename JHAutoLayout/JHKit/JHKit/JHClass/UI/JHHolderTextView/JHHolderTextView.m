//
//  JHHolderTextView.m
//  JHKit
//
//  Created by HaoCold on 2017/4/1.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

#import "JHHolderTextView.h"

@interface JHHolderTextView()<UITextViewDelegate>

@property (nonatomic,   strong) UITextView      *textView;
@property (nonatomic,   strong) UILabel         *label;

@end

@implementation JHHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jhSetupViews:frame];
    }
    return self;
}

- (void)jhSetupViews:(CGRect)frame
{
    [self addSubview:({[[UIView alloc] init];})];
    
    CGFloat X = 10;
    CGFloat Y = 5;
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(X, Y, frame.size.width-2*X, frame.size.height-2*Y);
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate = self;
    textView.showsVerticalScrollIndicator = NO;
    [self addSubview:textView];
    _textView = textView;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(X, textView.frame.origin.y+10, frame.size.width-2*X, 14);
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    label.font = textView.font;
    label.text = @" 请在此输入内容";
    [self addSubview:label];
    _label = label;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _label.hidden = YES;
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    [self jhCount:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self jhCount:textView];
}

- (void)jhCount:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _label.hidden = NO;
    }else{
        _label.hidden = YES;
    }
}

- (NSString *)jhText{
    return _textView.text;
}

- (void)setJhHolder:(NSString *)jhHolder{
    _label.text = jhHolder;
}

@end
