//
//  WYTools.h
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYTools : NSObject
//lb计算文本的宽和高
+(CGSize)countTextSize:(CGSize)size andtextfont:(UIFont *)font andtext:(NSString *)str;


+(void)showNotifyHUDwithtext:(NSString *)notify_str inView:(UIView *)view;

///列表公共cell
+(UILabel *)drawitemView:(UIView *)view andtitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
