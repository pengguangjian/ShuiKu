//
//  LiuLiangJCListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/21.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuLiangJCListModel : NSObject

///测站编码
@property (nonatomic , strong) NSString *STCD;
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
///所属水厂名称
@property (nonatomic , strong) NSString *NAME;
///测站状态 0：离线；1:在线
@property (nonatomic , strong) NSString *STATUS;

+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
