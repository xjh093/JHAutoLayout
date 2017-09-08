//
//  JHImageClipView.h
//  JHLoadingView
//
//  Created by HaoCold on 2016/11/21.
//  Copyright © 2016年 HaoCold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHImageClipView : UIView

@property (strong,  nonatomic) UIImage          *sourceImage; /**< 要裁剪的图片 */

- (instancetype)init __attribute__((unavailable("Use -initWithFrame instead")));

- (UIImage *)jh_clip_image; /**< 获取裁剪的图片 */

@end
