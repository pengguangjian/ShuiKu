//
//  JianCeMainListModel.h
//  ShuiKu
//  除综合监测和流量监测model
//  Created by Mac on 2020/7/26.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JianCeMainListModel : NSObject
///测站编码
@property (nonatomic , strong) NSString *STCD;
///监测时间
@property (nonatomic , strong) NSString *TM;
///来报时间
@property (nonatomic , strong) NSString *WTM;
///进水温度
@property (nonatomic , strong) NSString *WT0;
///出水温度
@property (nonatomic , strong) NSString *WT1;
///进水pH
@property (nonatomic , strong) NSString *PH0;
///出水pH
@property (nonatomic , strong) NSString *PH1;
///进水浊度
@property (nonatomic , strong) NSString *TURB0;
///出水浊度
@property (nonatomic , strong) NSString *TURB1;
///出水余氯
@property (nonatomic , strong) NSString *CL;
///所属水厂
@property (nonatomic , strong) NSString *NAME;
///测站状态 0：离线；1:在线
@property (nonatomic , strong) NSString *STATUS;


+(NSMutableArray *)initDataValue:(NSArray *)value;


@end

NS_ASSUME_NONNULL_END
