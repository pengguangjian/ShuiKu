//
//  ZhiBanInfoModel.h
//  ShuiKu
//  值班信息model
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhiBanInfoModel : NSObject

///未值班
@property (nonatomic , strong) NSString *NoDuty;
///值班
@property (nonatomic , strong) NSString *OnDuty;
///未值班日期 2020-06-08 00:00:00
@property (nonatomic , strong) NSString *DUTYTIME;

+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
