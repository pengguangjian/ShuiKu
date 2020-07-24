//
//  CeDianFenXiModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CeDianFenXiModel : NSObject

///预警类型1:流量 2:浊度 3:温度 4:pH值 5:余氯
@property (nonatomic , strong) NSString *NAME;
///流量在线率
@property (nonatomic , strong) NSString *flow_zxl;
///流量畅通率
@property (nonatomic , strong) NSString *flow_ctl;
///流量异常率
@property (nonatomic , strong) NSString *flow_ycl;
///水质在线率
@property (nonatomic , strong) NSString *wq_zxl;
///水质畅通率
@property (nonatomic , strong) NSString *wq_ctl;
///水质异常率
@property (nonatomic , strong) NSString *wq_ycl;


+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
