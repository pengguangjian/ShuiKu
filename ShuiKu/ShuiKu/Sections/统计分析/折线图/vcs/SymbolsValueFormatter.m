//
//  SymbolsValueFormatter.m
//  ShuiKu
//
//  Created by Mac on 2020/8/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "SymbolsValueFormatter.h"


@interface SymbolsValueFormatter ()

@end


@implementation SymbolsValueFormatter
-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}
//返回y轴的数据
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    
    return [NSString stringWithFormat:@"%.2f",(float)value];
}

@end
