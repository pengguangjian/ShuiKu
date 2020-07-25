//
//  ShiPinJcShuiChangListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShiPinJcShuiChangListModel : NSObject
///设备编码
@property (nonatomic , strong) NSString *indexCode;
///
@property (nonatomic , strong) NSString *name;
///
@property (nonatomic , strong) NSString *updateTime;

+(NSMutableArray *)initDataValue:(NSArray *)value;



@end

NS_ASSUME_NONNULL_END
