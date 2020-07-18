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

+(UILabel *)drawitemView:(UIView *)view andtitle:(NSString *)title
{
    UILabel *lbname = [[UILabel alloc] init];
    [lbname setTextColor:RGB(30, 30, 30)];
    [lbname setTextAlignment:NSTextAlignmentRight];
    [lbname setFont:[UIFont systemFontOfSize:13]];
    [lbname setText:title];
    [view addSubview:lbname];
    [lbname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.bottom.equalTo(view);
        make.width.offset(120);
    }];
    
    UIView *viewbck = [[UIView alloc] init];
    [viewbck.layer setMasksToBounds:YES];
    [viewbck.layer setCornerRadius:9];
    [viewbck setBackgroundColor:RGB(245, 245, 245)];
    [view addSubview:viewbck];
    [viewbck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbname.mas_right).offset(20);
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-20);
        make.height.offset(18);
    }];
    
    
    UILabel *lbvalue = [[UILabel alloc] init];
    [lbvalue setTextColor:RGB(30, 30, 30)];
    [lbvalue setTextAlignment:NSTextAlignmentLeft];
    [lbvalue setFont:[UIFont systemFontOfSize:13]];
    [lbvalue setText:title];
    [viewbck addSubview:lbvalue];
    [lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.bottom.equalTo(viewbck);
        make.right.equalTo(viewbck).offset(-15);
    }];
    
    
    return lbvalue;
}
///获取当前时间字符串
+(NSString *)dateChangeStringWith:(NSDate *)date andformat:(NSString *)strformat
{
    // 初始化时间格式控制器
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];

    // 设置设计格式    [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    
    if(strformat==nil)
    {
        [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    }
    else
    {
        [matter setDateFormat:strformat];
    }
    // 进行转换
    NSString *dateStr = [matter stringFromDate:date];
    return dateStr;
}

@end
