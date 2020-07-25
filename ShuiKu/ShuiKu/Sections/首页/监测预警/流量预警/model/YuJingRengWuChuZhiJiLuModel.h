//
//  YuJingRengWuChuZhiJiLuModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuJingRengWuChuZhiJiLuModel : NSObject
///处置人
@property (nonatomic , strong) NSString *HANDLER_NM;
///创建时间
@property (nonatomic , strong) NSString *CREATEDTIME;
///处理类型，0 新建，1 处置，2 通知，3 督办
@property (nonatomic , strong) NSString *TYPE;
///状态 0：正在处置 1：处置完成
@property (nonatomic , strong) NSString *STATUS;
///描述
@property (nonatomic , strong) NSString *DESCRIPTION;
///任务结果  （？？？？？）0 处置，1 通知，2 督办
@property (nonatomic , strong) NSString *RESULT;
///备注
@property (nonatomic , strong) NSString *REMARK;



+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
