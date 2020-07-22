//
//  LiuLiangFenXiModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/22.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuLiangFenXiModel : NSObject
///进水
@property (nonatomic , strong) NSString *s_type;
///年份
@property (nonatomic , strong) NSString *s_time;
///累计水量
@property (nonatomic , strong) NSString *total;
///最大瞬时流量
@property (nonatomic , strong) NSString *max_Q;
///最小瞬时流量
@property (nonatomic , strong) NSString *min_Q;



+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
