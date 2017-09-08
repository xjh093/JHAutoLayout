//
//  JHPhotoChangeManager.h
//  BaseProject
//
//  Created by HaoCold on 16/9/20.
//  Copyright © 2016年 HN. All rights reserved.
//

/**< 访问相册 与 拍照  改变头像等 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JHPhotoChangeManager : NSObject

+ (instancetype)manager;

- (void)showInVC:(UIViewController *)vc image:(void(^)(UIImage *image))image;

@end
