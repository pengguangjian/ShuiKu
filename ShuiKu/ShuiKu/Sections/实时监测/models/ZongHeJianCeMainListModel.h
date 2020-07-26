//
//  ZongHeJianCeMainListModel.h
//  ShuiKu
//  综合监测model
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZongHeJianCeMainListModel : NSObject
///水厂ID
@property (nonatomic , strong) NSString *ID;
///水厂编码
@property (nonatomic , strong) NSString *CODE;
///水厂地址
@property (nonatomic , strong) NSString *ADDR;
///水厂名称
@property (nonatomic , strong) NSString *NAME;
///水厂状态 0：离线；1：在线
@property (nonatomic , strong) NSString *STATUS;
///进水瞬时流量
@property (nonatomic , strong) NSString *YSQ;
///出水瞬时流量
@property (nonatomic , strong) NSString *CSQ;
///进水温度
@property (nonatomic , strong) NSString *YSWD;
///进水pH
@property (nonatomic , strong) NSString *YSPH;
///进水浊度
@property (nonatomic , strong) NSString *YSZD;
///出水温度
@property (nonatomic , strong) NSString *CSWD;
///出水pH
@property (nonatomic , strong) NSString *CSPH;
///出水浊度
@property (nonatomic , strong) NSString *CSZD;
///出水余氯
@property (nonatomic , strong) NSString *CSYL;
///负责人
@property (nonatomic , strong) NSString *FZR;
///联系电话
@property (nonatomic , strong) NSString *LXDH;

+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
