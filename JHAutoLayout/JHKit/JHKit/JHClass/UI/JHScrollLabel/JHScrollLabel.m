//
//  XJHScrollLabel.m
//
//  Created by Lightech on 15-1-10.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "JHScrollLabel.h"

@interface JHScrollLabel()
@property (strong,  nonatomic) UILabel  *jhLabel;
@end

@implementation JHScrollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = YES;
        self.backgroundColor = [UIColor clearColor];
        _jhLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addTapEvent];
    }
    return self;
}

- (void)setText:(NSString *)text{
    //动态长度
    CGSize size = CGSizeMake(MAXFLOAT, _jhLabel.frame.size.height);
    UIFont *font = _jhLabel.font==nil?[UIFont systemFontOfSize:17]:_jhLabel.font;
    NSDictionary *dic = [[NSDictionary alloc]
                         initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    size = [text boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic context:nil].size;
    _jhLabel.frame = CGRectMake(0, 0, size.width,size.height);
}

- (void)setFont:(UIFont *)font{
    _jhLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor{
    _jhLabel.textColor = textColor;
}

- (id)initWithFrame:(CGRect)frame withSize:(CGSize)size
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentSize = size;
        
        [self addTapEvent];
    }
    return self;
}

+ (JHScrollLabel *)labelWithTitle:(NSString *)title
                         withFont:(UIFont *)font
                    withTextColor:(UIColor *)textColor
                        withFrame:(CGRect)frame
              withBackgroundColor:(UIColor *)bgcolor
{
    //动态长度
    CGSize size = CGSizeMake(MAXFLOAT, frame.size.height);
    NSDictionary *dic = [[NSDictionary alloc]
                         initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    size = [title boundingRectWithSize:size
                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                            attributes:dic context:nil].size;
    
    JHScrollLabel *scrollLabel = [[JHScrollLabel alloc] initWithFrame:frame
                                                             withSize:size];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, size.width, frame.size.height);
    label.text = title;
    label.font = font;
    label.textColor = textColor;
    
    if (bgcolor == nil){
        label.backgroundColor = [UIColor clearColor];
    }else{
        label.backgroundColor = bgcolor;
    }
    [scrollLabel addSubview:label];
    
    return scrollLabel;
}

- (void)addTapEvent
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                           action:@selector(didTap)];
    [self addGestureRecognizer:tap];
}

- (void)didTap
{
    if (self.clickBlock)
    {
        self.clickBlock();
    }
}

@end
