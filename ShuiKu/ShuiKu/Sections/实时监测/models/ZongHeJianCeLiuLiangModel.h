//
//  ZongHeJianCeLiuLiangModel.h
//  ShuiKu
//  综合监测流量model
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZongHeJianCeLiuLiangModel : NSObject

///监测时间
@property (nonatomic , strong) NSString *TM;
///进水瞬时流量
@property (nonatomic , strong) NSString *Q0;
///出水瞬时流量
@property (nonatomic , strong) NSString *Q1;
///进水累计流量
@property (nonatomic , strong) NSString *W0;
///出水累计流量
@property (nonatomic , strong) NSString *W1;

+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
