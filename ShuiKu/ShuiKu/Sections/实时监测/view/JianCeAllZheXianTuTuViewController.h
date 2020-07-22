//
//  JianCeAllZheXianTuTuViewController.h
//  ShuiKu
//
//  Created by Mac on 2020/7/19.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JianCeAllZheXianTuTuViewController : UIViewController

@property (nonatomic , strong) NSString *strYValue;
@property (nonatomic , strong) NSString *strXValue;
///日统计 所有水厂
@property (nonatomic , strong) NSString *strtitle;
///PH值统计
@property (nonatomic , strong) NSString *strtitle1;
///x轴数据
@property (nonatomic , strong) NSArray *arrX;
///线条信息（最大进水流量，最小进水流量……）
@property (nonatomic , strong) NSArray *arrinfo;

///1234567 流量监测、浊度监测、余氯监测、温度监测、ph监测、水质监测 综合监测
@property (nonatomic , assign) NSInteger type;
///流量监测、浊度监测、余氯监测、温度监测、ph监测、水质监测
@property (nonatomic , strong) NSString *stcd;
///综合监测瞬时和累计
@property (nonatomic , strong) NSString *stcd1;
///其他
@property (nonatomic , strong) NSString *stcd2;
@end

NS_ASSUME_NONNULL_END
