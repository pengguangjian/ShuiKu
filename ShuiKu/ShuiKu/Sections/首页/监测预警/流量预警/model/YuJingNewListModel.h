//
//  YuJingNewListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/25.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuJingNewListModel : NSObject

///
@property (nonatomic , strong) NSString *peta_rn;
///预警ID
@property (nonatomic , strong) NSString *ID;
///预警测站编码
@property (nonatomic , strong) NSString *SWSTCD;
///预警测站名称
@property (nonatomic , strong) NSString *SWSTNM;
///超标值
@property (nonatomic , strong) NSString *SWVALUE;
///预警类型 1:流量 2:浊度 3:温度 4:pH值 5:余氯
@property (nonatomic , strong) NSString *SWTYPE;
///预警等级，1：蓝色预警；2：黄色预警；3：橙色预警；4：红色预警；
@property (nonatomic , strong) NSString *SWLEVEL;
///预警时间
@property (nonatomic , strong) NSString *SWTM;
///是否自动填报 1：是；0：否
@property (nonatomic , strong) NSString *AUTO;
///创建时间
@property (nonatomic , strong) NSString *CREATEDTIME;
///创建人
@property (nonatomic , strong) NSString *CREATEDBY;
///测站状态
@property (nonatomic , strong) NSString *STATUS;
///预警状态，1：新产生；2：已发布；3：响应中；4：已关闭； 5 已忽略；
@property (nonatomic , strong) NSString *FLAG;
///预警维度 1：超最大值  0：低最小值
@property (nonatomic , strong) NSString *SYMBOL;
///负责人
@property (nonatomic , strong) NSString *FZR;
///联系电话
@property (nonatomic , strong) NSString *LXDH;
///所属水厂
@property (nonatomic , strong) NSString *NAME;

@property (nonatomic , strong) NSString *SWINDEX;

+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
