//
//  LiuLiangJCXiangQingModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/22.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuLiangJCXiangQingModel : NSObject

///测站编码
@property (nonatomic , strong) NSString *STCD;
///监测时间
@property (nonatomic , strong) NSString *TM;
///进水瞬时流量
@property (nonatomic , strong) NSString *Q0;
///进水累计流量
@property (nonatomic , strong) NSString *W0;
///出水瞬时流量
@property (nonatomic , strong) NSString *Q1;
///出水累计流量
@property (nonatomic , strong) NSString *W1;

+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
