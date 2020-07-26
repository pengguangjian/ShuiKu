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
///顶部信息
@property (nonatomic , strong) NSArray *arrinfo;

///1流量监测、2浊度监测、3余氯监测、4温度监测、5ph监测、6水质监测 7综合监测
@property (nonatomic , assign) NSInteger type;
///1浊度图  2余氯图    3温度图   4ph图   5瞬时流量图   6累计流量图
@property (nonatomic , assign) NSInteger typeson;

///流量监测、浊度监测、余氯监测、温度监测、ph监测、水质监测 、综合监测瞬时和累计
@property (nonatomic , strong) NSString *stcd;



@end

NS_ASSUME_NONNULL_END
