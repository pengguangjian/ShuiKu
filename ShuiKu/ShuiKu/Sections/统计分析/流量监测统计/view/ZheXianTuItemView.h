//
//  ZheXianTuItemView.h
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineZuoBiaoView.h"
NS_ASSUME_NONNULL_BEGIN


@interface ZheXianTuItemView : UIView

@property (nonatomic , strong) LineZuoBiaoView *xianview;

@property (nonatomic , strong) NSString *strYValue;
@property (nonatomic , strong) NSString *strXValue;
///日统计 所有水厂
@property (nonatomic , strong) NSString *strtitle;
///PH值统计
@property (nonatomic , strong) NSString *strtitle1;

@property (nonatomic , strong) NSMutableArray *arrXArr;
///线的数据
@property (nonatomic , strong) NSMutableArray *arrLineData;
@property (nonatomic , strong) NSMutableArray *arrLineColor;
-(void)addLine;

@end

NS_ASSUME_NONNULL_END
