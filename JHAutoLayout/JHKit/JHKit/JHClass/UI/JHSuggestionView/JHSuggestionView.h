//
//  JHSuggestionView.h
//  BaseProject
//
//  Created by HaoCold on 16/11/2.
//  Copyright © 2016年 HN. All rights reserved.
//

/**< 反馈意见，图片选择(3张) */
#import <UIKit/UIKit.h>

@interface JHSuggestionView : UIView

@property (copy,    nonatomic) void (^addImageBlock)();

/**< 添加图片 */
- (void)addImage:(UIImage *)image;

/**< 返回图片 */
- (NSArray *)getAllImage;

@end
