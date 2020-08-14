//
//  DateValueFormatter.h
//  ShuiKu
//
//  Created by Mac on 2020/8/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;
NS_ASSUME_NONNULL_BEGIN

@interface DateValueFormatter : NSObject<IChartAxisValueFormatter>
-(id)initWithArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
