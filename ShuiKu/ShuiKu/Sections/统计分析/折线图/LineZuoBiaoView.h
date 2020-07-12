//
//  LineZuoBiaoView.h
//  zhexiantuDemo
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBChart.h"
NS_ASSUME_NONNULL_BEGIN

@interface LineZuoBiaoView : UIView

///更新页面大小
-(void)setRefLinView:(CGRect)rect;

/// xArr：横坐标 arrvalue：值
-(id)initWithFrame:(CGRect)frame andXArr:(NSArray *)xArr;

///添加线
-(GBLineChartData *)addLine:(NSArray *)array andlinecolor:(UIColor *)color;

///先绘制线然后才调用该方法 展示 arrdatas[<GBLineChartData>];
-(void)showValue:(NSArray *)arrdatas;

@end

NS_ASSUME_NONNULL_END
