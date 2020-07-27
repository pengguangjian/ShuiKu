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

///获取当前时间字符串
+(NSString *)dateChangeStringWith:(NSDate *)date andformat:(NSString *)strformat;

///对string进行sha1编码：
+(NSString *)stringWithSha1Encode:(NSString *)strvalue;

///model
+(id)initDicValue:(NSDictionary *)value andclassname:(NSString *)classname;
///数组形数据model
+(NSMutableArray *)initArrValue:(NSArray *)value andclassname:(NSString *)classname;

///字母小写转大写
+(NSString *)stringToUpper:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
