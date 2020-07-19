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

@end

NS_ASSUME_NONNULL_END
