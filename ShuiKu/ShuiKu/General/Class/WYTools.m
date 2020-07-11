//
//  WYTools.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WYTools.h"
#import "BDKNotifyHUD.h"

@implementation WYTools

//lb计算文本的宽和高
+(CGSize)countTextSize:(CGSize)size andtextfont:(UIFont *)font andtext:(NSString *)str
{
    CGSize detailsLabSize = size;
    NSDictionary *detailsLabAttribute = @{NSFontAttributeName: font};
    //ios7方法，获取文本需要的size
    CGSize  msize =[str boundingRectWithSize:detailsLabSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:detailsLabAttribute context:nil].size;
    return msize;
}

+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view{
    if (notify_str) {
        BDKNotifyHUD *noti=[BDKNotifyHUD notifyHUDWithImage:nil text:notify_str];
        noti.center = CGPointMake(view.center.x, view.center.y );
        [view addSubview:noti];
        [noti presentWithDuration:1.0 speed:0.5 inView:view completion:^{
            [noti removeFromSuperview];
        }];
    }
}

@end
