//
//  JHTableViewCell.m
//  JHKit
//
//  Created by HaoCold on 16/8/12.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import "JHTableViewCell.h"

static NSString *cellID = nil;

@implementation JHTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *classStr = NSStringFromClass(self);
    
    cellID = [NSString stringWithFormat:@"%@ID",classStr];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    /**< Incompatible pointer types returning */
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return cell;
#pragma clang diagnostic pop
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self jhSetupViews];
    }
    return self;
}

- (void)jhSetupViews
{
    
}

#if 0
- (UIView *)jhCellAddView:(CGRect)frame bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = bgColor;
    [self.contentView addSubview:view];
    return view;
}

- (UIImageView *)jhCellAddImageView:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    [self.contentView addSubview:imageView];
    return imageView;
}

- (UILabel *)jhCellAddLabel:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    [self.contentView addSubview:label];
    return label;
}

- (UIButton *)jhCellAddButton:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [self.contentView addSubview:button];
    return button;
}

#else
- (UIView *)jhSetupView:(CGRect)frame bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] init];
    view.frame = frame;
    view.backgroundColor = bgColor;
    [self.contentView addSubview:view];
    return view;
}

- (UIImageView *)jhSetupImageView:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    [self.contentView addSubview:imageView];
    return imageView;
}

- (UILabel *)jhSetupLabel:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    [self.contentView addSubview:label];
    return label;
}

- (UIButton *)jhSetupButton:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [self.contentView addSubview:button];
    return button;
}
#endif

@end
