//
//  WenDuTJSonView.h
//  ShuiKu
//
//  Created by Mac on 2020/7/14.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineZuoBiaoView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WenDuTJSonView : UIView

@property (nonatomic , strong) LineZuoBiaoView *xianview;

@property (nonatomic , strong) NSString *strYValue;
@property (nonatomic , strong) NSString *strXValue;
///日统计 所有水厂
@property (nonatomic , strong) NSString *strtitle;
///PH值统计
@property (nonatomic , strong) NSString *strtitle1;

@property (nonatomic , strong) NSMutableArray *arrtime;
@property (nonatomic , strong) NSMutableArray *arrlinedata;
@end

NS_ASSUME_NONNULL_END
