//
//  ShiPinJcShuiChangCamaListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShiPinJcShuiChangCamaListModel : NSObject

///设备编码
@property (nonatomic , strong) NSString *cameraIndexCode;
///设备名
@property (nonatomic , strong) NSString *cameraName;
///
@property (nonatomic , strong) NSString *updateTime;
///通道
@property (nonatomic , strong) NSString *channelTypeName;
///类型
@property (nonatomic , strong) NSString *cameraTypeName;

+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
