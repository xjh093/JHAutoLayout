//
//  JHPhotoChangeManager.m
//  BaseProject
//
//  Created by HaoCold on 16/9/20.
//  Copyright © 2016年 HN. All rights reserved.
//

#import "JHPhotoChangeManager.h"

@interface JHPhotoChangeManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (copy,    nonatomic) void (^imageBlock)(UIImage *image);

@property (weak,    nonatomic) UIViewController     *vc;

@end

@implementation JHPhotoChangeManager

+ (instancetype)manager{
    static JHPhotoChangeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHPhotoChangeManager alloc] init];
    });
    return manager;
}

- (void)showInVC:(UIViewController *)vc image:(void(^)(UIImage *image))image{
    
    //保存block
    _imageBlock = image;
    _vc = vc;
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self jhTakePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self jhOpenLocalPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [sheet addAction:action1];
    [sheet addAction:action2];
    [sheet addAction:action3];
    
    [vc presentViewController:sheet animated:YES completion:nil];
}

- (void)jhHandleResult:(NSInteger)index
{
    if (1 == index) {  //拍照
        [self jhTakePhoto];
    }else if (2 == index){  //相册
        [self jhOpenLocalPhoto];
    }
}

- (void)jhTakePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [_vc presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
    
}

- (void)jhOpenLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES; //设置选择后的图片可被编辑
    [_vc presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (_imageBlock) {
        _imageBlock(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end







