//
//  UITextField+JHCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#import "UITextField+JHCategory.h"
#import "UIView+JHCategory.h"
#import "UIFont+JHCategory.h"
#import "UIColor+JHCategory.h"

@implementation UITextField (JHCategory)

JH_new_m(UITextField)
JH_tag_m(UITextField)
JH_bind_m(UITextField)
JH_text_m(UITextField)
JH_font_m(UITextField)
JH_align_m(UITextField)
JH_color_m(UITextField)
JH_frame_m(UITextField)
JH_alpha_m(UITextField)
JH_bgColor_m(UITextField)
JH_bdColor_m(UITextField)
JH_bdWidth_m(UITextField)
JH_cnRadius_m(UITextField)
JH_mtBounds_m(UITextField)
JH_delegate_m(UITextField)
JH_addToView_m(UITextField)

+ (UITextField *(^)())jh_textField{
    return ^id(){
        UITextField *textField = [[UITextField alloc] init];
        return textField;
    };
}

- (UITextField *(^)(id))jh_bdStyle{
    JHLog();
    return ^id(id bdStyle){
        if ([bdStyle isKindOfClass:[NSNumber class]]) {
            self.borderStyle = [bdStyle integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_pHolder{
    JHLog();
    return ^id(id pHolder){
        if ([pHolder isKindOfClass:[NSString class]]) {
            self.placeholder = pHolder;
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_pHColor{
    JHLog();
    return ^id(id pHColor){
        [self setValue:[UIColor jhColor:pHColor] forKeyPath:@"_placeholderLabel.textColor"];
        return self;
    };
}
- (UITextField *(^)(id))jh_pHFont{
    JHLog();
    return ^id(id pHFont){
        [self setValue:[UIFont jhFont:pHFont] forKeyPath:@"_placeholderLabel.font"];
        return self;
    };
}
- (UITextField *(^)(id))jh_cbMode{
    JHLog();
    return ^id(id cbMode){
        if ([cbMode isKindOfClass:[NSNumber class]]) {
            self.clearButtonMode = [cbMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_lvMode{
    JHLog();
    return ^id(id lvMode){
        if ([lvMode isKindOfClass:[NSNumber class]]) {
            self.leftViewMode = [lvMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_rvMode{
    JHLog();
    return ^id(id rvMode){
        if ([rvMode isKindOfClass:[NSNumber class]]) {
            self.rightViewMode = [rvMode integerValue];
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_lfView{
    JHLog();
    return ^id(id lfView){
        if ([lfView isKindOfClass:[UIView class]]) {
            self.leftView = lfView;
        }
        return self;
    };
}
- (UITextField *(^)(id))jh_rtView{
    JHLog();
    return ^id(id rtView){
        if ([rtView isKindOfClass:[UIView class]]) {
            self.rightView = rtView;
        }
        return self;
    };
}

@end
