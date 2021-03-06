//
//  CeZhanJianCeTJView.h
//  ShuiKu
//
//  Created by Mac on 2020/7/12.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CeZhanJianCeTJView : UIView

@property (nonatomic , strong) NSString *strYValue;
@property (nonatomic , strong) NSString *strXValue;
///日统计 所有水厂
@property (nonatomic , strong) NSString *strtitle;
///PH值统计
@property (nonatomic , strong) NSString *strtitle1;

///设置arrX x轴数据     arrYValue y轴数据
-(void)setXzhouValue:(NSMutableArray *)arrX andKeyValue:(NSMutableArray *)arrYValue;


@end

NS_ASSUME_NONNULL_END
