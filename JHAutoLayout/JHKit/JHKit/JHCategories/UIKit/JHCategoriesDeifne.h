//
//  JHCategoryDefine.h
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//

#ifndef JHCategoryDefine_h
#define JHCategoryDefine_h

#ifdef DEBUG
 #if 0
  #define JHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
 #else
  #define JHLog(...)
 #endif
#else
 #define JHLog(...)
#endif

#define JHFRAME(frame) [NSValue valueWithCGRect:frame]
#define JHSIZE(size)   [NSValue valueWithCGSize:size]

//.h
#define JH_addToView_h(jhclass)   - (jhclass *(^)(id))jh_addToView;
#define JH_align_h(jhclass)       - (jhclass *(^)(id))jh_align;
#define JH_alpha_h(jhclass)       - (jhclass *(^)(id))jh_alpha;
#define JH_bdColor_h(jhclass)     - (jhclass *(^)(id))jh_bdColor;
#define JH_bdWidth_h(jhclass)     - (jhclass *(^)(id))jh_bdWidth;
#define JH_bgColor_h(jhclass)     - (jhclass *(^)(id))jh_bgColor;
#define JH_cnRadius_h(jhclass)    - (jhclass *(^)(id))jh_cnRadius;
#define JH_color_h(jhclass)       - (jhclass *(^)(id))jh_color;
#define JH_delegate_h(jhclass)    - (jhclass *(^)(id))jh_delegate;
#define JH_font_h(jhclass)        - (jhclass *(^)(id))jh_font;
#define JH_frame_h(jhclass)       - (jhclass *(^)(id))jh_frame;
#define JH_mtBounds_h(jhclass)    - (jhclass *(^)(id))jh_mtBounds;
#define JH_tag_h(jhclass)         - (jhclass *(^)(id))jh_tag;
#define JH_text_h(jhclass)        - (jhclass *(^)(id))jh_text;

#define JH_new_h(jhclass)         + (jhclass *(^)(  ))jh_new;

//.m
#define JH_addToView_m(jhclass) \
- (jhclass *(^)(id))jh_addToView{ \
    JHLog(); \
    return ^id(id view){ \
        if ([view isKindOfClass:[UIView class]]) { \
            [view addSubview:self]; \
        } \
        return self; \
    }; \
}

#define JH_align_m(jhclass) \
- (jhclass *(^)(id))jh_align{ \
    JHLog(); \
    return ^id(id align){ \
        if ([align isKindOfClass:[NSNumber class]]) { \
            self.textAlignment = [align integerValue]; \
        } \
        return self; \
    }; \
}

#define JH_alpha_m(jhclass) \
- (jhclass *(^)(id))jh_alpha{ \
    JHLog(); \
    return ^id(id alpha){ \
        if ([alpha isKindOfClass:[NSNumber class]]) { \
            self.alpha = [alpha floatValue]; \
        } \
        return self; \
    }; \
}

#define JH_bdColor_m(jhclass) \
- (jhclass *(^)(id))jh_bdColor{ \
    JHLog(); \
    return ^id(id bdColor){ \
        if([bdColor isKindOfClass:[UIColor class]]){ \
            self.layer.borderColor = [bdColor CGColor]; \
        }else if ([bdColor isKindOfClass:[NSString class]]){ \
            self.layer.borderColor = [[UIColor jhColor:bdColor] CGColor]; \
        } \
        return self; \
    }; \
}

#define JH_bdWidth_m(jhclass) \
- (jhclass *(^)(id))jh_bdWidth{ \
    JHLog(); \
    return ^id(id bdWidth){ \
        if([bdWidth isKindOfClass:[NSNumber class]]){ \
            self.layer.borderWidth = [bdWidth floatValue]; \
        } \
        return self; \
    };\
}

#define JH_bgColor_m(jhclass) \
- (jhclass *(^)(id))jh_bgColor{ \
    JHLog(); \
    return  ^id(id color){ \
        if ([color isKindOfClass:[UIColor class]]) { \
            self.backgroundColor = color; \
        }else if ([color isKindOfClass:[NSString class]]){ \
            self.backgroundColor = [UIColor jhColor:color]; \
        } \
        return self; \
    }; \
}

#define JH_cnRadius_m(jhclass) \
- (jhclass *(^)(id))jh_cnRadius{ \
    JHLog(); \
    return ^id(id cnRadius){ \
        if([cnRadius isKindOfClass:[NSNumber class]]){ \
            self.layer.cornerRadius = [cnRadius floatValue]; \
        } \
        return self; \
    }; \
}

#define JH_color_m(jhclass) \
- (jhclass *(^)(id))jh_color{ \
    JHLog(); \
    return ^id(id color){ \
        if ([color isKindOfClass:[UIColor class]]) { \
            self.textColor = color; \
        }else if ([color isKindOfClass:[NSString class]]){ \
            self.textColor = [UIColor jhColor:color]; \
        } \
        return self; \
    }; \
}

#define JH_delegate_m(jhclass) \
- (jhclass *(^)(id))jh_delegate{ \
    JHLog(); \
    return ^id(id delegate){ \
        if ([delegate isKindOfClass:[UIViewController class]] || \
            [delegate isKindOfClass:[UIView class]]) { \
            self.delegate = delegate; \
        } \
        return self; \
    }; \
}

#define JH_font_m(jhclass) \
- (jhclass *(^)(id))jh_font{ \
    JHLog(); \
    return ^id(id font){ \
        if ([font isKindOfClass:[UIFont class]]) { \
            self.font = font; \
        }else if ([font isKindOfClass:[NSString class]]){ \
            self.font = [UIFont jhFont:font]; \
        } \
        else if ([font isKindOfClass:[NSNumber class]]){ \
            self.font = [UIFont jhFont:[NSString stringWithFormat:@"%@",font]]; \
        } \
        return self; \
    }; \
}

#define JH_frame_m(jhclass) \
- (jhclass *(^)(id))jh_frame{ \
    JHLog(); \
    return ^id(id frame){ \
        if ([frame isKindOfClass:[NSValue class]]) { \
            self.frame = [frame CGRectValue]; \
        }else if ([frame isKindOfClass:[NSString class]]){ \
            if ([frame hasPrefix:@"{"]) { \
                self.frame = CGRectFromString(frame); \
            }else if ([frame hasPrefix:@"["]){ \
                self.frame = [self jhRectFromString:frame]; \
            }else{ \
                self.frame = CGRectZero; \
            } \
        } \
        return self; \
    }; \
}

#define JH_mtBounds_m(jhclass) \
- (jhclass *(^)(id))jh_mtBounds{ \
    JHLog(); \
    return ^id(id mtBounds){ \
        if([mtBounds isKindOfClass:[NSNumber class]]){ \
            self.layer.masksToBounds = [mtBounds floatValue]; \
        } \
        return self; \
    }; \
}

#define JH_new_m(jhclass) \
+ (jhclass *(^)())jh_new{ \
    return ^id(){ \
        return [[self class] new]; \
    }; \
}

#define JH_tag_m(jhclass) \
- (jhclass *(^)(id))jh_tag{ \
    JHLog(); \
    return ^id(id tag){ \
        if ([tag isKindOfClass:[NSNumber class]]) { \
            self.tag = [tag integerValue]; \
        } \
        return self; \
    }; \
}

#define JH_text_m(jhclass) \
- (jhclass *(^)(id))jh_text{ \
    JHLog(); \
    return ^id(id text){ \
        if ([text isKindOfClass:[NSString class]]) { \
            self.text = text; \
        } \
        return self; \
    }; \
}

#endif
