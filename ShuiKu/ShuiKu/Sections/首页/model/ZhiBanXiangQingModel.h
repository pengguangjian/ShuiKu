//
//  ZhiBanXiangQingModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhiBanXiangQingModel : NSObject

///值班日期 2020-06-08 00:00:00
@property (nonatomic , strong) NSString *DUTYTIME;
///水厂名
@property (nonatomic , strong) NSString *SCNAME;
///填写人
@property (nonatomic , strong) NSString *CREATEDUSERNAME;
///填写时间
@property (nonatomic , strong) NSString *CREATEDTIME;
///值班记录
@property (nonatomic , strong) NSString *DUTYRECORD;
///备注
@property (nonatomic , strong) NSString *REMARK;


+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
