//
//  CeZhanListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CeZhanListModel : NSObject
///petapoco排序
@property (nonatomic , strong) NSString *peta_rn;
///测站ID
@property (nonatomic , strong) NSString *STID;
///测站编码
@property (nonatomic , strong) NSString *STCD;
///测站名称
@property (nonatomic , strong) NSString *STNM;
///测站等级，1：国家级（重点）；2：国家级（一般）；3：省级；4：地（市）级
@property (nonatomic , strong) NSString *STGRD;
///进水/出水 0：进水；1：出水；2：其他
@property (nonatomic , strong) NSString *WSTYPE;
///测站类型，枚举，1 河道水位站 ；2 水库水位站 ；3 雨量站 ；4 水质站 ；5 生态流量站 ；6 取用水量站 ；7 图像站 ；8 视频站 ；
@property (nonatomic , strong) NSString *STTYPE;
///监测类型，位码，与测站类型保持一致
@property (nonatomic , strong) NSString *MNTP;
///测站所在经度
@property (nonatomic , strong) NSString *LGTD;
///测站所在纬度
@property (nonatomic , strong) NSString *LTTD;
///测站站址
@property (nonatomic , strong) NSString *STLC;
///所在行政区划名称
@property (nonatomic , strong) NSString *ADDVNM;
///所在行政区划编码
@property (nonatomic , strong) NSString *ADDVCD;
///监测频次，-次/年
@property (nonatomic , strong) NSString *MNFRQ;
///是否为自动站
@property (nonatomic , strong) NSString *AUTO;
///建站年月
@property (nonatomic , strong) NSString *ESSTYM;
///始报年月
@property (nonatomic , strong) NSString *BGFRYM;
///撤站年月
@property (nonatomic , strong) NSString *WDSTYM;
///管理单位名称
@property (nonatomic , strong) NSString *ADAG;
///监测单位名称
@property (nonatomic , strong) NSString *MNAG;
///数据来源
@property (nonatomic , strong) NSString *SOURCE;
///所属对象标识
@property (nonatomic , strong) NSString *OWNER_ID;
///所属对象名称
@property (nonatomic , strong) NSString *OWNER_NM;
///创建人员
@property (nonatomic , strong) NSString *STULID;
///创建时间
@property (nonatomic , strong) NSString *STCRTM;
///测站状态
@property (nonatomic , strong) NSString *STATUS;
///数据状态
@property (nonatomic , strong) NSString *FLAG;
///备注
@property (nonatomic , strong) NSString *REMARK;
///负责人
@property (nonatomic , strong) NSString *FZR;
///联系电话
@property (nonatomic , strong) NSString *LXDH;
///所属水厂
@property (nonatomic , strong) NSString *NAME;
///详细地址
@property (nonatomic , strong) NSString *ADDR;


+(NSMutableArray *)initDataValue:(NSArray *)value;

@end

NS_ASSUME_NONNULL_END
