//
//  JHTableViewCell.h
//  JHKit
//
//  Created by HaoCold on 16/8/12.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

/**< 
 
子类继承，并实现方法：
- (void)jhSetupViews;
 
 */

#import <UIKit/UIKit.h>

@interface JHTableViewCell : UITableViewCell

@property (strong,  nonatomic) NSIndexPath      *cellIndexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

#if 0
- (UIView *)jhCellAddView:(CGRect)frame bgColor:(UIColor *)bgColor;
- (UIImageView *)jhCellAddImageView:(CGRect)frame;
- (UILabel *)jhCellAddLabel:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font;
- (UIButton *)jhCellAddButton:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font;
#else
- (UIView *)jhSetupView:(CGRect)frame bgColor:(UIColor *)bgColor;
- (UIImageView *)jhSetupImageView:(CGRect)frame;
- (UILabel *)jhSetupLabel:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font;
- (UIButton *)jhSetupButton:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(CGFloat)font;
#endif
@end
