//
//  JHKit.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#ifndef JHKit_h
#define JHKit_h

#import "JHUIKit.h"
#import "JHFoundationKit.h"

#endif

/**< 

.jh_addToView(<#spview#>)
.jh_frame(@"[x:,y:,w:,h:]")
.jh_tag(@(100));

JH_LAZY_STRONG_UI(UIView, <#view#>, ({
    UIView
    .jhView()
    .jh_bgColor(@"0xeeeeee");
}))


JH_LAZY_STRONG_UI(UILabel, <#label#>, ({
    UILabel
    .jhLabel()
    .jh_text(@"")
    .jh_color(@"0x000000")
    .jh_font(@(16))
    .jh_align(@(1));
}))

JH_LAZY_STRONG_UI(UIButton, <#button#>, ({
    UIButton
    .jhButton(@(0))
    .jh_title(@"")
    .jh_color(@"0x000000")
    .jh_image(@"name")
    .jh_bgColor(@"0xeeeeee")
    .jh_target_selector_event(self,@"jhButtonEvent:",@(1<<6));
}))

JH_LAZY_STRONG_UI(UITextField, <#textField#>, ({
    UITextField
    .jhTextField()
    .jh_pHolder(@"在此输入内容")
    .jh_lvMode(@(3))
    .jh_lfView(({
        UIView
        .jh_view()
        .jh_frame(@"{{0,0},{5,5}}");
    }));
}))
 */
