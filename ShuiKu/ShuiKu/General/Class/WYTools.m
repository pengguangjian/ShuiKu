//
//  WYTools.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WYTools.h"

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

@end
