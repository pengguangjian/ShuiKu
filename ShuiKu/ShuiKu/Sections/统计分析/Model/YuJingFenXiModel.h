//
//  YuJingFenXiModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuJingFenXiModel : NSObject

///预警类型1:流量 2:浊度 3:温度 4:pH值 5:余氯
@property (nonatomic , strong) NSString *s_type;
///年份
@property (nonatomic , strong) NSString *s_time;
///预警次数
@property (nonatomic , strong) NSString *total;




+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
