//
//  DateValueFormatter.m
//  ShuiKu
//
//  Created by Mac on 2020/8/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "DateValueFormatter.h"


@interface DateValueFormatter ()
{
    NSArray * _arr;
}

@end
@implementation DateValueFormatter

-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return _arr[(NSInteger)value];
}

@end
