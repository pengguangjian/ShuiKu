//
//  ShuiChangListModel.h
//  ShuiKu
//
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShuiChangListModel : NSObject

///水厂ID
@property (nonatomic , strong) NSString *ID;
///水厂编码
@property (nonatomic , strong) NSString *CODE;
///水厂名称
@property (nonatomic , strong) NSString *NAME;
///经度
@property (nonatomic , strong) NSString *LGTD;
///纬度
@property (nonatomic , strong) NSString *LTTD;
///行政区划编码
@property (nonatomic , strong) NSString *ADDVCD;
///行政区划名称
@property (nonatomic , strong) NSString *ADDVNM;
///详细地址
@property (nonatomic , strong) NSString *ADDR;
///创建人
@property (nonatomic , strong) NSString *CREATEDBY;
///创建时间
@property (nonatomic , strong) NSString *CREATEDTIME;
///修改人
@property (nonatomic , strong) NSString *MODIFYBY;
///修改时间
@property (nonatomic , strong) NSString *MODIFYTIME;
///水厂状态
@property (nonatomic , strong) NSString *STATUS;
///备注
@property (nonatomic , strong) NSString *REMARK;
///供水能力
@property (nonatomic , strong) NSString *GSNL;
///水源地
@property (nonatomic , strong) NSString *SYD;
///服务片区
@property (nonatomic , strong) NSString *FUPQ;
///水源地类型
@property (nonatomic , strong) NSString *SYDLX;
///水源地所属流域
@property (nonatomic , strong) NSString *SYDSSLY;
///应急水源名称
@property (nonatomic , strong) NSString *YJSYMC;
///应急水源净水措施
@property (nonatomic , strong) NSString *YJSYJSCS;
///总投资
@property (nonatomic , strong) NSString *ZTZ;
///设计生产能力（万立方米/日）
@property (nonatomic , strong) NSString *SJSCNL;
///实际生产能力（万立方米/日）
@property (nonatomic , strong) NSString *SCNL;
///年供水总量（万立方米）
@property (nonatomic , strong) NSString *NGSZL;
///平均日生产水量(万立方米)
@property (nonatomic , strong) NSString *PJRSCSL;
///水厂设计压力（兆帕）
@property (nonatomic , strong) NSString *SCSJYL;
///出厂水压类型(1-重力流供水/2-加压供水)
@property (nonatomic , strong) NSString *CCSYLX;
///取水口地址
@property (nonatomic , strong) NSString *QSkDZ;
///取水管道总长度(公里)
@property (nonatomic , strong) NSString *YSGDZCD;
///供水管道总长度(公里)
@property (nonatomic , strong) NSString *GSGDZCD;
///供水工艺
@property (nonatomic , strong) NSString *GSGY;
///所属街道（乡镇）
@property (nonatomic , strong) NSString *SYJD;
///负责人
@property (nonatomic , strong) NSString *FZR;
///联系人
@property (nonatomic , strong) NSString *LXR;
///联系人电话
@property (nonatomic , strong) NSString *LXDH;
///邮政编码
@property (nonatomic , strong) NSString *YZBM;
///传真
@property (nonatomic , strong) NSString *CZ;
///建成区面积(平方公里)
@property (nonatomic , strong) NSString *JCMJ;
///供水面积(平方公里)
@property (nonatomic , strong) NSString *GSMJ;
///用水户数
@property (nonatomic , strong) NSString *YSHS;
///用水人数
@property (nonatomic , strong) NSString *YSRS;
///水质检测部门
@property (nonatomic , strong) NSString *SZJCBM;
///管网图纸扫描件(文件命名为：XX水厂管网图纸扫描件)
@property (nonatomic , strong) NSString *GWTZSMJ;
///水厂平面图扫描件(文件命名为：XX水厂平面图扫描件)
@property (nonatomic , strong) NSString *SCPMTSMJ;
///00:正常；01：预警；02：维修；03：异常   
@property (nonatomic , strong) NSString *RUNSTATE;


+(NSMutableArray *)initDataValue:(NSArray *)value;



@end

NS_ASSUME_NONNULL_END
